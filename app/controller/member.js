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
            // updateAttributes: [],             // noUpdateAttributes: [],
            // includeModelNameArray:['User','UserType']
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
}
module.exports = MemberController;