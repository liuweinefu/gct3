const { Controller } = require('egg');
class NormalTableController extends Controller {
    constructor(ctx) {
        if (typeof ctx.controllerOption !== 'object' ||
            typeof ctx.controllerOption.name !== "symbol") {
            //ctx.throw('ControllerOption 初始化失败');
            throw new Error('ControllerOption 初始化失败');
        }
        // if (typeof ctx.app.controllerOption === 'undefined') {
        //     ctx.app.controllerOption = {};
        // }

        //缓存controllerOption
        if (typeof ctx.app.controllerOption[ctx.controllerOption.name] === 'undefined') {
            const op = ctx.controllerOption;
            if (ctx.model[op.modelName] === undefined) {
                throw new Error('ControllerOption model 初始化失败');
            }
            if (typeof op.tplName === 'undefined') {
                op.tplName = op.modelName + '.tpl';
            }
            const model = ctx.model[op.modelName];
            op.attributes = Object.keys(model.attributes);

            op.excludeAttributes = Array.isArray(op.excludeAttributes) ? op.excludeAttributes : [];
            if (op.excludeAttributes.length > 0
                && !op.excludeAttributes.every(item => op.attributes.includes(item))) {
                throw new Error('excludeAttributes 超项');
            }


            op.updateAttributes = Array.isArray(op.updateAttributes)
                ? op.updateAttributes
                : op.attributes.filter(item => !op.excludeAttributes.includes(item));
            if (op.updateAttributes.length > 0
                && !op.updateAttributes.every(item => op.attributes.includes(item))) {
                throw new Error('updateAttributes 超项');
            }

            op.selectAttributes = Array.isArray(op.selectAttributes)
                ? op.selectAttributes : op.updateAttributes;
            if (op.selectAttributes.length > 0
                && !op.selectAttributes.every(item => op.attributes.includes(item))) {
                throw new Error('selectAttributes 超项');
            }

            if (typeof op.includeModelName === 'string' && ctx.model[op.includeModelName] === undefined) {
                throw new Error('includeModelName 无效');
            }
            ctx.app.controllerOption[ctx.controllerOption.name] = op;
        } else {
            ctx.controllerOption = ctx.app.controllerOption[ctx.controllerOption.name]
        }

        super(ctx);
    }

    //获得页面模板
    async getTpl() {
        const { ctx } = this;
        const options = {};
        await ctx.render(ctx.controllerOption.tplName, options);
        //ctx.body = 'Hello ' + this.ctx.ctlOption.modelName + ':' + this.ctx.ctlOption.modelTpl;
        //ctx.body = await ctx.service.normalTable.selectCondition();




    }

    //查询数据
    async select() {
        const { ctx } = this;
        //根据输入生成条件
        const condition = await ctx.service.normalTable.selectCondition();

        const result = await ctx.model[this.modelName].findAll(condition);
        ctx.response.body = {
            total: result.length,
            rows: result
        };
    }

    //更改数据
    async change() {

    }
    //批量替换
    async replace() {

    }

    // success(data) {
    //     this.ctx.body = {
    //         success: true,
    //         data,
    //     };
    // }

    //404错误
    notFound(msg) {
        msg = msg || 'not found';
        this.ctx.throw(404, msg);
    }
}
module.exports = NormalTableController;