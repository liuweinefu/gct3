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

  router.get('/user', controller.user.getTpl);
  router.post('/user/findAll', controller.user.findAll);
  router.post('/user/save', controller.user.save);
  router.post('/user/update', controller.user.replace);
  router.post('/userType/findAll', controller.userType.findAll);
  //router.get('/two', controller.two.getTpl);
};
