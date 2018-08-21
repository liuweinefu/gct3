'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class UserTypeController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'UserType',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [],            
            // noUpdateAttributes: [],
            includeModelNameArray: ['Menu']
            // tplName: 'User',
        }

        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
    async setMenus() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        const O = ctx.controllerOption;

    }
}
module.exports = UserTypeController;