'use strict';

const Controller = require('../core/normal_table_controller');
const controllerName = Symbol(__filename);

class UserController extends Controller {
    constructor(ctx) {
        ctx.controllerOption = {
            name: controllerName,
            modelName: 'User',
            // selectAttributes: [],
            // excludeAttributes: [],
            // updateAttributes: [],
            // includeModelName: 'two'
            // tplName: 'User',
        }
        super(ctx);
    }
}
module.exports = UserController;