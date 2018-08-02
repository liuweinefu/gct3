const Service = require('egg').Service;

class NormalTableCurdService extends Service {
    async printOne(text) {
        //const user = await this.ctx.db.query('select * from user where uid = ?', uid);
        return text;
    }
    async printTwo(text) {
        return text + '_' + text;

    }
}

module.exports = NormalTableCurdService;

