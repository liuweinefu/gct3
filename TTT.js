class base {
    constructor(op) {
        //基类构造函数调用
        console.log('base');
        console.log(op);
    }
}
class first extends base {
    constructor(op) {
        if (op == 'first') {
            throw new Error('实例化失败');
        }
        console.log('first');
        super(op);
    }
}
class second extends first {
    constructor(op) {
        if (op == 'second') {
            throw new Error('实例化失败');
        }
        console.log('second');
        super(op);
    }
}

var a = 'abc';
a = a === 'c'
    ? 'b'
    : 'm';
