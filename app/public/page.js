var tableEvents = function () {
    return {
        onCellEdit: function (index, field, value) {
            let editor = $(this).datagrid('getEditor', {
                index: index,
                field: field
            });
            switch (editor.type) {
            case 'combogrid':
                $(editor.target).combogrid('textbox').select();
                $(editor.target).combogrid('showPanel');
                break;
            case 'combobox':
                $(editor.target).combobox('textbox').select();
                $(editor.target).combobox('showPanel');
                break;
                //case 'validatebox':                
            case 'textbox':
                console.log('1a');
                $(editor.target).textbox('textbox').select();
                break;
            }
        },
    };
};


var buttonsEvents = function (page) {
    let tableDiv = page.getTableDiv();
    return {
        add: function () {
            //结束编辑
            if (tableDiv.datagrid('cell')) {
                tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
            }
            tableDiv.datagrid('appendRow', page.getNewRow());
        },
        del: function () {
            // tableDiv.datagrid('deleteRow', 
            //     tableDiv.datagrid('getRowIndex',
            //         tableDiv.datagrid('getChecked')[0]));
            if (tableDiv.datagrid('cell')) {
                tableDiv.datagrid('deleteRow', tableDiv.datagrid('cell').index);
            } else {
                $.messager.alert('信息', '无选中条件', 'info', function () {
                });
            }
        },
        up: function () {

            if (tableDiv.datagrid('cell')) {

                let rowIndex = tableDiv.datagrid('cell').index;
                let insetIndex = rowIndex - 1 < 0 ? 0 : rowIndex - 1;
                let row = tableDiv.datagrid('getRows')[rowIndex];
                tableDiv.datagrid('endEdit', rowIndex);
                tableDiv.datagrid('deleteRow', rowIndex);
                tableDiv.datagrid('insertRow', {
                    index: insetIndex,	// 索引从0开始
                    row: row,
                });

                tableDiv.datagrid('gotoCell', {
                    index: insetIndex,
                    field: 'field'
                });
            } else {
                $.messager.alert('信息', '无选中条件', 'info', function () {
                });
            }

        },
        down: function () {
            if (tableDiv.datagrid('cell')) {

                let rowIndex = tableDiv.datagrid('cell').index;
                let length = tableDiv.datagrid('getRows').length;
                let insetIndex = rowIndex + 1 === length ? rowIndex : rowIndex + 1;
                let row = tableDiv.datagrid('getRows')[rowIndex];
                tableDiv.datagrid('endEdit', rowIndex);
                tableDiv.datagrid('deleteRow', rowIndex);
                tableDiv.datagrid('insertRow', {
                    index: insetIndex,	// 索引从0开始
                    row: row,
                });

                tableDiv.datagrid('gotoCell', {
                    index: insetIndex,
                    field: 'field'
                });
            } else {
                $.messager.alert('信息', '无选中条件', 'info', function () {
                });
            }
        },
    };
};

var buttons = function (page) {
    return {
        importExcel: {
            text: '导入(<ins>I</ins>)',
            iconCls: 'icon-search',
            onClick: () => { console.log('导入' + divID); },
        },
        exportExcel: {
            text: '导出(<ins>E</ins>)',
            iconCls: 'icon-search',
            onClick: () => { console.log('导出' + divID); },
        },
        sort: {
            text: '排序(<ins>P</ins>)',
            iconCls: 'icon-search',
            onClick: () => {
                if (!orderDialogPage) {
                    let functions = {
                        submit: (data) => {
                            return console.log(data);
                        },
                        close: () => {
                            return console.log('close orderDlg');
                        },
                    };
                    orderDialogPage = new orderDialog(orderDialogDiv, functions);
                    let fieldData = [];
                    tableFieldsArray.forEach(item => {
                        item.forEach(field => {
                            if (field.title && !field.hidden) {
                                fieldData.push({
                                    field: field.field,
                                    title: field.title,
                                });
                            }
                        });
                    });
                    orderDialogPage.setFieldData(fieldData);

                    orderDialogPage.build();
                } else {
                    orderDialogPage.open();
                }

            },
        },
        search: {
            text: '查询(<ins>F</ins>)',
            iconCls: 'icon-search',
            onClick: () => { console.log('查询' + divID); },
        },
        add: {
            text: '添加(<ins>A</ins>)',
            iconCls: 'icon-add',
            onClick: () => {
                //结束编辑
                if (tableDiv.datagrid('cell')) {
                    tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                }


                //新增row的内容不能重复，否则视为同一项，则不更新索引，为删除带来麻烦
                tableDiv.datagrid('insertRow', {
                    index: 0,
                    row: this.makeNewRow(),
                });

                tableDiv.datagrid('editCell', {
                    index: 0,
                    field: this.makeNewRow('field'),
                });
            }
        },
        save: {
            text: '保存(<ins>S</ins>)',
            iconCls: 'icon-save',
            onClick: () => {
                //console.log($('#user_table').datagrid('cell'));
                //接受当前编辑内容，并结束编辑
                if (tableDiv.datagrid('cell')) {
                    tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                }

                tableDiv.datagrid('loading');
                let sendObject = {};
                sendObject.insert = tableDiv.datagrid('getChanges', 'inserted');
                sendObject.delete = tableDiv.datagrid('getChanges', 'deleted');
                sendObject.update = tableDiv.datagrid('getChanges', 'updated');
                if (sendObject.insert.length === 0 && sendObject.delete.length === 0 && sendObject.update.length === 0) {
                    $.messager.alert('提示', '没有更改', 'info', function () {
                        tableDiv.datagrid('loaded');
                        tableDiv.datagrid('getPanel').focus(); //重置焦点
                    });
                    return;
                }
                let sendString = JSON.stringify(sendObject);
                sendObject = {
                    value: sendString
                };
                //console.log(JSON.stringify(sendObject));
                $.post('./' + divID + '/save', sendObject)
                    .done(function (data) {
                        $.messager.alert('提示', data.message, 'info', function () {
                            tableDiv.datagrid('reload');
                            tableDiv.datagrid('loaded');
                            //tableDiv.datagrid('getPanel').focus();
                            searchBoxDiv.textbox('textbox').focus();//重置焦点
                        });

                    })
                    .fail(function (err) {
                        console.log(err);
                        $.messager.alert('失败', '请检查网络连接', 'warning', function () {
                            tableDiv.datagrid('loaded');
                            searchBoxDiv.textbox('textbox').focus();//重置焦点
                        });
                    });
            },
        },
        delete: {
            text: '删除(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
            iconCls: 'icon-search',
            onClick: () => {
                // let allChecked = tableDiv.datagrid('getChecked');
                // let allCheckedIndex = allChecked.map(row => tableDiv.datagrid('getRowIndex', row));
                // //每次删除索引都重新计算，所以倒序排序删除不影响
                // console.log(allCheckedIndex);
                // let sortAllCheckedIndex = allCheckedIndex.sort((a, b) => b - a);
                // console.log(sortAllCheckedIndex);
                // sortAllCheckedIndex.forEach(index => tableDiv.datagrid('deleteRow', index));

                tableDiv.datagrid('getChecked').map(row => tableDiv.datagrid('getRowIndex', row)).sort((a, b) => b - a).forEach(index => tableDiv.datagrid('deleteRow', index));

                searchBoxDiv.textbox('textbox').focus();//重置焦点
            }
        },
        redo: {
            text: '撤销(<ins>L</ins>)',
            iconCls: 'icon-redo',
            onClick: () => {
                tableDiv.datagrid('rejectChanges');

                searchBoxDiv.textbox('textbox').focus();//重置焦点
            }
        },
        replace: {
            text: '替换(<ins>R</ins>)',
            iconCls: 'icon-redo',
            onClick: () => {
                tableDiv.datagrid('rejectChanges');

                searchBoxDiv.textbox('textbox').focus();//重置焦点
            }
        },


    };
};

var orderDialog = function (orderDialogDiv, functions) {
    let tableDiv = $('<div></div>');
    tableDiv.appendTo(orderDialogDiv);
    this.getTableDiv = () => tableDiv;
    let buttonContainerDiv = $('<div></div>');
    buttonContainerDiv.appendTo(orderDialogDiv);

    let newRow = {
        field: '',
        order: '是'
    };
    this.getNewRow = () => Object.assign({}, newRow);
    // this.setNewRow = (option, cover) => {
    //     if (cover) {
    //         newRow = option;
    //     } else {
    //         Object.assign(newRow,option);                   
    //     }
    // };

    let defaultButtons = {
        add: {
            text: '添加条件(<ins>A</ins>)',
            iconCls: 'icon-add',
            onClick: buttonsEvents(this).add,
        },
        del: {
            text: '删除条件(<ins>D</ins>)',
            iconCls: 'icon-add',
            onClick: buttonsEvents(this).del,
        },
        up: {
            text: '上',
            //iconCls: 'icon-copy',
            onClick: buttonsEvents(this).up,
        },
        down: {
            text: '下',
            //iconCls: 'icon-copy',
            onClick: buttonsEvents(this).down,
        },
    };

    let buttons = defaultButtons;
    this.setButtons = (option, cover) => {
        if (cover) {
            buttons = option;
        } else {
            buttons = {};
            Object.keys(option).forEach((key) => {
                buttons[key] = option[key];
                if (option[key] === true && defaultButtons[key]) {
                    buttons[key] = defaultButtons[key];
                }

            });
        }
    };

    let _buildButtons = () => {
        Object.keys(buttons).forEach(function (buttonName) {
            $('<a></a>')
                //.css('margin-left', 3)
                .appendTo(buttonContainerDiv)
                .linkbutton(buttons[buttonName]);

            var whereKey = buttons[buttonName].text.search(new RegExp('<ins>[a-z]</ins>', 'i'));
            var pressKey = whereKey === -1 ? null : buttons[buttonName].text[whereKey + 5].toLocaleLowerCase();
            if (pressKey) {
                //给表格添加按键事件，其他元素添加不响应,怀疑easyui在table上有事件拦截器
                tableDiv.datagrid('getPanel').keydown(e => {
                    if (e.altKey === false) { return; }
                    if (e.key === pressKey) { buttons[buttonName].onClick(e); }
                });
            }
        });
    };

    let fieldData = [
        {
            field: 'ksh',
            title: '考生号'
        }, {
            field: 'xm',
            title: '姓名'
        }, {
            field: 'xb',
            title: '性别'
        }];
    this.setFieldData = (option) => {
        fieldData = option;
    };
    let tableFieldsArray = [[
        {
            field: 'field',
            title: '字段',
            sortable: false,
            width: 60,
            formatter: function (value, row, index) {
                //if(value){
                let item = fieldData.find(item => item.field == value); return item != undefined ? item.title : '';
                //}                        
            },
            editor: {
                type: 'combobox',
                options: {
                    panelWidth: 160,
                    editable: true,
                    valueField: 'field',
                    textField: 'title',
                    limitToList: true,
                    // data: [{
                    //     field: 'ksh',
                    //     title: '考生号'
                    // }, {
                    //     field: 'xm',
                    //     title: '姓名'
                    // }, {
                    //     field: 'xb',
                    //     title: '性别'
                    // }]
                    //url: 'member/roles',
                    // onLoadSuccess: function() {
                    //     member.roles = $(this).combobox('getData');
                    // },
                }
            }
        }, {
            field: 'order',
            title: '是否升序',
            width: 60,
            editor: {
                type: 'checkbox',
                options: { on: '是', off: '否' }
            }
        }
    ]];
    let tableOption = {
        // idField: 'id',
        // loadMsg: '数据加载中,请稍后',
        fit: true,
        fitColumns: true,
        singleSelect: true,
        //url: '/' + divID + '/findAll',
        //method: 'post',
        //toolbar: buttonContainerDiv,
        striped: true,
        //pagination: true,
        rownumbers: true,
        columns: tableFieldsArray,
        // pageNumber: 1,
        // pageSize: '50',
        // pageList: [50, 200, 500, 5000],
        remoteSort: false,
        multiSort: true,
        onLoadSuccess: () => {
            //searchBoxDiv.textbox('textbox').focus();
            tableDiv.datagrid('getPanel').focus();//不好用
        },
        //初始化编辑器
        onCellEdit: tableEvents().onCellEdit

    };
    let _buildTable = () => {
        tableFieldsArray[0][0].editor.options.data = fieldData;
        tableFieldsArray[0][0].editor.options.panelHeight = fieldData.length * 20 + 15;
        tableDiv.datagrid(tableOption).datagrid('enableCellEditing');
        tableDiv.datagrid('appendRow',this.getNewRow());
    };
    let _buildDlg = () => {
        orderDialogDiv.dialog({
            width: 600,
            height: 400,
            iconCls: 'icon-save',
            title: '综合排序',
            modal: true,
            //toolbar: '#dlg-toolbar',
            toolbar: buttonContainerDiv,
            buttons: [{
                text: '确定',
                iconCls: 'icon-save',
                handler: function () {
                    //结束编辑
                    if (tableDiv.datagrid('cell')) {
                        tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                    }
                    let data = tableDiv.datagrid('getData');
                    functions.submit(data);
                    //alert('save'); 
                }
            }, {
                text: '关闭',
                iconCls: 'icon-save',
                handler: function () {
                    orderDialogDiv.dialog('close', true);
                    //结束编辑
                    // if (tableDiv.datagrid('cell')) {
                    //     tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                    // }

                    // let data = tableDiv.datagrid('getData');
                    // functions.submit(data);
                    //alert('save'); 

                }
            }],
        });
    };


    this.build = () => {
        _buildDlg();
        //tableOption.columns = tableFieldsArray;
        _buildTable();
        //tableDiv.datagrid(tableOption);
        _buildButtons();

    };

    this.open = () => {
        orderDialogDiv.dialog('open', true);
    };
    // this.close = () => {
    //     orderDialogDiv.dialog('close', true);
    // };
};

var mainPanel = function (divID, $) {
    //view设置
    let viewDiv = $('#' + divID);


    let toolBarDiv = $('<div></div>');
    toolBarDiv.appendTo(viewDiv);
    //searchBox
    let searchBoxContainerDiv = $('<span></span>');
    searchBoxContainerDiv.appendTo(toolBarDiv);

    let searchBoxDiv = $('<div></div>');
    searchBoxDiv.appendTo(searchBoxContainerDiv);
    let searchBoxListDiv = $('<div></div>');
    searchBoxListDiv.appendTo(searchBoxDiv);

    let searchBoxOption = {
        searcher: (value, name) => {
            tableDiv.datagrid('load', {
                name: name,
                value: value
            });
        },
        menu: searchBoxListDiv,
        prompt: '请输入值',
        width: '300'
    };
    //this.getSearchBoxOption = () => searchBoxOption;
    this.setSearchBoxOption = (option, cover) => {
        if (cover) {
            searchBoxOption = option;
        } else {
            searchBoxOption = Object.assign(searchBoxOption, option);
        }

    };
    let searchBoxListArray = [{
        filed: 'id',
        name: 'ID'
    }];
    //this.getSearchBoxListArray = () => searchBoxListArray;
    this.setSearchBoxListArray = (option, cover) => {
        if (cover) {
            searchBoxListArray = option;
        } else {
            searchBoxListArray = searchBoxListArray.concat(option);
        }
    };
    let _buildSearchox = () => {
        searchBoxListArray.forEach((item) => {
            ($('<div></div>')).attr('data-options', 'name:\'' + item.filed + '\'').text(item.name).appendTo(searchBoxListDiv);
        });
        searchBoxDiv.searchbox(searchBoxOption);
    };
    //this.getSearchBoxDiv = () => { return searchBoxDiv;};


    //button
    let buttonContainerDiv = $('<span></span>');
    buttonContainerDiv.css('margin-left', 40);
    buttonContainerDiv.insertAfter(searchBoxContainerDiv);


    //新增row的内容不能重复，否则视为同一项，则不更新索引，为删除带来麻烦
    this.makeNewRow = (field) => {
        if (!field) {
            //新增内容
            return {
                id: 'N' + Math.round(Math.random() * 100000),
            };
        } else {
            //新增内容后开始编辑的字段
            return 'id';
        }

    };

    let defaultButtons = {
        importExcel: {
            text: '导入(<ins>I</ins>)',
            iconCls: 'icon-search',
            onClick: () => { console.log('导入' + divID); },
        },
        exportExcel: {
            text: '导出(<ins>E</ins>)',
            iconCls: 'icon-search',
            onClick: () => { console.log('导出' + divID); },
        },
        sort: {
            text: '排序(<ins>P</ins>)',
            iconCls: 'icon-search',
            onClick: () => {
                if (!orderDialogPage) {
                    let functions = {
                        submit: (data) => {
                            return console.log(data);
                        },
                        close: () => {
                            return console.log('close orderDlg');
                        },
                    };
                    orderDialogPage = new orderDialog(orderDialogDiv, functions);
                    let fieldData = [];
                    tableFieldsArray.forEach(item => {
                        item.forEach(field => {
                            if (field.title && !field.hidden) {
                                fieldData.push({
                                    field: field.field,
                                    title: field.title,
                                });
                            }
                        });
                    });
                    orderDialogPage.setFieldData(fieldData);

                    orderDialogPage.build();
                } else {
                    orderDialogPage.open();
                }

            },
        },
        search: {
            text: '查询(<ins>F</ins>)',
            iconCls: 'icon-search',
            onClick: () => { console.log('查询' + divID); },
        },
        add: {
            text: '添加(<ins>A</ins>)',
            iconCls: 'icon-add',
            onClick: () => {
                //结束编辑
                if (tableDiv.datagrid('cell')) {
                    tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                }


                //新增row的内容不能重复，否则视为同一项，则不更新索引，为删除带来麻烦
                tableDiv.datagrid('insertRow', {
                    index: 0,
                    row: this.makeNewRow(),
                });

                tableDiv.datagrid('editCell', {
                    index: 0,
                    field: this.makeNewRow('field'),
                });
            }
        },
        save: {
            text: '保存(<ins>S</ins>)',
            iconCls: 'icon-save',
            onClick: () => {
                //console.log($('#user_table').datagrid('cell'));
                //接受当前编辑内容，并结束编辑
                if (tableDiv.datagrid('cell')) {
                    tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                }

                tableDiv.datagrid('loading');
                let sendObject = {};
                sendObject.insert = tableDiv.datagrid('getChanges', 'inserted');
                sendObject.delete = tableDiv.datagrid('getChanges', 'deleted');
                sendObject.update = tableDiv.datagrid('getChanges', 'updated');
                if (sendObject.insert.length === 0 && sendObject.delete.length === 0 && sendObject.update.length === 0) {
                    $.messager.alert('提示', '没有更改', 'info', function () {
                        tableDiv.datagrid('loaded');
                        tableDiv.datagrid('getPanel').focus(); //重置焦点
                    });
                    return;
                }
                let sendString = JSON.stringify(sendObject);
                sendObject = {
                    value: sendString
                };
                //console.log(JSON.stringify(sendObject));
                $.post('./' + divID + '/save', sendObject)
                    .done(function (data) {
                        $.messager.alert('提示', data.message, 'info', function () {
                            tableDiv.datagrid('reload');
                            tableDiv.datagrid('loaded');
                            //tableDiv.datagrid('getPanel').focus();
                            searchBoxDiv.textbox('textbox').focus();//重置焦点
                        });

                    })
                    .fail(function (err) {
                        console.log(err);
                        $.messager.alert('失败', '请检查网络连接', 'warning', function () {
                            tableDiv.datagrid('loaded');
                            searchBoxDiv.textbox('textbox').focus();//重置焦点
                        });
                    });
            },
        },
        delete: {
            text: '删除(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
            iconCls: 'icon-search',
            onClick: () => {
                // let allChecked = tableDiv.datagrid('getChecked');
                // let allCheckedIndex = allChecked.map(row => tableDiv.datagrid('getRowIndex', row));
                // //每次删除索引都重新计算，所以倒序排序删除不影响
                // console.log(allCheckedIndex);
                // let sortAllCheckedIndex = allCheckedIndex.sort((a, b) => b - a);
                // console.log(sortAllCheckedIndex);
                // sortAllCheckedIndex.forEach(index => tableDiv.datagrid('deleteRow', index));

                tableDiv.datagrid('getChecked').map(row => tableDiv.datagrid('getRowIndex', row)).sort((a, b) => b - a).forEach(index => tableDiv.datagrid('deleteRow', index));

                searchBoxDiv.textbox('textbox').focus();//重置焦点
            }
        },
        redo: {
            text: '撤销(<ins>L</ins>)',
            iconCls: 'icon-redo',
            onClick: () => {
                tableDiv.datagrid('rejectChanges');

                searchBoxDiv.textbox('textbox').focus();//重置焦点
            }
        },
        replace: {
            text: '替换(<ins>R</ins>)',
            iconCls: 'icon-redo',
            onClick: () => {
                tableDiv.datagrid('rejectChanges');

                searchBoxDiv.textbox('textbox').focus();//重置焦点
            }
        },


    };
    let buttons = defaultButtons;
    this.setButtons = (option, cover) => {
        if (cover) {
            buttons = option;
        } else {
            buttons = {};//全局buttons
            Object.keys(option).forEach((key) => {
                buttons[key] = option[key];
                if (option[key] === true && defaultButtons[key]) {
                    buttons[key] = defaultButtons[key];
                }

            });
        }
    };

    let _buildButtons = () => {
        Object.keys(buttons).forEach(function (buttonName) {
            $('<a></a>')
                .css('margin-left', 3)
                .appendTo(buttonContainerDiv)
                .linkbutton(buttons[buttonName]);

            var whereKey = buttons[buttonName].text.search(new RegExp('<ins>[a-z]</ins>', 'i'));
            var pressKey = whereKey === -1 ? null : buttons[buttonName].text[whereKey + 5].toLocaleLowerCase();
            if (pressKey) {
                //给表格添加按键事件，其他元素添加不响应,怀疑easyui在table上有事件拦截器
                tableDiv.datagrid('getPanel').keydown(e => {
                    if (e.altKey === false) { return; }
                    if (e.key === pressKey) { buttons[buttonName].onClick(e); }
                });
            }
        });
    };




    //table
    let tableDiv = $('<div></div>');
    //tableDiv.appendTo(viewDiv);
    tableDiv.insertAfter(toolBarDiv);
    this.getTableDiv = () => { return tableDiv; };

    let tableFieldsArray =
        [[
            {
                field: 'id',
                title: 'ID',
                hidden: false,
            },
        ], []];
    this.getTableFieldsArray = () => tableFieldsArray;
    this.setTableFieldsArray = (option, cover) => {
        if (cover) {
            tableFieldsArray = option;
        } else {
            tableFieldsArray = tableFieldsArray.concat(option);
        }
    };


    let tableOption = {
        idField: 'id',
        //loadMsg: '数据加载中,请稍后',
        fit: true,
        fitColumns: true,
        singleSelect: false,
        url: '/' + divID + '/findAll',
        method: 'post',
        toolbar: toolBarDiv,
        striped: true,
        pagination: true,
        rownumbers: true,
        pageNumber: 1,
        pageSize: '50',
        pageList: [50, 200, 500, 5000],
        remoteSort: false,
        multiSort: true,
        onCellEdit: tableEvents().onCellEdit,
        onLoadSuccess: () => {
            searchBoxDiv.textbox('textbox').focus();
            //tableDiv.datagrid('getPanel').focus();//不好用
        },

    };
    this.getTableOption = () => tableOption;
    this.setTableOption = (option, cover) => {
        if (cover) {
            tableOption = option;
        } else {
            tableOption = Object.assign(tableOption, option);
        }
    };
    //this.tableDiv.datagrid(this.tableSet).datagrid('enableCellEditing');

    let _buildTable = () => {
        tableOption.columns = tableFieldsArray;
        tableDiv.datagrid(tableOption).datagrid('enableCellEditing');
    };

    //orderDialogDiv
    let orderDialogDiv = $('<div></div>');
    //tableDiv.appendTo(viewDiv);
    orderDialogDiv.insertAfter(toolBarDiv);
    this.orderDialogDiv = () => { return orderDialogDiv; };
    let orderDialogPage = null;
    //let orderTableOpened = false;

    //构建页面
    this.build = function () {
        _buildTable();
        _buildSearchox();
        _buildButtons();

        //重置焦点，为初始化按键响应
        //tableDiv.datagrid('getPanel').focus();//不好用
        //searchBoxDiv.textbox('textbox').focus();
    };




};


