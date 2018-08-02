'use strict';

module.exports = appInfo => {
  //const config = exports = {};
  const config = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1531808436618_7777';

  //模板设置
  config.view = {
    defaultViewEngine: 'nunjucks',
    mapping: {
      '.tpl': 'nunjucks',
    },
  };



  // add your config here
  config.middleware = [];

  //sql Data
  config.sequelize = {
    dialect: 'mysql', // support: mysql, mariadb, postgres, mssql
    database: 'gct3',
    host: 'localhost',
    port: '3306',
    username: 'root',
    password: 'liu6wei5',
  };

  //关闭csrf防御
  config.security = {
    csrf: false,
    // csrf: {
    //   useSession: true, // 默认为 false，当设置为 true 时，将会把 csrf token 保存到 Session 中
    //   cookieName: 'csrfToken', // Cookie 中的字段名，默认为 csrfToken
    //   sessionName: 'csrfToken', // Session 中的字段名，默认为 csrfToken
    // },
  };

  return config;
};
