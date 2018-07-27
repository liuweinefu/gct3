'use strict';

module.exports = appInfo => {
  //const config = exports = {};
  const config = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1531808436618_7777';

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


  return config;
};
