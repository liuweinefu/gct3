'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class MixController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'Member',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [], 
            // noUpdateAttributes: [],
            // includeModelNameArray:['User','UserType'],//用'#'分割嵌套模型,//用'#'分割嵌套模型
            includeModelNameArray: ['Card#CardType'],
            tplName: 'Mix.tpl',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }

    async settlement() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        // const O = ctx.controllerOption; 
        const SS = ctx.session;



        //校验当前客户信息
        var currentRow = JSON.parse(B.currentRow);
        // const DbMember = await M.Member.findById(currentRow.id, { include: [{ model: M.Card, include: [M.CardType] }] });
        if (!currentRow.id || !currentRow.Card || !currentRow.Card.id || currentRow.Card.id != SS.currentCardId) {
            ctx.response.body = {
                message: '当前用户数据出错'
            };
            return;
        }
        const DbMember = await M.Member.findById(currentRow.id, { include: [M.Card] });
        const DbCard = await M.Card.findById(SS.currentCardId, { include: [M.CardType] });
        if (!DbMember.Card || !DbMember.Card.id || !DbCard.id || DbMember.Card.id != DbCard.id) {
            ctx.response.body = {
                message: '当前用户数据出错'
            };
            return;
        }

        if (currentRow.Card.balance !== DbCard.balance ||
            currentRow.Card.CardType.discount !== DbCard.CardType.discount) {
            ctx.response.body = {
                message: '当前用户数据出错'
            };
            return;
        }


        var records = JSON.parse(B.records);

        //检测汇总费用 并做好卡的消费变更准备
        var cash = Number.parseFloat(
            records.rows
                .map((row) => !Number.isNaN(Number.parseFloat(row.price)) && row.is_cash === '1' ? Number.parseFloat(row.price) : 0)
                .reduce(function (accumulator, currentValue, currentIndex, array) {
                    return accumulator + currentValue;
                }))
            .toFixed(2);
        var noCash = Number.parseFloat(
            records.rows
                .map((row) => !Number.isNaN(Number.parseFloat(row.price)) && row.is_cash === '0' ? Number.parseFloat(row.price) : 0)
                .reduce(function (accumulator, currentValue, currentIndex, array) {
                    return accumulator + currentValue;
                }))
            .toFixed(2);
        var total = Number.parseFloat(
            records.rows
                .map((row) => !Number.isNaN(Number.parseFloat(row.price)) ? Number.parseFloat(row.price) : 0)
                .reduce(function (accumulator, currentValue, currentIndex, array) {
                    return accumulator + currentValue;
                }))
            .toFixed(2);
        if (cash != records.footer[0].price || noCash != records.footer[1].price || total != records.footer[2].price) {
            ctx.response.body = {
                message: '消费信息出错'
            };
            return;
        }
        DbCard.balance -= Number.parseFloat(noCash);

        //校验每个商品的单价及总价  并做好该商品数量变更的准备 做好消费记录入库准备
        var consumptions = records.rows;
        const DbCommodities = [];
        const DbConsumptions = [];

        for (let c of consumptions) {
            let DbCommodity = await M.Commodity.findById(c.commodity_id);
            DbCommodities.push(DbCommodity);
            if (!c.employee_id) {
                ctx.response.body = {
                    message: '技师信息出错'
                };
                return;
            };
            let employee = await M.Employee.findById(c.employee_id);
            if (!employee) {
                ctx.response.body = {
                    message: '技师信息出错'
                };
                return;
            };

            let unitPriceErr = DbCommodity.price != c.unitPrice;
            let totalPriceErr = c.whetherDiscount === '1'
                ? Number.parseFloat(DbCommodity.price * DbCard.CardType.discount * c.quantity).toFixed(2) != Number.parseFloat(c.price).toFixed(2)
                : Number.parseFloat(DbCommodity.price * c.quantity).toFixed(2) != Number.parseFloat(c.price).toFixed(2);

            if (unitPriceErr || totalPriceErr) {
                ctx.response.body = {
                    message: '商品信息出错'
                };
                return;
            }
            //商品数量变更准备
            DbCommodity.stocks -= Number.parseInt(c.quantity);

            //消费记录生成准备
            let DbConsumption = M.Consumption.build({
                is_close: 0,
                price: c.price,
                quantity: c.quantity,
                is_cash: c.is_cash,
                employee_id: c.employee_id,
                commodity_id: DbCommodity.id,
                card_id: DbCard.id,
                member_id: DbMember.id,
                user_id: SS.user.id,
            });
            DbConsumptions.push(DbConsumption);

        };



        //保存本次消费相关记录
        const t = await M.transaction();
        try {
            //商品变更
            for (let c of DbCommodities) {
                await c.save({ transaction: t });
            }
            //卡余额变更
            await DbCard.save({ transaction: t });

            //消费记录变更
            for (let c of DbConsumptions) {
                await c.save({ transaction: t });
            }

            //throw new Error();
        } catch (e) {
            t.rollback();
            ctx.response.body = {
                message: '记账错误'
            };
            return;
        }

        t.commit();
        ctx.response.body = {
            message: '记账完毕'
        };
        return;
    }

    async searchCardNumber() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        // const O = ctx.controllerOption; 
        const SS = ctx.session;

        SS.currentCard = null;
        if (!B || !B.card_number) {
            ctx.response.body = {
                errMessage: '查询信息出错'
            }
        }
        var card = await M.Card.findOne({
            where: {
                card_number: B.card_number
            },
            include: [M.CardType],
        })
        if (!card) {
            SS.currentCard = { card_number: B.card_number };
            ctx.response.body = {
                isNew: true,
            }
        } else {
            SS.currentCard = card;
            ctx.response.body = {
                isNew: false,
                card: card
            }
        }
    }
}
module.exports = MixController;