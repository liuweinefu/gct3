var combogridEvents = function (page) {
    return {
        onLoadSuccess: function () {
            $(this).datagrid('selectRow', 0);
        },
        onShowPanel: function () {
            var value = '';
            var cell = page.getTableDiv().datagrid('cell');
            if (cell) {
                value = page.getTableDiv().datagrid('getRows')[cell.index][cell.field];
            }
            if (value) {
                $(this).combogrid('grid').datagrid('load', {
                    name: 'id',
                    value: value,
                    isEq: true
                })
            }
            // else {
            //     $(this).combogrid('grid').datagrid('load')
            // }
            //$(this).combogrid('textbox').select();
        },

    }
};

var tableEvents = function () {
    return {
        onLoadError: function (XMLHttpRequest, textStatus, errorThrown) {
            var message = '数据无效';
            if (XMLHttpRequest.responseText) {
                message = XMLHttpRequest.responseText;
            }
            if (XMLHttpRequest.responseJSON && XMLHttpRequest.responseJSON.errMessage) {
                message = XMLHttpRequest.responseJSON.errMessage;
            }
            $.messager.alert('信息', message, 'info', function () {
                //dialogDiv.dialog('close', true);
            });
        },
        onCellEdit: function (index, field, value) {
            let editor = $(this).datagrid('getEditor', {
                index: index,
                field: field
            });
            switch (editor.type) {
                case 'combogrid':
                    $(editor.target).combogrid('showPanel');
                    //重置分页组件,为了选择时不受视线干扰
                    $(editor.target).combogrid('grid').datagrid('getPager').pagination({
                        layout: ["sep", "first", "prev", "sep", "manual", "sep", "next", "last", "sep", "refresh"]
                    });
                    //textbox的内容有转换过程，为了达到选中目的，调用延时
                    setTimeout(function () {
                        $(editor.target).combogrid('textbox').select();
                    }, 100);
                    break;
                case 'combobox':
                    $(editor.target).combobox('textbox').select();
                    $(editor.target).combobox('showPanel');
                    break;
                case 'numberbox':
                case 'textbox':
                    $(editor.target).textbox('textbox').select();
                    break;
            }
        },
    };
};

var buttonFunctionMaker = function (page) {
    if (!page) { return; }
    var tableDiv = page.getTableDiv();
    var getFieldData = function (replace) {
        var fieldData = [];
        page.getTableDiv().datagrid('options').columns.forEach(item => {
            item.forEach(column => {
                if (column.field.includes('action_')) { return; }
                // if (column.field.includes('_at')) { return; }
                //if (replace && !column.editor) { return; }
                if (!column.editor) { return; }
                if (column.field && column.title && !column.hidden) {
                    fieldData.push({
                        field: column.field,
                        title: column.title,
                    });
                }
            });
        });
        //去重
        return [...new Set(fieldData)];



        // var outColumns = [];
        // outColumns = outColumns.concat(page.getTableDiv().datagrid('getColumnFields'));
        // outColumns = outColumns.concat(page.getTableDiv().datagrid('getColumnFields', true));
        // outColumns = [...new Set(outColumns)];//去重

        // var fieldData = [];
        // outColumns.forEach(columnName => {
        //     var column = page.getTableDiv().datagrid('getColumnOption', columnName);
        //     //如果是替换则去掉没有editor的字段
        //     if (replace && !column.editor) { return; }
        //     if (column.field && column.title && !column.hidden) {
        //         fieldData.push({
        //             field: column.field,
        //             title: column.title,
        //         });
        //     }
        // });
        // return fieldData;
    };
    return {
        footAdd: function () {
            //结束编辑
            if (tableDiv.datagrid('cell')) {
                tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
            }
            let newRowIndex = tableDiv.datagrid('getRows').length;
            tableDiv.datagrid('appendRow', page.makeNewRow(newRowIndex));
            let column = getFieldData(true)[0];
            if (column && column.field) {
                tableDiv.datagrid('editCell', {
                    index: newRowIndex,
                    field: column.field,
                });
            }
        },
        headAdd: function () {
            //结束编辑
            if (tableDiv.datagrid('cell')) {
                tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
            }
            tableDiv.datagrid('insertRow', {
                index: 0,
                row: page.makeNewRow(),
            });
            let column = getFieldData(true)[0];
            if (column && column.field) {
                tableDiv.datagrid('editCell', {
                    index: 0,
                    field: column.field,
                });
            }

        },
        insert: function () {
            //结束编辑
            var newRowIndex = 0;
            if (tableDiv.datagrid('cell')) {
                newRowIndex = tableDiv.datagrid('cell').index;
                tableDiv.datagrid('endEdit', newRowIndex);
            }
            tableDiv.datagrid('insertRow', {
                index: newRowIndex,
                row: page.makeNewRow(newRowIndex),
            });
            let column = getFieldData(true)[0];
            if (column && column.field) {
                tableDiv.datagrid('editCell', {
                    index: newRowIndex,
                    field: column.field,
                });
            }
        },
        // singleDel: function () {
        //     // tableDiv.datagrid('deleteRow', 
        //     //     tableDiv.datagrid('getRowIndex',
        //     //         tableDiv.datagrid('getChecked')[0]));
        //     if (tableDiv.datagrid('cell')) {
        //         tableDiv.datagrid('deleteRow', tableDiv.datagrid('cell').index);
        //     } else {
        //         $.messager.alert('信息', '无选中条件', 'info', function () {
        //         });
        //     }
        // },
        del: function () {
            //结束编辑
            if (tableDiv.datagrid('cell')) {
                tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
            }
            if (tableDiv.datagrid('getChecked').length === 0) {
                $.messager.alert('信息', '无选中条件', 'info', function () {
                });
                return;
            }
            tableDiv.datagrid('getChecked').map(row => tableDiv.datagrid('getRowIndex', row)).sort((a, b) => b - a).forEach(index => tableDiv.datagrid('deleteRow', index));
            //searchBoxDiv.textbox('textbox').focus();//重置焦点
        },
        sort: function () {
            if (page.dialogPage.sortDiv) {
                page.dialogPage.sortDiv.dialog('open', true);
                return;
            }

            var dialogDiv = $('<div></div>');
            dialogDiv.appendTo(page.getDialogContainerDiv());
            page.dialogPage.sortDiv = dialogDiv;
            var view = new lwTable(dialogDiv);

            //init fields
            var fieldData = getFieldData();

            view.makeNewRow = () => {
                return {
                    field: fieldData[0] ? fieldData[0].field : '',
                    order: '是'
                };
            };

            var op = {};
            op.buttonOption = {
                footAdd: {
                    text: '添加条件(<ins>A</ins>)',
                },
                delete: {
                    text: '删除条件(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                },
                up: true,
                down: true,
            };

            op.tableOption = {
                // idField: 'id',
                // loadMsg: '数据加载中,请稍后',
                fit: true,
                fitColumns: true,
                //singleSelect: true,
                //url: '/' + divID + '/findAll',
                //method: 'post',
                toolbar: '',
                striped: true,
                pagination: false,
                rownumbers: true,
                // pageNumber: 1,
                // pageSize: '50',
                // pageList: [50, 200, 500, 5000],
                // remoteSort: false,
                // multiSort: true,   
            };
            op.tableOption.columns = [[
                {
                    field: 'ck',
                    checkbox: true
                },
                {
                    field: 'field',
                    title: '字段',
                    sortable: false,
                    width: 180,
                    formatter: function (value, row, index) {
                        //if(value){
                        let item = fieldData.find(item => item.field == value); return item != undefined ? item.title : '';
                        //}                        
                    },
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 160,
                            //panelHeight: 70,
                            panelHeight: fieldData.length * 20 + 15,
                            editable: true,
                            valueField: 'field',
                            textField: 'title',
                            limitToList: true,
                            data: fieldData,
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
            //init table
            view.addBuildFunction(() => {
                view.getTableDiv().datagrid('appendRow', view.makeNewRow());
            });

            //view.build();          
            dialogDiv.dialog({
                onBeforeOpen: function () {
                    view.build(op);
                },
                width: 600,
                height: 400,
                iconCls: 'icon-save',
                title: '综合排序',
                modal: true,
                //toolbar: '#dlg-toolbar',
                toolbar: view.getToolBarDiv(),
                buttons: [{
                    text: '确定',
                    iconCls: 'icon-save',
                    //handler:confirm,
                    handler: function () {
                        //结束编辑,清空选择
                        var innerDiv = view.getTableDiv();
                        if (innerDiv.datagrid('cell')) {
                            innerDiv.datagrid('endEdit', innerDiv.datagrid('cell').index);
                        }
                        innerDiv.datagrid('uncheckAll');

                        var rows = innerDiv.datagrid('getData').rows;
                        var sortName = [];
                        var sortOrder = [];
                        var errMessage = '';
                        for (let row of rows) {
                            let firstErrIndex = sortName.indexOf(row.field);
                            if (firstErrIndex === -1) {
                                sortName.push(row.field);
                                sortOrder.push(row.order === '是' ? 'asc' : 'desc');
                                continue;
                            }
                            let lastErrIndex = sortName.length;
                            innerDiv.datagrid('checkRow', firstErrIndex);
                            innerDiv.datagrid('checkRow', lastErrIndex);
                            errMessage = '第' + (firstErrIndex + 1) + '条与第' + (lastErrIndex + 1) + '条冲突';
                            break;
                        }
                        if (errMessage !== '') {
                            $.messager.alert('信息', errMessage, 'info', function () { });
                            return;
                        }
                        tableDiv.datagrid('sort', {	        // 指定了排序顺序的列
                            sortName: sortName.join(','),
                            sortOrder: sortOrder.join(',')
                        });
                        dialogDiv.dialog('close', true);


                    }
                }, {
                    text: '关闭',
                    iconCls: 'icon-save',
                    handler: function () {
                        // 结束编辑;
                        var innerDiv = view.getTableDiv();
                        if (innerDiv.datagrid('cell')) {
                            innerDiv.datagrid('endEdit', innerDiv.datagrid('cell').index);
                        }
                        innerDiv.datagrid('uncheckAll');
                        dialogDiv.dialog('close', true);
                    }
                }],
            });

        },
        find: function () {
            if (page.dialogPage.findDiv) {
                page.dialogPage.findDiv.dialog('open', true);
                return;
            }
            var dialogDiv = $('<div></div>');
            dialogDiv.appendTo(page.getDialogContainerDiv());
            page.dialogPage.findDiv = dialogDiv;


            // var sortTableDiv = $('<div></div>');
            // sortTableDiv.appendTo(dialogDiv);
            var view = new lwTable(dialogDiv);

            //init fields
            //init fields
            var fieldData = getFieldData();

            view.makeNewRow = () => {
                return {
                    leftBracket: '',
                    field: fieldData[0] ? fieldData[0].field : '',
                    compareSymbol: 'like',
                    value: '',
                    rightBracket: '',
                    logicalSymbol: 'and'
                };
            };
            var op = {};
            op.buttonOption = {
                footAdd: {
                    text: '添加条件(<ins>A</ins>)',
                },
                delete: {
                    text: '删除条件(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                },
                up: true,
                down: true,
            };


            op.tableOption = {
                // idField: 'id',
                // loadMsg: '数据加载中,请稍后',
                fit: true,
                fitColumns: true,
                //singleSelect: true,
                //url: '/' + divID + '/findAll',
                //method: 'post',
                toolbar: '',
                striped: true,
                pagination: false,
                rownumbers: true,
                // pageNumber: 1,
                // pageSize: '50',
                // pageList: [50, 200, 500, 5000],
                // remoteSort: false,
                // multiSort: true,   
                onBeforeCellEdit: function (index, field) {
                    if (field !== 'value') { return; }
                    var editor = null;
                    // var formatter = null;
                    var currentField = view.getTableDiv().datagrid('getRows')[index].field;
                    tableDiv.datagrid('options').columns[0].forEach(column => {
                        if (column.field === currentField) {
                            editor = column.editor;
                            //formatter = column.formatter;
                        }
                    });
                    var op = view.getTableDiv().datagrid('getColumnOption', field);
                    op.editor = editor;
                    //op.formatter = formatter;
                },
                onEndEdit: function (index, row, changes) {
                    if (!Object.keys(changes).includes('value')) { return; }
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'value'
                    });
                    if (ed.type == 'combobox') {
                        row.viewValue = $(ed.target).combobox('getText')
                    } else if (ed.type == 'combogrid') {
                        row.viewValue = $(ed.target).combogrid('getText')
                    } else {
                        row.viewValue = null;
                    }
                },
            };
            var compareSymbolData = [
                {
                    value: 'like',
                    text: '相似'
                },
                {
                    value: 'eq',
                    text: '等于'
                }, {
                    value: 'ne',
                    text: '不等于'
                }, {
                    value: 'gt',
                    text: '大于'
                }, {
                    value: 'lt',
                    text: '小于'
                }, {
                    value: 'notLike',
                    text: '不相似'
                }
            ];
            op.tableOption.columns = [[
                {
                    field: 'ck',
                    checkbox: true
                },
                {
                    field: 'leftBracket',
                    title: '左括号',
                    sortable: false,
                    width: 30,
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 60,
                            panelHeight: 68,
                            //panelHeight: fieldData.length * 20 + 15,
                            editable: true,
                            valueField: 'value',
                            textField: 'text',
                            limitToList: true,
                            data: [{
                                value: '(',
                                text: '('
                            }, {
                                value: '((',
                                text: '(('
                            }, {
                                value: '(((',
                                text: '((('
                            }]
                        }
                    }
                },
                {
                    field: 'field',
                    title: '字段',
                    sortable: false,
                    width: 60,
                    formatter: function (value, row, index) {
                        //if(value){
                        let item = fieldData.find(item => item.field == value);
                        return item != undefined ? item.title : '';
                        //}                        
                    },
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 60,
                            //panelHeight:75,
                            panelHeight: fieldData.length * 20 + 15,
                            editable: true,
                            valueField: 'field',
                            textField: 'title',
                            limitToList: true,
                            data: fieldData,
                        }
                    }
                },
                {
                    field: 'compareSymbol',
                    title: '比较符号',
                    sortable: false,
                    width: 40,
                    formatter: function (value, row, index) {
                        //if(value){
                        let item = compareSymbolData.find(item => item.value == value);
                        return item != undefined ? item.text : '';
                        //}                        
                    },
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 60,
                            panelHeight: 135,
                            editable: true,
                            valueField: 'value',
                            textField: 'text',
                            limitToList: true,
                            data: compareSymbolData,
                        }
                    }
                },
                {
                    field: 'value',
                    title: '内容',
                    sortable: false,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {
                            //panelWidth: 160,
                            //editable: true,                            
                        }
                    },
                    formatter: function (value, row, index) {
                        if (row.viewValue) { return row.viewValue; }
                        return value;
                    }
                },
                {
                    field: 'rightBracket',
                    title: '右括号',
                    sortable: false,
                    width: 30,
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 60,
                            panelHeight: 68,
                            //panelHeight: fieldData.length * 20 + 15,
                            editable: true,
                            valueField: 'value',
                            textField: 'text',
                            limitToList: true,
                            data: [{
                                value: ')',
                                text: ')'
                            }, {
                                value: '))',
                                text: '))'
                            }, {
                                value: ')))',
                                text: ')))'
                            }]
                        }
                    }
                },
                {
                    field: 'logicalSymbol',
                    title: '逻辑符',
                    sortable: false,
                    width: 30,
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 60,
                            panelHeight: 50,
                            //panelHeight: fieldData.length * 20 + 15,
                            editable: true,
                            valueField: 'value',
                            textField: 'text',
                            limitToList: true,
                            data: [{
                                value: 'and',
                                text: 'and'
                            }, {
                                value: 'or',
                                text: 'or'
                            }]
                        }
                    }
                }
            ]];

            view.addBuildFunction(() => {
                view.getTableDiv().datagrid('appendRow', view.makeNewRow());
            });

            //view.build();

            dialogDiv.dialog({
                onBeforeOpen: function () {
                    view.build(op);
                },
                width: 600,
                height: 400,
                iconCls: 'icon-save',
                title: '综合查找',
                modal: true,
                //toolbar: '#dlg-toolbar',
                toolbar: view.getToolBarDiv(),
                buttons: [{
                    text: '确定',
                    iconCls: 'icon-save',
                    handler: function () {
                        //结束编辑,清空选择
                        var innerDiv = view.getTableDiv();
                        if (innerDiv.datagrid('cell')) {
                            innerDiv.datagrid('endEdit', innerDiv.datagrid('cell').index);
                        }
                        innerDiv.datagrid('uncheckAll');

                        var whereRows = innerDiv.datagrid('getData').rows;
                        var lastWhere = ['and'];

                        var allBracketLength = 0;
                        var errMessage = '';
                        for (let row of whereRows) {
                            //括号错误
                            allBracketLength += row.leftBracket.length;
                            allBracketLength -= row.rightBracket.length;
                            if (allBracketLength < 0) {
                                errMessage = '括号错误';
                                break;
                            }
                            //逻辑符号

                            if (lastWhere != 'or' && lastWhere != 'and') {
                                errMessage = '逻辑符号错误';
                                break;
                            }

                            // if (!fieldData.includes(row.field)){
                            //     errMessage = '列名错误';
                            //     break;
                            // }
                            // if (!fieldData.includes(row.field)){
                            //     errMessage = '列名错误';
                            //     break;
                            // }

                            lastWhere = row.logicalSymbol;
                        }
                        if (errMessage) {
                            $.messager.alert('信息', errMessage, 'info', function () {
                                //dialogDiv.dialog('close', true);
                            });
                            return;
                        }
                        if (allBracketLength != 0) {
                            errMessage = '括号错误';
                            $.messager.alert('信息', errMessage, 'info', function () {
                                //dialogDiv.dialog('close', true);
                            });
                            return;
                        }

                        dialogDiv.dialog('close', true);
                        tableDiv.datagrid('load', {
                            where: JSON.stringify(whereRows)
                        });

                    }
                }, {
                    text: '关闭',
                    iconCls: 'icon-save',
                    handler: function () {
                        // 结束编辑;
                        var innerDiv = view.getTableDiv();
                        if (innerDiv.datagrid('cell')) {
                            innerDiv.datagrid('endEdit', innerDiv.datagrid('cell').index);
                        }
                        innerDiv.datagrid('uncheckAll');
                        dialogDiv.dialog('close', true);
                    }
                }],
            });

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
        print: function () {
            console.log(page);
        },
        save: function () {

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
                    //tableDiv.datagrid('getPanel').focus(); //重置焦点
                });
                return;
            }
            let sendString = JSON.stringify(sendObject);
            sendObject = {
                value: sendString
            };
            //console.log(JSON.stringify(sendObject));
            var url = tableDiv.datagrid('options').saveUrl;
            $.post(url, sendObject)
                .done(function (data) {
                    $.messager.alert('提示', data.message, 'info', function () {
                        tableDiv.datagrid('reload');
                        tableDiv.datagrid('loaded');
                        //tableDiv.datagrid('getPanel').focus();
                        //searchBoxDiv.textbox('textbox').focus();//重置焦点
                    });

                })
                .fail(function (err) {
                    //console.log(err);
                    $.messager.alert('失败', err.responseText, 'warning', function () {
                        tableDiv.datagrid('loaded');
                        //searchBoxDiv.textbox('textbox').focus();//重置焦点
                    });
                });

        },
        redo: function () {
            tableDiv.datagrid('rejectChanges');
            //searchBoxDiv.textbox('textbox').focus();//重置焦点
        },
        replace: function () {
            if (page.dialogPage.replaceDiv) {
                page.dialogPage.replaceDiv.dialog('open', true);
                return;
            }
            var dialogDiv = $('<div></div>');
            dialogDiv.appendTo(page.getDialogContainerDiv());
            page.dialogPage.replaceDiv = dialogDiv;


            // var sortTableDiv = $('<div></div>');
            // sortTableDiv.appendTo(dialogDiv);
            var view = new lwTable(dialogDiv);

            //init fields
            var fieldData = getFieldData(true);
            view.makeNewRow = () => {
                return {
                    field: fieldData[0] ? fieldData[0].field : '',
                    value: '',
                };
            };
            var op = {};
            op.buttonOption = {
                footAdd: {
                    text: '添加条件(<ins>A</ins>)',
                },
                delete: {
                    text: '删除条件(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                },
                up: true,
                down: true,
            };

            op.tableOption = {
                // idField: 'id',
                // loadMsg: '数据加载中,请稍后',
                fit: true,
                fitColumns: true,
                //singleSelect: true,
                //url: '/' + divID + '/findAll',
                //method: 'post',
                toolbar: '',
                striped: true,
                pagination: false,
                rownumbers: true,
                // pageNumber: 1,
                // pageSize: '50',
                // pageList: [50, 200, 500, 5000],
                // remoteSort: false,
                // multiSort: true,   
                onBeforeCellEdit: function (index, field) {
                    if (field !== 'value') { return; }
                    var editor = null;
                    // var formatter = null;
                    var currentField = view.getTableDiv().datagrid('getRows')[index].field;
                    tableDiv.datagrid('options').columns[0].forEach(column => {
                        if (column.field === currentField) {
                            editor = column.editor;
                            //formatter = column.formatter;
                        }
                    });
                    var op = view.getTableDiv().datagrid('getColumnOption', field);
                    op.editor = editor;
                    //op.formatter = formatter;
                }

            };

            op.tableOption.columns = [[
                {
                    field: 'ck',
                    checkbox: true
                },
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
                            //panelWidth: 60,
                            //panelHeight:75,
                            panelHeight: fieldData.length * 20 + 15,
                            editable: true,
                            valueField: 'field',
                            textField: 'title',
                            limitToList: true,
                            data: fieldData,
                        }
                    }
                },
                {
                    field: 'value',
                    title: '内容',
                    sortable: false,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {
                            //panelWidth: 160,
                            //editable: true,                            
                        }
                    }
                },
            ]];

            //init table
            view.addBuildFunction(() => {
                view.getTableDiv().datagrid('appendRow', view.makeNewRow());
            });


            //view.build();

            dialogDiv.dialog({
                onBeforeOpen: function () {
                    view.build(op);
                },
                width: 600,
                height: 400,
                iconCls: 'icon-save',
                title: '替换当前条件下的值',
                modal: true,
                //toolbar: '#dlg-toolbar',
                toolbar: view.getToolBarDiv(),
                buttons: [{
                    text: '确定',
                    iconCls: 'icon-save',
                    handler: function () {
                        //结束编辑,清空选择
                        var innerDiv = view.getTableDiv();
                        if (innerDiv.datagrid('cell')) {
                            innerDiv.datagrid('endEdit', innerDiv.datagrid('cell').index);
                        }
                        innerDiv.datagrid('uncheckAll');

                        var rows = innerDiv.datagrid('getData').rows;
                        var updateName = [];
                        var updateObj = [];
                        var errMessage = '';
                        for (let row of rows) {
                            let firstErrIndex = updateName.indexOf(row.field);
                            if (firstErrIndex === -1) {
                                updateName.push(row.field);
                                updateObj.push(row);
                                continue;
                            }
                            let lastErrIndex = updateName.length;
                            innerDiv.datagrid('checkRow', firstErrIndex);
                            innerDiv.datagrid('checkRow', lastErrIndex);
                            errMessage = '第' + (firstErrIndex + 1) + '条与第' + (lastErrIndex + 1) + '条冲突';
                            break;
                        }
                        if (errMessage !== '') {
                            $.messager.alert('信息', errMessage, 'info', function () { });
                            return;
                        }
                        var sendObject = Object.assign({}, tableDiv.datagrid('options').queryParams);
                        sendObject.update = JSON.stringify(rows);

                        //console.log(JSON.stringify(sendObject));
                        var url = tableDiv.datagrid('options').replaceUrl;
                        $.post(url, sendObject)
                            .done(function (data) {
                                $.messager.alert('提示', data.message, 'info', function () {
                                    tableDiv.datagrid('reload');
                                    tableDiv.datagrid('loaded');
                                    //tableDiv.datagrid('getPanel').focus();
                                    //searchBoxDiv.textbox('textbox').focus();//重置焦点
                                });

                            })
                            .fail(function (err) {
                                console.log(err);
                                $.messager.alert('失败', '请检查网络连接', 'warning', function () {
                                    tableDiv.datagrid('loaded');
                                    //searchBoxDiv.textbox('textbox').focus();//重置焦点
                                });
                            });



                        dialogDiv.dialog('close', true);

                    }
                }, {
                    text: '关闭',
                    iconCls: 'icon-save',
                    handler: function () {
                        // 结束编辑;
                        if (tableDiv.datagrid('cell')) {
                            tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                        }
                        dialogDiv.dialog('close', true);
                    }
                }],
            });

        },
    };
};

var lwTable = function (anchorDiv) {
    //start make view************************************
    //table*********************
    var tableDiv = $('<div></div>');
    tableDiv.appendTo(anchorDiv);
    //tableDiv.insertAfter(toolBarDiv);
    this.getTableDiv = () => { return tableDiv; };

    //toolBarDiv*****************
    var toolBarDiv = $('<div></div>');
    toolBarDiv.appendTo(anchorDiv);

    // toolBarDiv.css('margin', '0 auto');
    // toolBarDiv.css('text-align', 'center');

    this.getToolBarDiv = () => { return toolBarDiv; };

    //searchBox******************
    var searchContainerDiv = $('<span></span>');
    searchContainerDiv.appendTo(toolBarDiv);

    var searchBoxDiv = $('<div></div>');
    searchBoxDiv.appendTo(searchContainerDiv);


    //buttons******************
    var buttonContainerDiv = $('<span></span>');
    //buttonContainerDiv.css('margin', '0 auto');
    //buttonContainerDiv.css('text-align', 'center');
    buttonContainerDiv.css('margin-left', 40);
    buttonContainerDiv.appendTo(toolBarDiv);
    //this.getButtonContainerDiv = () => { return buttonContainerDiv; };

    //dialogDiv*****************
    var dialogContainerDiv = $('<div></div>');
    dialogContainerDiv.appendTo(anchorDiv);
    this.getDialogContainerDiv = () => { return dialogContainerDiv; };
    //end make view************************************




    //start init************************************
    //table init*****************
    // this.makeNewRow = (field) => {
    //     if (!field) {
    //         //新增内容
    //         return {
    //             id: 'N' + Math.round(Math.random() * 100000),
    //         };
    //     } else {
    //         //新增内容后开始编辑的字段
    //         return 'id';
    //     }

    // };


    this.makeNewRow = new Function();

    var defaultTableOption = {
        idField: 'id',
        //loadMsg: '数据加载中,请稍后',
        fit: true,
        fitColumns: true,
        singleSelect: false,
        //url: '/' + divID + '/findAll',
        //method: 'post',
        toolbar: toolBarDiv,
        striped: true,
        pagination: true,
        rownumbers: true,
        pageNumber: 1,
        pageSize: '50',
        pageList: [50, 200, 500, 5000],
        //remoteSort: false,
        //multiSort: true,
        onCellEdit: tableEvents().onCellEdit,
        onLoadError: tableEvents().onLoadError,
        onLoadSuccess: () => {
            //searchBoxDiv.textbox('textbox').focus();
            //tableDiv.datagrid('getPanel').focus();//不好用
        },
    };
    if (anchorDiv[0].id && anchorDiv[0].id != '') {
        defaultTableOption.url = `/${anchorDiv[0].id}/findAll`;
        defaultTableOption.saveUrl = `/${anchorDiv[0].id}/save`;
        defaultTableOption.replaceUrl = `/${anchorDiv[0].id}/update`;
    }
    var _buildTable = (tableOption) => {
        tableOption = Object.assign(defaultTableOption, tableOption);
        if (!tableOption.sortName) {
            for (let column of [].concat(...tableOption.columns)) {
                if (column.field == 'sn') {
                    tableOption.sortName = 'sn';
                    tableOption.sortOrder = 'asc';
                    break;
                }
            }
        }

        //根据listOnly属性判断是否开启cellEdit功能。
        if (tableOption.listOnly) {
            tableDiv.datagrid(tableOption);
        } else {
            tableDiv.datagrid(tableOption).datagrid('enableCellEditing');
        }



    };
    //buildArray.push(_buildTable);




    //searchBox init*****************

    var searchBoxMenuDiv = $('<div></div>');
    var defalutSearchBoxOption = {
        searcher: function (value, name) {
            tableDiv.datagrid('load', {
                name: name,
                value: value,
                isEq: false,
            });
        },
        menu: searchBoxMenuDiv,
        prompt: '请输入值',
        width: '300'
    };

    let _buildSearchox = (searchBoxOption) => {
        if (!searchBoxOption || !searchBoxOption.menu) { return; }
        searchBoxMenuDiv.menu();
        searchBoxOption.menu.forEach(item => searchBoxMenuDiv.menu('appendItem', item));

        var option = Object.assign({}, defalutSearchBoxOption, searchBoxOption.option);
        searchBoxDiv.searchbox(option);



        /**
             * item
             * {
                name:'xm',
                text: '姓名',
                //iconCls: 'icon-ok',
                //onclick: function () { alert('提示：新菜单项！'); }
            }
             */

    };


    var buttonsFunction = buttonFunctionMaker(this);
    //this.getButtonsFunction = () => buttonsFunction;
    //buttons init*****************
    var allButtons = {
        importExcel: {
            text: '导入(<ins>I</ins>)',
            iconCls: 'icon-search',
            onClick: buttonsFunction.print,
        },
        exportExcel: {
            text: '导出(<ins>E</ins>)',
            iconCls: 'icon-search',
            onClick: buttonsFunction.print,
        },
        sort: {
            text: '排序(<ins>P</ins>)',
            iconCls: 'icon-search',
            onClick: buttonsFunction.sort,
        },
        search: {
            text: '查询(<ins>F</ins>)',
            iconCls: 'icon-search',
            onClick: buttonsFunction.find,
        },
        headAdd: {
            text: '添加(<ins>A</ins>)',
            iconCls: 'icon-add',
            onClick: buttonsFunction.headAdd,
        },
        insert: {
            text: '插入(<ins>I</ins>)',
            iconCls: 'icon-add',
            onClick: buttonsFunction.insert,
        },
        save: {
            text: '保存(<ins>S</ins>)',
            iconCls: 'icon-save',
            onClick: buttonsFunction.save,
        },
        delete: {
            text: '删除(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
            iconCls: 'icon-search',
            onClick: buttonsFunction.del
        },
        redo: {
            text: '撤销(<ins>L</ins>)',
            iconCls: 'icon-redo',
            onClick: buttonsFunction.redo
        },
        replace: {
            text: '替换(<ins>R</ins>)',
            iconCls: 'icon-redo',
            onClick: buttonsFunction.replace
        },
        footAdd: {
            text: '添加条件(<ins>A</ins>)',
            iconCls: 'icon-add',
            onClick: buttonsFunction.footAdd,
        },
        up: {
            text: '上',
            //iconCls: 'icon-copy',
            onClick: buttonsFunction.up,
        },
        down: {
            text: '下',
            //iconCls: 'icon-copy',
            onClick: buttonsFunction.down,
        },

    };
    this.getAllButtons = () => allButtons;

    var buttons = {};
    this.getButtons = () => buttons;

    var _buildButtons = (buttonOption) => {
        Object.keys(buttonOption).forEach((key) => {
            if (!allButtons[key]) {
                buttons[key] = buttonOption[key];
                return;
            }
            buttons[key] = allButtons[key];
            if (typeof buttonOption[key] === 'object') {
                buttons[key] = Object.assign(buttons[key], buttonOption[key]);
            }
        });


        Object.keys(buttons).forEach(function (buttonName) {
            $('<a></a>')
                .css('margin-left', 5)
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
    //buildArray.push(_buildButtons);


    //buttons init*****************
    this.dialogPage = {};

    var buildArray = [];
    this.addBuildFunction = (func) => buildArray.push(func);
    //构建页面
    this.build = function (option) {
        _buildTable(option.tableOption);
        _buildSearchox(option.searchBoxOption);
        _buildButtons(option.buttonOption);
        buildArray.forEach(item => item(this));
    };




};


