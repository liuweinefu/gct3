'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
  async index() {
    if (this.ctx.session.count == undefined) { this.ctx.session.count = 1 }
    if (this.ctx.session.count < 100) {
      this.ctx.session.count++;
    }
    var text = this.ctx.session.count;
    this.ctx.body = 'hi, egg' + await this.ctx.service.one.printOne(text) + await this.ctx.service.one.printTwo(text) + await this.ctx.service.one.printThree(text);
  }
  async list() {
    const ctx = this.ctx;
    //ctx.redirect(`http://job.nefu.edu.cn/`);
    //this.ctx.body = 'hi, user';
    const dataList = {};
    await ctx.render('home.tpl', dataList);
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
