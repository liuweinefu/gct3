'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class CardTypeController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'CardType',
            // selectAttributes: [],
            // excludeAttributes: ['updated_at'],
            // updateAttributes: [],  
            // noUpdateAttributes: [],
            // includeModelNameArray:['User','UserType']
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
}
module.exports = CardTypeController;