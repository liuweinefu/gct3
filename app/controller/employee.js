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

    async payWage() {
        const { ctx } = this;
        const B = ctx.request.body;
        //const C = ctx.condition = {};
        const M = ctx.model;
        // const O = ctx.controllerOption;
        const SS = ctx.session;

        if (Number.isNaN(B.wage) || Number.isNaN(B.bonus)) {
            ctx.response.body = {
                message: '工资或奖金数额错误'
            };
            return;
        }

        var consumptionIdArrray = []


        for (let id of B.consumptionIdArrray) {
            let c = await M.Consumption.findOne({ where: { id: id } });
            if (B.employeeId != c.employee_id) {
                ctx.response.body = {
                    message: '消费记录与雇员不符'
                };
                return;
            }
            consumptionIdArrray.push(c);
        }



        // if (Array.isArray(B.consumptionIdArrray) && B.consumptionIdArrray.length > 0) {
        //     // let tt = B.consumptionIdArrray.map(id => M.Consumption.findOne({ where: { id: id } }));
        //     consumptionIdArrray = await Promise.all(B.consumptionIdArrray.map(id => M.Consumption.findOne({ where: { id: id } })));
        // }
        // if (consumptionIdArrray.length != 0 && consumptionIdArrray.every(c => B.employeeId != c.employee_id)) {
        //     ctx.response.body = {
        //         message: '消费记录与雇员不符'
        //     };
        //     return;
        // }



        var wage = M.Wage.build({
            wage: B.wage,
            bonus: B.bonus,
            employee_id: B.employeeId,
            user_id: SS.user.id,
        });
        const t = await M.transaction();
        try {
            await wage.save({ transaction: t });
            if (consumptionIdArrray.length != 0) {
                consumptionIdArrray.forEach(c => { c.is_close = true; c.wage_id = wage.id });
                //不让消费记录更新 最后更新时间 silent: true
                await Promise.all(consumptionIdArrray.map(c => c.save({ silent: true, transaction: t })));
            }

        } catch (e) {
            t.rollback();
            ctx.response.body = {
                message: '工资结算错误'
            };
            return;
        }

        t.commit();

        var employee = await M.Employee.findOne({ where: { id: B.employeeId } });
        // var employee = await M.Employee.findByPk({ id: B.employeeId });

        ctx.response.body = {
            employeeName: employee.name,
            wage: wage.wage - (-wage.bonus),
        };
    }
}
module.exports = EmployeeController;