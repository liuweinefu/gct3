'use strict';

// had enabled by egg
//exports.static = true;

exports.nunjucks = {
    enable: true,
    package: 'egg-view-nunjucks',
};

exports.sequelize = {
    enable: true,
    package: 'egg-sequelize'
};

// exports.session = true; 
exports.session = {
    maxAge: 24 * 3600 * 1000, // ms
    key: 'EGG_SESS_NEFU_JOB',
    httpOnly: true,
    encrypt: true,
};
