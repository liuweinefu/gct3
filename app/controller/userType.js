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
        // const O = ctx.controllerOption;
        var menusData = JSON.parse(B.menus);
        var currentRow = JSON.parse(B.currentRow);


        // var userType = await M[O.modelName].findById(currentRow.id)
        var userType = await M.UserType.build(currentRow);
        var menus = menusData.map(menu => M.Menu.build({ id: menu.id }));
        var result = await userType.setMenus(menus);

        var addLength = 0, delLength = 0;
        delLength = Number.isInteger(result[0]) ? result[0] : 0;

        addLength = Array.isArray(result[0])
            ? result[0].length
            : Array.isArray(result[1])
                ? result[1].length
                : 0;
        ctx.response.body = {
            message: `<b>${userType.name}</b>的菜单授权完毕,
                      增加了<b>${addLength}</b>条,
                      删除了<b>${delLength}</b>条`,
        };
    }
}
module.exports = UserTypeController;