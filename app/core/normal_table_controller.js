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
            op.selectAttributes = Array.isArray(op.selectAttributes)
                ? op.selectAttributes
                : op.attributes.filter(item => !op.excludeAttributes.includes(item));
            if (op.selectAttributes.length > 0
                && !op.selectAttributes.every(item => op.attributes.includes(item))) {
                throw new Error('selectAttributes 超项');
            }

            op.noUpdateAttributes = Array.isArray(op.noUpdateAttributes) ? op.noUpdateAttributes : [];
            if (op.noUpdateAttributes.length > 0
                && !op.noUpdateAttributes.every(item => op.attributes.includes(item))) {
                throw new Error('noUpdateAttributes 超项');
            }
            ['updated_at', 'created_at'].forEach(item => {
                if (!op.noUpdateAttributes.includes(item)) { op.noUpdateAttributes.push(item) }
            });
            //op.noUpdateAttributes = [...op.noUpdateAttributes, 'updated_at', 'created_at'];

            op.updateAttributes = Array.isArray(op.updateAttributes)
                ? op.updateAttributes
                : op.attributes.filter(item => !op.noUpdateAttributes.includes(item));
            if (op.updateAttributes.length > 0
                && !op.updateAttributes.every(item => op.attributes.includes(item))) {
                throw new Error('updateAttributes 超项');
            }



            if (Array.isArray(op.includeModelNameArray)) {
                if (op.includeModelNameArray.every(modelName => ctx.model[modelName] === undefined)) {
                    throw new Error('includeModelName 无效');
                }
                op.includeModel = op.includeModelNameArray.map(modelName => ctx.model[modelName])
            }
            if (op.includeModelNameArray) {
                delete op.includeModelNameArray;
            };
            ctx.app.controllerOption[ctx.controllerOption.name] = op;
        } else {
            ctx.controllerOption = ctx.app.controllerOption[ctx.controllerOption.name]
        }

        super(ctx);
    }

    //获得页面模板
    async getTpl() {
        const { ctx } = this;
        let options = {};
        await ctx.render(ctx.controllerOption.tplName, options);
        //ctx.body = 'Hello ' + this.ctx.ctlOption.modelName + ':' + this.ctx.ctlOption.modelTpl;
        //ctx.body = await ctx.service.normalTable.selectCondition();
    }

    //查询数据
    async findAll() {
        const { ctx } = this;
        const S = ctx.service;
        let result = await S.normalTableService.findAll();

        ctx.response.body = {
            total: result.count,
            rows: result.rows
        };
    }

    //更改数据
    async save() {
        const { ctx } = this;
        const S = ctx.service;
        const B = ctx.request.body;
        if (!B.value) {
            throw new Error('无有效数据');
        }
        ctx.request.body = JSON.parse(B.value);
        // //{ B.delete, B.insert, B.update } = x;
        // B.value = null;

        var message = await S.normalTableService.save();

        ctx.response.body = {
            message: message,
        };
    }

    //批量替换
    async replace() {

        const { ctx } = this;
        const S = ctx.service;
        const B = ctx.request.body;
        if (!B.update) {
            throw new Error('无有效数据');
        }
        B.update = JSON.parse(B.update);

        var updateLength = await S.normalTableService.replace();
        var message = `更新${updateLength}条  `;
        ctx.response.body = {
            message: message,
        };
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