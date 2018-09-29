'use strict';

const md5 = require('md5');
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

    // async resetPass() {
    //     const { ctx } = this;
    //     const B = ctx.request.body;
    //     //const C = ctx.condition = {};
    //     const M = ctx.model;
    //     const O = ctx.controllerOption;
    //     if (!B.pass || B.pass.length < 6) {
    //         ctx.response.body = {
    //             message: `密码长度不够`,
    //         };
    //     } else {
    //         // var updateLength = await M[O.modelName].update({ pass: md5(B.pass) }, { where: { id: B.id } });
    //         var user = await M[O.modelName].findOne({ where: { id: B.id } });
    //         user.pass = md5(B.pass);
    //         user = await user.save();
    //         ctx.response.body = {
    //             message: `${user.name}的密码保存成功`,
    //         };
    //     }

    // }
}
module.exports = UserController;