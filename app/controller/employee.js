'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class EmployeeController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'Employee',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [], 
            // noUpdateAttributes: [],
            includeModelNameArray: ['EmployeeType']
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
}
module.exports = EmployeeController;