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
        var DbCurrentRow = await M.Member.findById(currentRow.id, { include: [{ model: M.Card, include: [M.CardType] }] });

        if (currentRow.Card.balance !== DbCurrentRow.Card.balance ||
            currentRow.Card.CardType.discount !== DbCurrentRow.Card.CardType.discount) {
            ctx.response.body = {
                message: '当前用户数据出错'
            };
            return;
        }

        //校验商品信息
        var records = JSON.parse(B.records);




        console.log(currentRow);





    }


}
module.exports = MemberController;