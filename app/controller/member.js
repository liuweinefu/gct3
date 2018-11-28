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