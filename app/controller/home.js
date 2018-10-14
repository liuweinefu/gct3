'use strict';

const Controller = require('egg').Controller;
const svgCaptcha = require('svg-captcha');
const md5 = require('md5');

class HomeController extends Controller {
    async index() {
        const ctx = this.ctx;
        const dataList = {};
        await ctx.render('index.tpl', dataList);
    }

    // async list() {
    //     const ctx = this.ctx;
    //     //ctx.redirect(`http://job.nefu.edu.cn/`);
    //     //this.ctx.body = 'hi, user';
    //     const dataList = {};
    //     await ctx.render('index.tpl', dataList);
    // }
    async getMenu() {
        console.log('home->getMenu');

        //ctx.redirect(`http://job.nefu.edu.cn/`);
        //this.ctx.body = 'hi, user';
        // const dataList = {};
        // await ctx.render('home.tpl', dataList);

        // const menu = [{ sn: 1, name: '首页', router: '/' }, { sn: 2, name: '列表', router: '/list' }];
        const { ctx } = this;
        //const S = ctx.service;
        const M = ctx.model;
        let menu = await M.Menu.findAll();
        ctx.body = {
            menus: menu,
        };
    }

    async verify() {
        const { ctx } = this;
        //const S = ctx.service;
        const M = ctx.model;
        const B = ctx.request.body;
        const SS = ctx.session;


        if (!SS.captcha || typeof SS.captcha !== 'string') {
            ctx.body = '请刷新验证码，如问题无法解决请联系开发商';
            // ctx.status = 502;
            return;
        }
        //重置验证码
        var currentCaptcha = SS.captcha;
        SS.captcha = '';
        if (!B.name || typeof B.name !== 'string' || B.name.length === 0) {
            ctx.body = '用户名错误';
            // ctx.status = 403;
        } else if (!B.pass || typeof B.pass !== 'string' || B.pass.length < 6) {
            ctx.body = '密码错误';
            // ctx.status = 403;
        } else if (!B.captcha || typeof B.captcha !== 'string' || B.captcha.length < 4 || currentCaptcha !== B.captcha) {
            ctx.body = '验证码错误';
            // ctx.status = 403;
        }

        //认证用户
        let users = await M.User.findAll({
            where: {
                name: B.name,
                pass: md5(B.pass)
            }
        });

        if (users.length !== 1) {
            ctx.body = '用户名或密码错误';
            return;
        }

        // const currentUser = users[0];
        // currentUser.last_sign_in_at = new Date();
        // await currentUser.save();

        users[0].last_sign_in_at = new Date();
        await users[0].save();
        await this._serializeUser(users[0]);


        ctx.body = 'isLogin';
    }

    async _serializeUser(currentUser) {
        const { ctx } = this;
        //const S = ctx.service;
        const M = ctx.model;
        // const B = ctx.request.body;
        const SS = ctx.session;

        function _copyCut(sourceObject, fieldsArray) {
            if (typeof sourceObject !== 'object' || !Array.isArray(fieldsArray) || fieldsArray.length === 0) { return {} };
            let targetObject = {}
            fieldsArray.forEach(field => {
                if (sourceObject[field] !== undefined) {
                    targetObject[field] = sourceObject[field]
                }
            })
            return targetObject;
        }

        SS.user = _copyCut(currentUser, Object.keys(M.User.attributes));
        delete SS.user.pass;


        let userType = await M.UserType.findById(SS.user.user_type_id, {
            include: [M.Menu]
        });
        SS.userType = _copyCut(userType, Object.keys(M.UserType.attributes));
        SS.routers = [];
        userType.Menus.forEach(menu => {
            if (menu.router) {
                //url的/和\处理有问题
                SS.routers.push(menu.router.split('\\', 2)[1]);
            }
        });
        //SS.menus = userType.Menus.map(menu => _copyCut(menu, Object.keys(M.Menu.attributes)));
    }

    async logout() {
        const { ctx } = this;
        // const SS = ctx.session;
        ctx.session = null;
        ctx.body = ctx.path;
        ctx.status = 401;
        return;
    }
    async captcha() {
        const { ctx } = this;
        const SS = ctx.session;


        let captcha = svgCaptcha.create({
            size: 4, // 驗證碼長度
            ignoreChars: '01oOiIlL', // 驗證碼字符中排除 01oOiIlL
            noise: 1, // 干擾綫條的數量
            color: true, // 驗證碼的字符有顔色
            //background: '#cc9966' // 驗證碼圖片背景顔色
        });

        SS.captcha = captcha.text.toLowerCase();


        ctx.type = 'svg';
        ctx.body = captcha.data;
        ctx.status = 200;

        // const RES = ctx.response;
        // RES.type = 'svg';
        // RES.body = captcha.data;
        // RES.status = 200;

        // return captcha.data;
    };
}

module.exports = HomeController;
