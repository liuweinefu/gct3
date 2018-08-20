'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class UserController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'User',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [],
            // noUpdateAttributes: [],
            includeModelNameArray: ['UserType'],
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
}
module.exports = UserController;