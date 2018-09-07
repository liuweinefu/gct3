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
  router.post('/getMenu', controller.home.getMenu);


  /**
   * 普通数据表对应的R-C结构
   */
  const tableControllers = ['user', 'menu', 'userType', 'card', 'cardRecharge', 'cardType', 'commodity', 'commodityType', 'commodityWarehousing', 'consumption', 'employee', 'employeeType', 'employeeWage', 'member', 'wage'];

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

  router.post('/card/resetPass', controller.card.resetPass);

  // router.get('/user', controller.user.getTpl);
  // router.post('/user/findAll', controller.user.findAll);
  // router.post('/user/save', controller.user.save);
  // router.post('/user/update', controller.user.replace);

  // router.post('/userType/findAll', controller.userType.findAll);
  //router.get('/two', controller.two.getTpl);
};
