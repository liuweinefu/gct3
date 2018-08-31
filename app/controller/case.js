'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class CaseController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'Case',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [],             // noUpdateAttributes: [],
            // includeModelNameArray:['User','UserType']
            includeModelNameArray: ['Member'],
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
}
module.exports = CaseController;