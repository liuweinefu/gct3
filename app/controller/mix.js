'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class MemberController extends Controller {
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
        if (!currentRow.Card || !currentRow.Card.id || currentRow.Card.id != SS.currentCardId) {
            ctx.response.body = {
                message: '当前用户数据出错'
            };
            return;
        }

        const dbCurrentMember = await M.Member.findById(currentRow.id, { include: [{ model: M.Card, include: [M.CardType] }] });
        if (currentRow.Card.balance !== dbCurrentMember.Card.balance ||
            currentRow.Card.CardType.discount !== dbCurrentMember.Card.CardType.discount) {
            ctx.response.body = {
                message: '当前用户数据出错'
            };
            return;
        }

        //校验商品信息
        var records = JSON.parse(B.records);

        var consumptions = records.rows;
        const dbConsumptions = [];

        for (let c of consumptions) {
            let DbCommodity = await M.Commodity.findById(c.commodity_id);
            dbConsumptions.push(DbCommodity);
            if (DbCommodity.price != c.unitPrice) {
                ctx.response.body = {
                    message: '商品信息出错'
                };
                return;
            }
        };

        const t = await M.transaction();
        try {
            dbCurrentMember.phone = '13936248323';
            await dbCurrentMember.save({ transaction: t });
            for (let c of dbConsumptions) {
                c.stocks--;
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
        //console.log(dbConsumptions);
        // t.commit();
        //console.log(dbConsumptions);


    }


}
module.exports = MemberController;