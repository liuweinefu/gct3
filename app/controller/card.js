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

    //查询数据
    async findAll() {


        const { ctx } = this;
        const S = ctx.service;
        const M = ctx.model;
        let result = await S.normalTableService.findAll();

        // let balance = (await M.Card.sequelize.query('SELECT SUM(balance) as total FROM card'))[0][0].total;
        let balance = await M.Card.sum('balance');

        ctx.response.body = {
            total: result.count,
            rows: result.rows,
            footer: [{ name: '会员总余额', balance: balance }]
        };




    }

    // async resetPass() {

    //     const { ctx } = this;
    //     const B = ctx.request.body;
    //     //const C = ctx.condition = {};
    //     const M = ctx.model;
    //     const O = ctx.controllerOption;

    //     var message = '';
    //     if (!B.id || !B.pass) {
    //         message = 'ID或密码不能为空';
    //     } else if (B.pass.length < 6) {
    //         message = '密码长度不够';
    //     } else {
    //         var card = await M[O.modelName].findOne({ where: { id: B.id } });
    //         card.pass = md5(B.pass);
    //         card = await card.save();
    //         message = `${card.name}的密码保存成功`;
    //     }
    //     ctx.response.body = {
    //         message: message,
    //     };

    // }
}
module.exports = CardController;