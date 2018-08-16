/**
 * Jquery Easy UI 扩展库
 * 开始于：20180807
 * 编写人：刘炜
 * 
 */

class PowerSearchBox {

    constructor({ menu, searcher, prompt, width }) {
        if (!Array.isArray(menu)
            || typeof searcher !== 'function'
            || typeof prompt !== 'string'
            || typeof width !== 'number') {
            throw new Error('searchBox生成所需参数不足');
        }

        this.searchBoxDiv = $('<div></div>');

        const searchBoxMenuDiv = $('<div></div>').menu();
        menu.forEach(item => searchBoxMenuDiv.menu('appendItem', item));

        this.searchBoxDiv.searchbox({
            searcher: searcher,
            menu: searchBoxMenuDiv,
            prompt: prompt,
            width: width
        });
    }
    mount(div) {
        this.searchBoxDiv.appendTo(div);
    }
}



/**
 * 生成searchBox的JqDiv
 * @param {array} menu -菜单栏
    menu[item] = {
        name: 'xm',
        text: '姓名',
        //iconCls: 'icon-ok',
        //onclick: function () { alert('提示：新菜单项！'); }
    }
 * @param {function} searcher -调用函数
      searcher = function (value, name) {
        tableDiv.datagrid('load', {
            name: name,
            value: value,
            isEq: false,
        });
    }
 * @param {string} prompt -提示
 * @param {number} width -空间宽度
 * @returns {jq}  searchBoxDiv
 */
function MakeSearchBox(menu, searcher, prompt, width) {
    if (!Array.isArray(menu)
        || typeof searcher !== 'function'
        || typeof prompt !== 'string'
        || typeof width !== 'number') {
        throw new Error('searchBox生成所需参数不足');
    }

    var searchBoxDiv = $('<div></div>');

    var searchBoxMenuDiv = $('<div></div>');
    menu.forEach(item => searchBoxMenuDiv.menu('appendItem', item));

    searchBoxDiv.searchbox({
        searcher: searcher,
        menu: searchBoxMenuDiv,
        prompt: prompt,
        width: width
    });

    return searchBoxDiv;
}

/**
 * 为MakeSearchBox函数生成prompt、width默认值
 * @param {array} menu -菜单栏
    menu[item] = {
        name: 'xm',
        text: '姓名',
        //iconCls: 'icon-ok',
        //onclick: function () { alert('提示：新菜单项！'); }
    }
 * @param {function} searcher -调用函数
      searcher = function (value, name) {
        tableDiv.datagrid('load', {
            name: name,
            value: value,
            isEq: false,
        });
    }
 * @returns {jq}  searchBoxDiv
 */
function _MakeSearchBox(menu, searcher) {
    MakeSearchBox(menu, searcher, '请输入！', 300);
}

/**
 * 生成table的jqDiv
 * 
 * 
 *  @returns {jq}  tableDiv
 */
function MakeTable() {
    var tableDiv = $('<div></div>');



    return tableDiv;
}



