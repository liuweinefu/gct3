const Service = require('egg').Service;

class NormalTableService extends Service {
    comboGridWhere(findValue) {
        var value = typeof findValue === 'string' ? findValue : '';
        return {
            [Op.or]: [
                {
                    ['id']: {
                        [Op.like]: '%' + value + '%'
                    },
                },
                {
                    ['name']: {
                        [Op.like]: '%' + value + '%'
                    },
                }
            ]
        };
    }

    searchBoxWhere(findName, findValue, isEq) {
        var name = typeof findName === 'string' ?
            (findName.includes('.') ? '$' + findName + '$' : findName) : '';
        var value = typeof findValue === 'string' ? findValue : '';
        if (name === '') { return {} }

        if (isEq === true) {
            return {
                [name]: {
                    [Op.eq]: value
                },
            };
        } else {
            return {
                [name]: {
                    [Op.like]: '%' + value + '%'
                },
            };
        }
    }

    limit(page, rows) {
        var innerPage = Number.parseInt(page);
        innerPage = Number.isNaN(innerPage) ? 1 : innerPage;

        var limit = Number.parseInt(rows);
        limit = Number.isNaN(limit) ? 50 : limit;

        var offset = (innerPage - 1) * limit;
        return [offset, limit];
    }

    order(sortName, sortOrder) {
        var name = typeof sortName === 'string' ? sortName.split(',') : [''];

        if (name[name.length - 1] === '') {
            name.pop();
        }
        if (name.includes('')) {
            return [];
        }

        var order = typeof sortOrder === 'string' ? sortOrder.split(',') : [''];
        var condition = [];
        for (let i = 0; i < name.length; i++) {
            if (name[i].includes('.')) {

                condition.push([...name[i].split('.'), order[i]]);
            } else {
                condition.push([name[i], order[i]]);
            }
        }
        return condition;

    }
    async selectCondition() {
        const ctx = this.ctx;
        const model = ctx.model;
        const op = ctx.controllerOption;

        return 'Hello ' + op.modelName + ':' + op.includeModelName;
        //return 'Hello';
    }
}

module.exports = NormalTableService;

