'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
    async index() {
        const ctx = this.ctx;
        const dataList = {};
        await ctx.render('index.tpl', dataList);
    }
    async list() {
        const ctx = this.ctx;
        //ctx.redirect(`http://job.nefu.edu.cn/`);
        //this.ctx.body = 'hi, user';
        const dataList = {};
        await ctx.render('index.tpl', dataList);
    }
    async getMenu() {
        console.log('here');
        const ctx = this.ctx;
        //ctx.redirect(`http://job.nefu.edu.cn/`);
        //this.ctx.body = 'hi, user';
        // const dataList = {};
        // await ctx.render('home.tpl', dataList);
        const menu = [{ sn: 1, name: '首页', router: '/' }, { sn: 2, name: '列表', router: '/list' }];
        ctx.body = {
            menus: menu,
        };
    }
}

module.exports = HomeController;
