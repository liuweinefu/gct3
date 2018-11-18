'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class ConsumptionController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'Consumption',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [],             
            // noUpdateAttributes: [],
            includeModelNameArray: ['Card', 'Commodity', 'User', 'Member', 'Employee', 'Wage']
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
    async revoke() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        const O = ctx.controllerOption;
        // const SS = ctx.session;
        if (!B.id) {
            ctx.response.body = {
                message: '撤销记录无效'
            };
            return;
        }


        var consumption = await M.Consumption.findOne({
            where: { id: B.id },
            include: ['Card', 'Commodity', 'User', 'Member', 'Employee', 'Wage'],
        });

        if (!consumption) {
            ctx.response.body = {
                message: '未查询到撤销记录'
            };
            return;
        }
        if (consumption.is_cash) {
            await consumption.destroy();
            ctx.response.body = {
                message: '现金记录已撤销'
            };
            return;
        }



        var commdityLastQuantity = consumption.Commodity.stocks;
        consumption.Commodity.stocks -= -consumption.quantity;
        var commdityNowQuantity = consumption.Commodity.stocks;

        var cardLastBalance = consumption.Card.balance;
        consumption.Card.balance -= -consumption.price; //避免 加法 按字符串连接
        var cardNowBalance = consumption.Card.balance;

        const t = await M.transaction();

        try {
            await consumption.Commodity.save({ transaction: t });
            await consumption.Card.save({ transaction: t });
            await consumption.destroy({ transaction: t });
        } catch (e) {
            t.rollback();
            ctx.response.body = {
                message: '保存失败'
            };
            return;
        };
        t.commit();

        ctx.response.body = {
            commdityName: consumption.Commodity.name,
            commdityLastQuantity,
            commdityNowQuantity,
            memberName: consumption.Member.name,
            card_number: consumption.Card.card_number,
            cardLastBalance,
            cardNowBalance,
        };
        return;
    }
}
module.exports = ConsumptionController;