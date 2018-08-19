'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class CommodityWarehousingController extends Controller {
    constructor(ctx) {
        //填写配置
        ctx.controllerOption = {
            modelName: 'CommodityWarehousing',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [],
            // includeModelName: 'two'
            // tplName: 'User',
        }


        //系统自带
        ctx.controllerOption.name = controllerName;
        super(ctx);
    }
}
module.exports = CommodityWarehousingController;