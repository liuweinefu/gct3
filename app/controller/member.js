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
            // includeModelNameArray:['User','UserType'],//用'#'分割嵌套模型
            includeModelNameArray: ['Card#CardType'],
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }

    async list() {
        const { ctx } = this;
        // const B = ctx.request.body;
        const Q = ctx.query;

        //const C = ctx.condition = {};
        const M = ctx.model;
        // const O = ctx.controllerOption; 
        // const SS = ctx.session;
        var member = await M.Member.findOne({ where: { id: Q.id }, include: [M.Card] });

        let options = {
            // Card: { card_number: member.Card.card_number },
            cardNumber: member.Card ? member.Card.card_number : '',
            name: member.name,
            phone: member.phone,
            created_at: (new Date(Date.parse(member.created_at)).toLocaleString()).split(' ')[0],
            case: member.case,
            case_remark: member.case_remark,
        };

        await ctx.render('listCase.tpl', options);


    }

    async saveCase() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        // const O = ctx.controllerOption; 
        const SS = ctx.session;

        if (!B.id || !B.name) {
            ctx.response.body = {
                message: '用户信息出错'
            };
            return;
        }
        try {
            var member = await M.Member.findOne({ where: { id: B.id } });
            if (!member || member.name != B.name) {
                ctx.response.body = {
                    message: '用户信息出错'
                };
                return;
            }

            member.case = B.caseValue;
            member.case_remark = B.caseRemarkValue;


            await member.save();
        } catch (e) {
            ctx.response.body = {
                message: e.message
            };
            return;
        };
        ctx.response.body = {
            memberName: member.name
        };

    }


}
module.exports = MemberController;