<div id='mix' style="height: 100%;"></div>
<script>
    //@ sourceURL=mix.js
    void function () {
        var anchorDiv = $('#mix');
        var view = new lwTable(anchorDiv);

        // var userType = null;
        // $.post('/userType/findAll', {
        //     sort: 'sn',
        //     order: 'asc',
        //     originalModel: true,
        // })
        //     .done(function (data) {
        //         userType = data.rows;
        //         init();
        //     })
        //     .fail(function () {

        //     });


        var init = function () {
            var op = {};
            //searchBox设置**************************************************
            op.searchBoxOption = {};
            op.searchBoxOption.option = {
                searcher: function (value, name) {
                    // view.getTableDiv().datagrid({
                    //     url: '/mix/findAll'
                    // });
                    if (name == 'Card.card_number') {
                        view.getTableDiv().datagrid('load', {
                            isEq: true,
                            name: name,
                            value: value
                        });
                    } else {
                        view.getTableDiv().datagrid('load', {
                            name: name,
                            value: value
                        });
                    }

                },
            };
            // op.searchBoxOption.option = {
            //     searcher: function (value, name) {
            //         view.getTableDiv().datagrid('load', {
            //             name: name,
            //             value: value
            //         });
            //     },
            //     prompt: '请输入值111',
            //     menu: '#abc'
            // };
            op.searchBoxOption.menu = [
                { name: 'Card.card_number', text: '会员卡号' },
                { name: 'name', text: '会员名' },
                { name: 'phone', text: '会员电话' },
                { name: 'otherphone', text: '其他电话' },
                { name: 'Card.name', text: '会员卡主名' },
                { name: 'remark', text: '备注' },
            ];

            //buttons设置**************************************************
            op.buttonOption = {
                // importExcel: true,
                // exportExcel: true,
                // addNewCard: {
                //     text: '新卡开户(<ins>N</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                //     iconCls: 'icon-search',
                //     onClick: function () {
                //         console.log(view);
                //     }
                // },
                addNewMember: {
                    text: '添加新会员(<ins>N</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                    iconCls: 'icon-search',
                    onClick: function () {
                        addNewMember();
                    },

                },
                // sort: true,
                // search: true,
                // replace: true,
                // headAdd: true,
                // insert: true,
                // save: true,
                // delete: true,
                // del: {
                //     text: '删除条件(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                //     iconCls: 'icon-search',
                //     onClick: function () {
                //         console.log(view);
                //     }
                // },
                // redo: true,
            };

            //表格设置**************************************************
            view.currentRow = null;
            var addNewMember = function () {
                //console.log('addNewMember');
                var dialogTitle = '增添新会员';
                // var dialogTitle = '';
                if (view.dialogPage.addNewMemberDiv) {
                    view.dialogPage.addNewMemberDiv.dialog('setTitle', dialogTitle);
                    view.dialogPage.addNewMemberDiv.dialog('open', true);
                    return;
                }
                var dialogDiv = $('<div></div>');
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.addNewMemberDiv = dialogDiv;

                var layDiv = $('<div></div>');
                layDiv.appendTo(dialogDiv);

                layDiv.layout({
                    fit: true
                });

                //卡号查询区域设置*******************************************************************************************************************
                layDiv.layout('add', {
                    region: 'north',
                    // width: '50%',
                    minHeight: 55,
                    // title: '会员卡号',
                })
                var topRegion = $('<div style="height:20px;padding:12px"></div>').appendTo(layDiv.layout('panel', 'north'));
                var cardNumberDiv = $('<div></div>').appendTo($('<span></span>').appendTo(topRegion));
                // var cardNumberDiv = $('<div></div>').appendTo($('<span><div style="width:300px;height:20px;padding:12px"></div></span>').appendTo(topRegion));
                cardNumberDiv.textbox({
                    label: '会员卡号:',
                    // //prompt: 'Ent',
                    width: '300',
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    validType: ['isNumber', 'length[1,10]'],
                    tipPosition: 'left'
                    //labelWidth: '120'
                }).textbox('textbox').select();
                cardNumberDiv.textbox('textbox').keydown(function (e) {
                    if (e.key === 'Enter') {
                        setTimeout(searchCardNumberBtnHandle, 0);
                    }
                });
                var buttonContainerDiv = $('<span></span>').appendTo(topRegion);
                var searchCardNumberBtn = $('<a style="margin-left:20px;"></a>').appendTo(buttonContainerDiv);
                var unlockCardNumberBtn = $('<a style="margin-left:20px;"></a>').appendTo(buttonContainerDiv);

                view.isNewCard = false;
                var currnetTbDivArray = [];

                var searchCardNumberBtnHandle = function () {
                    var value = cardNumberDiv.textbox('getValue');

                    if (!value || value.trim().length == 0 || !cardNumberDiv.textbox('isValid')) {
                        $.messager.alert('警告', '请输入正确卡号');
                        return;
                    }

                    // if (!value || value.trim().length == 0 || value.trim().length > 10 || !(/^\d+$/).test(value)) {
                    //     $.messager.alert('警告', '请输入正确卡号');
                    //     return;
                    // }
                    $.post('/mix/searchCardNumber', { card_number: value })
                        .done(function (data) {
                            // console.log(data);
                            currnetTbDivArray = [];
                            if (data.message) {
                                $.messager.alert('警告', data.message);
                                return;
                            };
                            view.isNewCard = data.isNew;
                            if (view.isNewCard) {
                                cardNumberDiv.textbox('setValue', `新卡号：${value}`);
                                cardTbDivArray.forEach(tb => tb.textbox('enable'));
                                currnetTbDivArray = cardTbDivArray;
                            } else {
                                let card = data.card;
                                currnetTbDivArray = memberTbDivArray;
                                //设置cardTb的value
                                cardTbValues = [card.CardType.name, card.name, card.phone, card.otherphone, card.remark];
                                for (let i = 0; i < 5; i++) {
                                    cardTbDivArray[i].textbox('setValue', cardTbValues[i]);
                                }
                                memberTbDivArray.forEach(tb => tb.textbox('enable'));
                            }
                            cardNumberDiv.textbox('disable');
                            searchCardNumberBtn.linkbutton('disable');
                            currnetTbDivArray[0].textbox('textbox').select();
                        })
                };
                searchCardNumberBtn.linkbutton({
                    iconCls: 'icon-search',
                    text: '查询卡号',
                    onClick: searchCardNumberBtnHandle
                });


                var unlockCardNumberBtnHandle = function () {
                    currnetTbDivArray = [];
                    cardNumberDiv.textbox('reset').textbox('enable').textbox('textbox').select();
                    searchCardNumberBtn.linkbutton('enable');

                    cardTbDivArray.forEach(tb => tb.textbox('disable').textbox('reset'));
                    memberTbDivArray.forEach(tb => tb.textbox('disable').textbox('reset'));
                }

                unlockCardNumberBtn.linkbutton({
                    iconCls: 'icon-search',
                    text: '重置卡号',
                    onClick: unlockCardNumberBtnHandle
                });


                //会员卡信息区域设置*****************************************************************************************
                layDiv.layout('add', {
                    region: 'west',
                    collapsible: false,
                    width: '50%',
                    title: '会员卡信息',
                })

                var leftRegion = layDiv.layout('panel', 'west');


                var cardTypeDiv = $('<div></div>');
                var cardTbDivArray = [cardTypeDiv];
                cardTypeDiv.appendTo($('<div style="width:300px;height:30px;padding:12px"></div>').appendTo(leftRegion));
                cardTypeDiv.combobox({
                    width: '100%',
                    label: '会员卡类型:',
                    labelPosition: 'before',
                    labelAlign: 'left',
                    labelWidth: '130',
                    //queryParams: { findBy: ['id', 'name'] },
                    // panelWidth: 160,
                    // editable: false,
                    editable: true,
                    valueField: 'id',
                    textField: 'name',
                    mode: 'remote',
                    url: '/cardType/findAll',
                    loadFilter: function (data) {
                        return data.rows;
                    },
                    //data: userType,
                    panelHeight: 100,
                    disabled: true,
                    required: true,
                });
                var cardPassDiv = $('<div></div>');
                cardTbDivArray.push(cardPassDiv);
                cardPassDiv.appendTo($('<div style="width:300px;height:30px;padding:12px"></div>').appendTo(leftRegion));
                cardPassDiv.passwordbox({
                    width: '100%',
                    label: '会员卡密码:',
                    labelPosition: 'before',
                    labelAlign: 'left',
                    labelWidth: '130',

                    // prompt: '请输入密码',
                    // iconWidth: 28,
                    showEye: true,
                    disabled: true,

                });


                var cardTbOpArray = [
                    {
                        label: '会员卡主名:',
                        required: true,
                        // validType: ['isNumber', 'length[1,10]'],
                        //prompt: 'Ent'
                    },
                    {
                        label: '会员卡主电话:',
                        required: true,
                        validType: ['isNumber', 'length[8,11]'],
                        //prompt: 'Ent'
                    },
                    {
                        label: '会员卡主其他电话:',
                        //prompt: 'Ent'
                    },
                    {
                        label: '会员卡备注:',
                        //prompt: 'Ent'
                    },
                ]
                cardTbOpArray.forEach(tb => {
                    var op = {
                        width: '100%',
                        labelPosition: 'before',
                        labelAlign: 'left',
                        labelWidth: '130',
                        disabled: true,
                    }
                    op = Object.assign(op, tb);
                    // console.log(op);
                    var tbDiv = $('<div></div>');
                    tbDiv.appendTo($('<div style="width:300px;height:30px;padding:12px"></div>').appendTo(leftRegion));

                    tbDiv.textbox(op);
                    cardTbDivArray.push(tbDiv);
                })






                //会员信息区域设置*******************************************************************************************************************
                layDiv.layout('add', {
                    region: 'east',
                    collapsible: false,
                    width: '50%',
                    title: '会员信息',
                });
                // var rightRegion = $('<div></div>');
                var rightRegion = layDiv.layout('panel', 'east');

                // var cardTypeDiv = $('<div></div>');
                // var emptyDiv = $('<div style="width:300px;height:30px;padding:12px"></div>').appendTo(leftRegion);
                // var memberTbDivArray = [emptyDiv];

                $('<div style="width:300px;height:30px;padding:12px"></div>').appendTo(rightRegion);
                $('<div style="width:300px;height:30px;padding:12px"></div>').appendTo(rightRegion);


                var memberTbOpArray = [
                    {
                        label: '会员名:',
                        required: true,
                        //prompt: 'Ent'
                    },
                    {
                        label: '会员电话:',
                        required: true,
                        validType: ['isNumber', 'length[8,11]'],
                        //prompt: 'Ent'
                    },
                    {
                        label: '会员其他电话:',
                        //prompt: 'Ent'
                    },
                    {
                        label: '会员备注:',
                        //prompt: 'Ent'
                    },
                ];
                var memberTbDivArray = memberTbOpArray.map(tb => {
                    var op = {
                        width: '100%',
                        labelPosition: 'before',
                        labelAlign: 'left',
                        labelWidth: '130',
                        disabled: true,
                    }
                    op = Object.assign(op, tb);
                    // console.log(op);
                    var tbDiv = $('<div></div>');
                    tbDiv.appendTo($('<div style="width:300px;height:30px;padding:12px"></div>').appendTo(rightRegion));

                    tbDiv.textbox(op);
                    return tbDiv;
                });



                var addNewMemberHandler = function () {
                    //发送新用户信息;
                    if (!Array.isArray(currnetTbDivArray) || currnetTbDivArray.length === 0) {
                        $.messager.alert('警告', '无有效信息');
                        return;
                    }
                    var sendArray = [cardNumberDiv.textbox('getValue')];
                    for (tbDiv of currnetTbDivArray) {
                        if (!tbDiv.textbox('isValid')) {
                            $.messager.alert('警告', '请输入正确的:<span style="color:LightCoral"><b>' + tbDiv.textbox('options').label.slice(0, -1)) + '</b></span>';
                            return;
                        };
                        var value = tbDiv.textbox('getValue');
                        sendArray.push(value);
                    };
                    // currnetTbDivArray.forEach(tbDiv => {
                    //     // console.log('getText:' + tbDiv.textbox('getText'));
                    //     // console.log('getValue:' + tbDiv.textbox('getValue'));
                    //     if (!tbDiv.textbox('isValid')) {
                    //         $.messager.alert('警告', '请输入正确' + tbDiv.textbox('options').label);
                    // return;
                    //     };
                    //     var value = tbDiv.textbox('getValue');
                    //     sendArray.push(value);
                    // });
                    var sendKey = '';
                    if (currnetTbDivArray === cardTbDivArray) {
                        sendKey = 'card';
                    } else if (currnetTbDivArray === memberTbDivArray) {
                        sendKey = 'member';
                    } else {
                        $.messager.alert('警告', '无有效信息');
                        return;
                    }


                    // console.log($.fn.validatebox.defaults.rules);
                    $.post('/mix/addNewMerber', { [sendKey]: sendArray })
                        .done(function (data) {
                            if (data.message) {
                                $.messager.alert('警告', data.message);
                            } else {
                                $.messager.alert('提示', '保存成功', 'info', function () {
                                    unlockCardNumberBtnHandle();
                                    dialogDiv.dialog('close');
                                    // view.getTableDiv().datagrid('reload');
                                    view.getTableDiv().datagrid('load', {
                                        name: 'id',
                                        value: data.id
                                    });

                                });
                            }


                        });

                };
                var dialogOp = {
                    title: dialogTitle,
                    width: 700,
                    top: 120,
                    height: 500,
                    closable: false,
                    closed: false,
                    cache: false,
                    //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                    //href: 'get_content.php',
                    modal: true,
                    onBeforeOpen: function () {
                        // payView.build(payViewOp);
                    },
                    onOpen: function () {
                        view.isNewCard = false;
                        cardNumberDiv.textbox('reset').textbox('enable').textbox('textbox').select();
                    },
                    buttons: [{
                        text: '保存',
                        handler: addNewMemberHandler,
                    }, {
                        text: '关闭',
                        handler: function () {
                            //清理所有空间值;
                            unlockCardNumberBtnHandle();
                            dialogDiv.dialog('close');
                        }
                    }]
                };
                dialogDiv.dialog(dialogOp);
            };


            var empower = function () {
                //检测是否已授权
                if (view.currentRow.passed === true) {
                    view.currentRow.actionFunc();
                    return;
                }


                //
                if (view.dialogPage.passDiv) {
                    view.dialogPage.passDiv.dialog('setTitle', `请输入   ${view.currentRow.name}   的密码`);
                    view.dialogPage.passDiv.dialog('open', true);
                    return;
                }
                var dialogDiv = $('<div></div>');
                var passwordboxDiv = $('<div></div>');
                passwordboxDiv.appendTo(dialogDiv);
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.passDiv = dialogDiv;

                var passwordHandler = function () {
                    var value = passwordboxDiv.textbox('getValue');
                    $.post('card/verifyPass', {
                        id: view.currentRow.Card.id,
                        pass: value
                    }).done(function (data) {
                        if (data.passed) {
                            dialogDiv.dialog('close');
                            view.currentRow.passed = true;
                            view.currentRow.actionFunc();
                        } else {
                            $.messager.alert('提示', '密码错误请重新输入', 'info', function () {
                                //passwordboxDiv.textbox('textbox').focus();
                                view.currentRow.passed = false;
                                passwordboxDiv.textbox('textbox').select();
                            });
                        }
                    })
                }

                dialogDiv.keydown(function (e) {
                    if (e.key === 'Enter') {
                        passwordHandler();
                    }
                })

                var dialogOp = {
                    title: `请输入   ${view.currentRow.name}   的密码`,
                    width: 400,
                    top: 120,
                    //height: 120,
                    closed: false,
                    cache: false,
                    //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                    //href: 'get_content.php',
                    modal: true,
                    onBeforeOpen: function () {
                        passwordboxDiv.passwordbox({
                            width: '100%',
                            height: 45,
                            prompt: '请输入密码',
                            iconWidth: 28,
                            showEye: true
                        });
                    },
                    onOpen: function () {
                        passwordboxDiv.textbox('clear');
                        //设置焦点                            
                        passwordboxDiv.textbox('textbox').focus();
                    },
                    buttons: [{
                        text: '保存',
                        handler: passwordHandler,
                    }, {
                        text: '关闭',
                        handler: function () {
                            //dialogDiv.dialog('destroy');                            
                            dialogDiv.dialog('close');
                        }
                    }]
                };
                dialogDiv.dialog(dialogOp);
            };
            var pay = function () {
                if (!view.currentRow) {
                    return;
                }
                var memberName = view.currentRow.name;
                var balance = Number.parseFloat(view.currentRow.Card.balance);
                var discount = Number.parseFloat(view.currentRow.Card.CardType.discount * 100).toFixed(2) + '%';
                var dialogTitle = '';
                if (balance > 0) {
                    dialogTitle = `客户:&nbsp;<span style="color:DarkGreen">${memberName}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                   余额:&nbsp;<span style="color:DarkGreen">${balance.toFixed(2)}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                   折扣:&nbsp;<span style="color:DarkGreen">${discount}</span>`;
                } else {
                    dialogTitle = `客户:&nbsp;<span style="color:LightCoral">${memberName}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                   余额:&nbsp;<span style="color:LightCoral">${balance.toFixed(2)}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                   折扣:&nbsp;<span style="color:LightCoral">${discount}</span>`;
                }


                if (view.dialogPage.payDiv) {
                    view.dialogPage.payDiv.dialog('setTitle', dialogTitle);
                    view.dialogPage.payDiv.dialog('open', true);
                    return;
                }
                var dialogDiv = $('<div></div>');
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.payDiv = dialogDiv;

                //初始化内部菜单内容
                var payView = new lwTable(dialogDiv);

                payView.makeNewRow = () => {
                    var rows = payView.getTableDiv().datagrid('getRows');
                    if (rows.length == 0) {
                        return {
                            employee_id: '',
                            Employee: {},
                            // commodity_id: 1,
                            // unitPrice: 100,
                            quantity: 1,
                            whetherDiscount: '1',
                            is_cash: '0',
                            Employee: {
                                name: '<div style="color:red">请选择技师</div>',
                            },
                            Commodity: {
                                name: '<div style="color:red">请选择商品</div>',
                            },
                            id: Math.random(),
                            // is_cash: 1,
                            // price: 1,
                        };
                    } else {
                        var lastRow = rows[rows.length - 1];
                        return {
                            employee_id: lastRow.employee_id,
                            Employee: Object.assign({}, lastRow.Employee),
                            quantity: 1,
                            whetherDiscount: '1',
                            is_cash: '0',
                            id: Math.random(),
                        }
                    }
                };

                var refreshFooter = function () {
                    var tableDiv = payView.getTableDiv();
                    var gridData = tableDiv.datagrid('getData');
                    if (!Array.isArray(gridData.rows) || gridData.rows.length == 0) {
                        gridData.footer[0].price = 0.00;
                        gridData.footer[1].price = 0.00;
                        gridData.footer[2].price = 0.00;
                    } else {
                        gridData.footer[0].price = Number.parseFloat(
                            gridData.rows
                                .map((row) => !Number.isNaN(Number.parseFloat(row.price)) && row.is_cash === '1' ? Number.parseFloat(row.price) : 0)
                                .reduce(function (accumulator, currentValue, currentIndex, array) {
                                    return accumulator + currentValue;
                                }))
                            .toFixed(2);
                        gridData.footer[1].price = Number.parseFloat(
                            gridData.rows
                                .map((row) => !Number.isNaN(Number.parseFloat(row.price)) && row.is_cash === '0' ? Number.parseFloat(row.price) : 0)
                                .reduce(function (accumulator, currentValue, currentIndex, array) {
                                    return accumulator + currentValue;
                                }))
                            .toFixed(2);
                        gridData.footer[2].price = Number.parseFloat(
                            gridData.rows
                                .map((row) => !Number.isNaN(Number.parseFloat(row.price)) ? Number.parseFloat(row.price) : 0)
                                .reduce(function (accumulator, currentValue, currentIndex, array) {
                                    return accumulator + currentValue;
                                }))
                            .toFixed(2);
                    }

                    // obj.footer[0] = { price: 1000 };
                    tableDiv.datagrid('loadData', gridData);
                };

                var payViewOp = {};

                payViewOp.buttonOption = {
                    footAdd: {
                        text: '添加商品(<ins>A</ins>)',
                    },
                    delete: {
                        text: '删除商品(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                        iconCls: 'icon-search',
                        onClick: function () {
                            //结束编辑
                            var tableDiv = payView.getTableDiv();
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
                            refreshFooter();
                        },
                    },
                    // del: {
                    //     text: '删除条件(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                    //     iconCls: 'icon-search',
                    //     onClick: function () {
                    //         console.log(view);
                    //     }
                    // },
                };

                payViewOp.tableOption = {
                    // idField: 'id',
                    // loadMsg: '数据加载中,请稍后',
                    // fit: true,
                    // fitColumns: true,
                    // singleSelect: true,
                    // url: '/menu/findAll',
                    // method: 'post',
                    // toolbar: '',
                    // striped: true,
                    rownumbers: true,
                    pagination: false,
                    // pageNumber: 1,
                    // pageSize: '50',
                    // pageList: [50, 200, 500, 5000],
                    // sortName: 'sn',
                    // sortOrder: 'asc',
                    // onLoadSuccess: payViewTableOnLoadSuccess,
                    remoteSort: false,
                    multiSort: false,
                    showFooter: true,
                    onEndEdit: function (index, row, changes) {
                        var key = Object.keys(changes)[0];

                        if (key && key.includes('_id')) {
                            var ed = $(this).datagrid('getEditor', {
                                index: index,
                                field: key
                            });
                            var selectedRow = $(ed.target).combogrid('grid').datagrid('getSelected');
                            if (key === 'employee_id') {
                                if (!selectedRow) {
                                    row.employee_id = null;
                                    row.Employee = { name: '<div style="color:red">请选择技师</div>' };
                                } else {
                                    row.Employee = { name: selectedRow.name };
                                }
                            } else if (key === 'commodity_id') {
                                if (!selectedRow) {
                                    row.commodity_id = null;
                                    row.Commodity = { name: '<div style="color:red">请选择商品</div>' };
                                } else {
                                    row.unitPrice = selectedRow.price;
                                    row.Commodity = { name: selectedRow.name };
                                }
                            }
                        };

                        //重置价格
                        row.price = row.whetherDiscount === '1' ? row.unitPrice * row.quantity * view.currentRow.Card.CardType.discount : row.unitPrice * row.quantity;

                        //重置汇总
                        refreshFooter();
                    },
                };

                var combogridOnLoadSuccess = combogridEvents(payView).onLoadSuccess;
                var combogridOnShowPanel = combogridEvents(payView).onShowPanel;

                payViewOp.tableOption.columns = [[
                    {
                        field: 'ck',
                        checkbox: true
                    },
                    {
                        field: 'id',
                        hidden: true,
                    },
                    {
                        field: 'commodity_id',
                        title: '商品名',
                        width: 100,
                        formatter: function (value, row, index) {
                            return row.Commodity ? row.Commodity.name : '';
                        },
                        editor: {
                            type: 'combogrid',
                            options: {
                                //queryParams: { findBy: ['card_number', 'name'] },
                                mode: 'remote',
                                url: '/commodity/findAll',
                                panelWidth: 300,
                                //panelMaxHeight: 265,
                                //panelHeight: 200,
                                idField: 'id',
                                textField: 'name',
                                columns: [[
                                    // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },                               
                                    { field: 'name', title: '商品名', width: 165 },
                                    { field: 'price', title: '售价', width: 65 },
                                ]],
                                //reversed: true,
                                sortName: 'sn',
                                //避免出现滑条，造成选择的时候无法选中
                                pagination: true,
                                pageSize: 6,
                                pageList: [6],
                                //pagePosition: 'top',

                                rownumbers: true,
                                onLoadSuccess: combogridOnLoadSuccess,
                                onShowPanel: combogridOnShowPanel,
                            }
                        }

                    }, {
                        field: 'unitPrice',
                        title: '单价',
                        width: 80,
                        formatter: function (value, row, index) {
                            if (value) {
                                return Number.isNaN(Number.parseFloat(value)) ? '￥0.00' : '￥' + Number.parseFloat(value).toFixed(2);
                            } else {
                                return '';
                            }
                        }
                    }, {
                        field: 'quantity',
                        title: '数量',
                        width: 100,
                        editor: {
                            type: 'numberbox',
                            options: {
                                //prefix: '￥',
                                max: 500,
                                min: 1,
                                precision: 0
                            }
                        },
                    }, {
                        field: 'whetherDiscount',
                        title: '是否折扣',
                        width: 60,
                        editor: {
                            type: 'combobox',
                            options: {
                                //panelWidth: 160,                    
                                editable: false,
                                valueField: 'id',
                                textField: 'name',
                                data: [{ id: '0', name: '否' }, { id: '1', name: '是' }],
                                panelMaxHeight: 265,
                                panelHeight: 75,
                            }
                        },
                        formatter: function (value, row, index) {
                            switch (value) {
                                case '1': return '是';
                                case '0': return '否';
                                default: return '';
                            }
                        },
                    }, {
                        field: 'is_cash',
                        title: '是否现金',
                        width: 60,
                        editor: {
                            type: 'combobox',
                            options: {
                                //panelWidth: 160,                    
                                editable: false,
                                valueField: 'id',
                                textField: 'name',
                                data: [{ id: '0', name: '否' }, { id: '1', name: '是' }],
                                panelMaxHeight: 265,
                                panelHeight: 75,
                                // onShowPanel: function () {
                                //     $(this).combobox('loadData', userType);
                                //     $(this).combobox('panel').panel('resize', {
                                //         height: userType.length * 20 + 15
                                //     });
                                // }
                            }
                        },
                        formatter: function (value, row, index) {
                            switch (value) {
                                case '1': return '是';
                                case '0': return '否';
                                default: return '';
                            }
                        },
                    }, {
                        field: 'price',
                        title: '实收价格',
                        width: 100,
                        formatter: function (value, row, index) {
                            if (value) {
                                return Number.isNaN(Number.parseFloat(value)) ? '￥0.00' : '￥' + Number.parseFloat(value).toFixed(2);
                            } else {
                                return '';
                            }
                        }
                    }, {
                        field: 'remark',
                        title: '备注',
                        width: 100,
                        sortable: true,
                        editor: {
                            type: 'textbox',
                            options: {}
                        }
                    }, {
                        field: 'employee_id',
                        title: '技师',
                        width: 100,
                        formatter: function (value, row, index) {
                            return row.Employee ? row.Employee.name : '';
                        },
                        editor: {
                            type: 'combogrid',
                            options: {
                                // queryParams: { findBy: ['card_number', 'name'] },
                                mode: 'remote',
                                url: '/employee/findAll',
                                panelWidth: 300,
                                //panelMaxHeight: 265,
                                //panelHeight: 200,
                                idField: 'id',
                                textField: 'name',
                                columns: [[
                                    // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },
                                    // { field: 'card_number', title: '会员卡号', width: 100 },
                                    { field: 'name', title: '雇员名', width: 165 },
                                ]],
                                //reversed: true,
                                sortName: 'sn',
                                //避免出现滑条，造成选择的时候无法选中
                                pagination: true,
                                pageSize: 6,
                                pageList: [6],
                                //pagePosition: 'top',

                                rownumbers: true,
                                onLoadSuccess: combogridOnLoadSuccess,
                                onShowPanel: combogridOnShowPanel
                            }
                        }
                    },
                ]];

                var payHandler = function () {
                    var tableDiv = payView.getTableDiv();
                    //结束编辑
                    if (tableDiv.datagrid('cell')) {
                        tableDiv.datagrid('endEdit', tableDiv.datagrid('cell').index);
                    }
                    //校验数据
                    var rows = tableDiv.datagrid('getData').rows;
                    var errorMessage = '';
                    if (rows === undefined || rows.length == 0) {
                        errorMessage = '无有效商品信息';
                        $.messager.alert('提示', errorMessage, 'info', function () { });
                        return;
                    }
                    if (rows.some(row => {
                        if (!row.commodity_id) {
                            errorMessage = '商品信息错误';
                            return true;
                        }
                        if (row.quantity < 1 || row.quantity > 500) {
                            errorMessage = '商品数量超范围';
                            return true;
                        }
                        if (!row.employee_id) {
                            errorMessage = '技师信息错误';
                            return true;
                        }
                    })) {
                        $.messager.alert('提示', errorMessage, 'info', function () { });
                        return;
                    }

                    var payMessage = `
                    ${tableDiv.datagrid('getData').footer[0].Commodity.name}${tableDiv.datagrid('getData').footer[0].price}</br>
                    ${tableDiv.datagrid('getData').footer[1].Commodity.name}${tableDiv.datagrid('getData').footer[1].price}</br>
                    ${tableDiv.datagrid('getData').footer[2].Commodity.name}${tableDiv.datagrid('getData').footer[2].price}</br>
                    `
                    var titleMessage = `结算提示：`
                    if (tableDiv.datagrid('getData').footer[1].price > view.currentRow.Card.balance) {
                        titleMessage += `<span style="color:LightCoral">卡内余额不足请充值</span>`;
                    };

                    //发送
                    $.messager.alert(titleMessage, payMessage, 'info', function () {
                        var sendObject = {
                            currentRow: JSON.stringify(view.currentRow),
                            records: JSON.stringify(tableDiv.datagrid('getData'))
                        };
                        $.post('mix/settlement', sendObject)
                            .done(function (data) {
                                dialogDiv.dialog('close');
                                //dialogDiv.dialog('destroy');
                                $.messager.alert('提示', data.message, 'info', function () {
                                    view.getTableDiv().datagrid('reload');
                                });
                            }).fail(function (err) {
                                //console.log(err);
                                $.messager.alert('失败', err.responseText, 'warning', function () { });
                            });

                    });
                };
                dialogDiv.keydown(function (e) {
                    if (e.key === 'Enter') {
                        payHandler();
                    }
                })

                //对话框设置
                var dialogOp = {
                    title: dialogTitle,
                    width: 800,
                    top: 120,
                    height: 500,
                    closable: false,
                    closed: false,
                    cache: false,
                    //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                    //href: 'get_content.php',
                    modal: true,
                    onBeforeOpen: function () {
                        payView.build(payViewOp);
                    },
                    onOpen: function () {
                        // payView.getTableDiv().datagrid('appendRow', payView.makeNewRow());
                        payView.getTableDiv().datagrid('loadData', {
                            footer: [
                                { Commodity: { name: '现金应收：' }, price: 0 },
                                { Commodity: { name: '卡内应收：' }, price: 0 },
                                { Commodity: { name: '合计应收：' }, price: 0 }
                            ],
                            rows: [payView.makeNewRow()],
                            total: 1
                        });
                    },
                    buttons: [{
                        text: '保存',
                        handler: payHandler,
                    }, {
                        text: '关闭',
                        handler: function () {
                            //dialogDiv.dialog('destroy');
                            $.post('card/clearCurrentCard').done(function (data) {
                                if (data.cleared) {
                                    view.currentRow.passed = false;

                                    dialogDiv.dialog('close');
                                } else {
                                    $.messager.alert('提示', '系统内部错误', 'info', function () {
                                        $.get('logout');
                                    });
                                }
                            })

                        }
                    }]
                };
                dialogDiv.dialog(dialogOp);
            }
            var recharge = function () {
                // view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                // if (!view.currentRow.id) {
                //     $.messager.alert('提示', '请先保存再设置密码', 'info');
                //     return;
                // }
                var dialogTitle = `为会员：  ${view.currentRow.name}  充值`;
                if (view.dialogPage.rechargeDiv) {
                    view.dialogPage.rechargeDiv.dialog('setTitle', dialogTitle);
                    view.dialogPage.rechargeDiv.dialog('open', true);
                    return;
                }
                var dialogDiv = $('<div></div>');
                var numberboxDiv = $('<div></div>');
                numberboxDiv.appendTo(dialogDiv);
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.rechargeDiv = dialogDiv;

                var dialogOp = {
                    title: dialogTitle,
                    width: 400,
                    top: 120,
                    //height: 120,
                    closed: false,
                    cache: false,
                    //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                    //href: 'get_content.php',
                    modal: true,
                    onBeforeOpen: function () {
                        numberboxDiv.numberbox({
                            width: '100%',
                            height: 45,
                            prompt: `请输入充值金额（${dialogTitle}）`,
                            iconWidth: 28,
                            min: 0,
                            max: 100000,
                            precision: 2,
                        });
                    },
                    onOpen: function () {
                        numberboxDiv.textbox('clear');
                        //设置焦点                            
                        numberboxDiv.textbox('textbox').focus();
                    },
                    buttons: [{
                        text: '保存',
                        handler: function () {
                            // var value = passwordboxDiv.textbox('getValue');
                            // $.post('user/resetPass', {
                            //     id: view.currentRow.id,
                            //     pass: value
                            // }).done(function (data) {
                            //     dialogDiv.dialog('close');
                            //     //dialogDiv.dialog('destroy');
                            //     $.messager.alert('提示', data.message, 'info', function () {
                            //     });
                            // }).fail(function (err) {
                            //     //console.log(err);
                            //     $.messager.alert('失败', err.responseText, 'warning', function () {
                            //         //重置焦点
                            //         passwordboxDiv.textbox('textbox').focus();
                            //     });
                            // });
                            dialogDiv.dialog('close');
                        },
                    }, {
                        text: '关闭',
                        handler: function () {
                            //dialogDiv.dialog('destroy');
                            dialogDiv.dialog('close');
                        }
                    }]
                };
                dialogDiv.dialog(dialogOp);
            }
            var printCase = function () {
                //console.log('print');
            }
            op.tableOption = {
                // url: '',
                multiSort: true,
                remoteSort: true,

                singleSelect: true,
                //自添加属性，用于关闭cell编辑功能，目的是避免搜索框失效。
                listOnly: true,
                onClickCell: function (index, field, value) {
                    if (!field.includes('action_')) { return; }
                    view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                    switch (field) {
                        case 'action_pay':
                            view.currentRow.actionFunc = pay;
                            break;
                        case 'action_recharge':
                            view.currentRow.actionFunc = recharge;
                            break;
                        case 'action_print':
                            view.currentRow.actionFunc = printCase;
                            break;
                    }
                    empower();
                },



            };

            var combogridOnLoadSuccess = combogridEvents(view).onLoadSuccess;
            var combogridOnShowPanel = combogridEvents(view).onShowPanel;
            op.tableOption.columns = [[
                // {
                //     field: 'ck',
                //     checkbox: true
                // },
                {
                    field: 'id',
                    title: '会员ID',
                    hidden: true,
                }, {
                    field: 'action_pay',
                    title: '结账',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        return '<button>结账</button>';
                    },
                }, {
                    field: 'action_recharge',
                    title: '充值',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        return '<button>充值</button>';
                    },
                }, {
                    field: 'action_print',
                    title: '打印',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        return '<button>打印</button>';
                    },
                }, {
                    field: 'name',
                    title: '会员名',
                    sortable: true,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    //field: 'UserType.name',user_type_id
                    field: 'card_id',
                    title: '会员卡号',
                    width: 80,
                    sortable: true,
                    formatter: function (value, row, index) {
                        return row.Card ? row.Card.card_number : '';
                    },
                    editor: {
                        type: 'combogrid',
                        options: {
                            queryParams: { findBy: ['card_number', 'name'] },
                            mode: 'remote',
                            url: '/card/findAll',
                            panelWidth: 300,
                            //panelMaxHeight: 265,
                            //panelHeight: 200,
                            idField: 'id',
                            textField: 'card_number',
                            columns: [[
                                // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },
                                { field: 'card_number', title: '会员卡号', width: 100 },
                                { field: 'name', title: '会员卡主名', width: 165 },
                            ]],
                            //reversed: true,
                            sortName: 'card_number',
                            //避免出现滑条，造成选择的时候无法选中
                            pagination: true,
                            pageSize: 6,
                            pageList: [6],
                            //pagePosition: 'top',

                            rownumbers: true,
                            onLoadSuccess: combogridOnLoadSuccess,
                            onShowPanel: combogridOnShowPanel,
                        }
                    }
                }, {
                    field: 'Card.name',
                    title: '会员卡主名',
                    width: 100,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['UserType']['name'];        
                        return row.Card ? row.Card.name : '';
                    },
                }, {
                    field: 'phone',
                    title: '电话',
                    width: 80,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'otherphone',
                    title: '其他电话',
                    width: 80,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'remark',
                    title: '备注',
                    width: 100,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'updated_at',
                    title: '最后更新时间',
                    //width: 100,
                    sortable: true,
                    formatter: function (value, row, index) {
                        // console.log(row);
                        if (!Number.isNaN(Date.parse(value))) {
                            return new Date(Date.parse(value)).toLocaleString();
                        } else {
                            return '';
                        }
                    },
                }

            ]];

            view.build(op);
        };

        init();

    }();
</script>