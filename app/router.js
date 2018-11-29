'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  //router.get('/home/', controller.home);
  // router.get('/', controller.home.index);
  // router.get('/list', controller.home.list);
  // router.post('/getMenu', controller.home.getMenu);

  router.get('/', controller.home.index);
  router.get('/captcha', controller.home.captcha);
  router.post('/verify', controller.home.verify);
  router.get('/logout', async function (ctx, netx) {
    ctx.session = null;
    ctx.body = ctx.path;
    ctx.status = 401;
    return;
  });

  // router.post('/isAuthenticated', async function isAuthenticated(ctx, next) {
  //   const SS = ctx.session;
  //   if (SS.isLogin) {
  //     B.body = 'isLogin'
  //     return;
  //   } else {
  //     ctx.body = '未授权';
  //     ctx.status = 401;
  //     return;
  //   }
  // });
  router.use('/*', async function (ctx, next) {
    // await next();
    // return;
    // console.log(ctx.path);
    // console.log(ctx.session.routers);

    const SS = ctx.session;
    // ctx.session.maxAge = 0;//强制浏览器关闭的情况下 自动失效

    if (!SS.user) {
      ctx.body = ctx.path;
      ctx.status = 401;
      return;
    }

    if (ctx.path.endsWith('findAll') || ctx.path.endsWith('getMenu')) {
      // if (!ctx.path.endsWith('save') && !ctx.path.endsWith('update')) {
      await next();
    } else if (Array.isArray(SS.routers) && SS.routers.includes(ctx.path.split('/', 2)[1])) {
      await next();
    } else {
      ctx.body = ctx.path;
      ctx.status = 401;
      return;
    }
  });


  router.post('/getMenu', controller.home.getMenu);


  /**
   * 普通数据表对应的R-C结构
   */
  const tableControllers = ['user', 'menu', 'userType', 'card', 'cardRecharge', 'cardType', 'commodity', 'commodityType', 'commodityWarehousing', 'consumption', 'employee', 'employeeType', 'employeeWage', 'member', 'wage', 'mix'];

  tableControllers.forEach(ctr => {
    router.get('/' + ctr, controller[ctr].getTpl);
    router.post('/' + ctr + '/findAll', controller[ctr].findAll);
    router.post('/' + ctr + '/save', controller[ctr].save);
    router.post('/' + ctr + '/update', controller[ctr].replace);
  })

  /**
   * 特殊的设置
   */
  router.post('/user/resetPass', controller.user.resetPass);
  router.post('/userType/setMenus', controller.userType.setMenus);


  router.post('/member/saveCase', controller.member.saveCase);
  router.get('/member/list', controller.member.list);

  router.post('/card/resetPass', controller.card.resetPass);

  router.post('/employee/payWage', controller.employee.payWage);


  router.post('/mix/settlement', controller.mix.settlement);
  router.post('/mix/verifyPass', controller.mix.verifyPass);
  router.post('/mix/clearCurrentCard', controller.mix.clearCurrentCard);
  router.post('/mix/recharge', controller.mix.recharge);
  router.post('/mix/resetPass', controller.mix.resetPass);
  router.post('/mix/searchCardNumber', controller.mix.searchCardNumber);
  router.post('/mix/addNewCard', controller.mix.addNewCard);
  router.post('/mix/addNewMerber', controller.mix.addNewMerber);


  router.post('/consumption/revoke', controller.consumption.revoke);


  // router.get('/user', controller.user.getTpl);
  // router.post('/user/findAll', controller.user.findAll);
  // router.post('/user/save', controller.user.save);
  // router.post('/user/update', controller.user.replace);

  // router.post('/userType/findAll', controller.userType.findAll);
  //router.get('/two', controller.two.getTpl);
};
