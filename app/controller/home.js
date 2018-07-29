'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
  async index() {
    this.ctx.body = 'hi, egg';
  }
  async user() {
    const ctx = this.ctx;
    ctx.redirect(`http://job.nefu.edu.cn/`);
    //this.ctx.body = 'hi, user';
  }
}

module.exports = HomeController;
