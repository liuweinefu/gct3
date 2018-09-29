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
    async settlement() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        const O = ctx.controllerOption;
        const S = ctx.session;
        if (S.has) { }




    }
}
module.exports = ConsumptionController;