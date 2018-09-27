'use strict';

const md5 = require('md5');
const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class CardController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'Card',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [],             
            // noUpdateAttributes: [],
            includeModelNameArray: ['CardType'],
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }

    async verifyPass() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        const O = ctx.controllerOption;
        const S = ctx.session;

        if (!B.pass || B.pass.length < 6) {
            ctx.response.body = {
                message: `密码长度不够`,
            };
        } else {
            // var updateLength = await M[O.modelName].update({ pass: md5(B.pass) }, { where: { id: B.id } });
            var card = await M[O.modelName].findOne({ where: { id: B.id } });
            if (card.pass === md5(B.pass)) {
                S.hadPass = true;
                ctx.response.body = {
                    message: `${card.name}的密码通过`,
                };
            } else {
                S.hadPass = false;
                ctx.response.body = {
                    message: `${card.name}的密码错误`,
                };
            }
        }

    }

    async resetPass() {

        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        const O = ctx.controllerOption;

        if (!B.pass || B.pass.length < 6) {
            ctx.response.body = {
                message: `密码长度不够`,
            };
        } else {
            // var updateLength = await M[O.modelName].update({ pass: md5(B.pass) }, { where: { id: B.id } });
            var card = await M[O.modelName].findOne({ where: { id: B.id } });
            card.pass = md5(B.pass);
            card = await card.save();
            ctx.response.body = {
                message: `${card.name}的密码保存成功`,
            };
        }

    }
}
module.exports = CardController;