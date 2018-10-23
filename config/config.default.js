'use strict';

module.exports = appInfo => {
  //const config = exports = {};
  const config = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1333333333_1234';

  //模板设置
  config.view = {
    defaultViewEngine: 'nunjucks',
    mapping: {
      '.tpl': 'nunjucks',
    },
  };

  //增加post发回的数据量
  //注意：在调整 bodyParser 支持的 body 长度时，如果我们应用前面还有一层反向代理（Nginx），
  //可能也需要调整它的配置，确保反向代理也支持同样长度的请求 body。
  config.bodyParser = {
    jsonLimit: '10mb',
    formLimit: '10mb',
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

  config.session = {
    // maxAge: 24 * 3600 * 1000, // ms
    key: 'NEFU_JOB',
    maxAge: 0,
    httpOnly: true,
    encrypt: true,
    // renew: true,
  };

  return config;
};
