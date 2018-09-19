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
                    view.getTableDiv().datagrid({
                        url: '/mix/findAll'
                    });
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
                addNewCard: {
                    text: '新卡开户(<ins>N</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                    iconCls: 'icon-search',
                    onClick: function () {
                        console.log(view);
                    }
                },
                addNewMember: {
                    text: '旧卡增户(<ins>O</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                    iconCls: 'icon-search',
                    onClick: function () {
                        console.log(view);
                    }
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
            var getPass = function () {
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
                        handler: function () {

                            view.currentRow.actionFunc();

                            // dialogDiv.dialog('close');

                            // var value = passwordboxDiv.textbox('getValue');
                            // $.post('mix/checkPass', {
                            //     id: view.currentRow.id,
                            //     pass: value
                            // }).done(function (data) {

                            // view.currentRow.actionFunc();

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
            };
            var pay = function () {
                var memberName = view.currentRow.name;
                var balance = view.currentRow.Card.balance;
                var discount = view.currentRow.Card.CardType.discount;


                if (view.dialogPage.payDiv) {
                    view.dialogPage.payDiv.dialog('setTitle', `客户:${memberName}   余额:￥${balance}  折扣:${discount}`);
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
                        return {};
                    } else {
                        return Object.assign({}, rows[rows.length - 1]);
                    }
                };


                var payViewOp = {};
                payViewOp.buttonOption = {
                    footAdd: {
                        text: '添加商品(<ins>A</ins>)',
                    },
                    delete: {
                        text: '删除商品(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
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
                    onEndEdit: function (index, row, changes) {
                        var key = Object.keys(changes)[0];
                        if (key == 'quantity' || key == 'whetherDiscount') {
                            row.price = row.whetherDiscount === '1' ? row.unitPrice * row.quantity * view.currentRow.Card.CardType.discount : row.unitPrice * row.quantity;
                        };
                        if (key === undefined || !key.includes('_id')) {
                            return;
                        };
                        var ed = $(this).datagrid('getEditor', {
                            index: index,
                            field: key
                        });
                        var selectedRow = $(ed.target).combogrid('grid').datagrid('getSelected');
                        if (key === 'employee_id') {
                            if (!row.Employee) { row.Employee = {}; }
                            if (!selectedRow) {
                                row.employee_id = null;
                                row.Employee.name = '<red>请选择技师</red>';
                            } else {
                                row.Employee.name = selectedRow.name;
                            }
                        } else if (key === 'commodity_id') {
                            if (!row.Commodity) { row.Commodity = {}; }
                            if (!selectedRow) {
                                row.commodity_id = null;
                                row.Commodity.name = '<red>请选择商品</red>';
                                row.unitPrice = 0;
                                row.price = 0;
                            } else {
                                row.unitPrice = selectedRow.price;
                                row.Commodity.name = selectedRow.name;
                                row.price = row.whetherDiscount === '1' ? row.unitPrice * row.quantity * view.currentRow.Card.CardType.discount : row.unitPrice * row.quantity;
                            }
                        }
                    },
                };
                payViewOp.tableOption.columns = [[
                    {
                        field: 'ck',
                        checkbox: true
                    },
                    //  {
                    //     field: 'id',
                    //     hidden: true,
                    // },
                    {
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
                                onLoadSuccess: function (data) {
                                    // $(this).datagrid('selectRow', 0);

                                    //$(this).focus();
                                    // $(this).datagrid('getPager').select();
                                    // $(this).datagrid('getPanel').focus();
                                },
                                onShowPanel: function () {
                                    // var value = '';
                                    // var cell = payView.getTableDiv().datagrid('cell');
                                    // if (cell) {
                                    //     value = payView.getTableDiv().datagrid('getRows')[cell.index][cell.field];
                                    // }
                                    // if (value) {
                                    //     $(this).combogrid('grid').datagrid('load', {
                                    //         name: 'id',
                                    //         value: value,
                                    //         isEq: true
                                    //     })
                                    // } else {
                                    //     $(this).combogrid('grid').datagrid('load')
                                    // }
                                    //$(this).combogrid('textbox').select();
                                },

                            }
                        }
                    }, {
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
                                onLoadSuccess: function (data) {
                                    $(this).datagrid('selectRow', 0);

                                    //$(this).focus();
                                    // $(this).datagrid('getPager').select();
                                    // $(this).datagrid('getPanel').focus();
                                },
                                onShowPanel: function () {
                                    var value = '';
                                    var cell = view.getTableDiv().datagrid('cell');
                                    if (cell) {
                                        value = view.getTableDiv().datagrid('getRows')[cell.index][cell.field];
                                    }
                                    if (value) {
                                        $(this).combogrid('grid').datagrid('load', {
                                            name: 'id',
                                            value: value,
                                            isEq: true
                                        })
                                    }
                                    //$(this).combogrid('textbox').select();
                                },

                            }
                        }

                    }, {
                        field: 'unitPrice',
                        title: '单价',
                        width: 80,
                        formatter: function (value, row, index) {
                            return Number.isNaN(Number.parseFloat(value)) ? '￥0.00' : '￥' + Number.parseFloat(value).toFixed(2);
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
                            if (Number.parseInt(value) === 1) {
                                return '是'
                            } else {
                                return '否';
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
                            if (Number.parseInt(value) === 1) {
                                return '是'
                            } else {
                                return '否';
                            }
                        },
                    }, {
                        field: 'price',
                        title: '实收价格',
                        width: 100,
                        formatter: function (value, row, index) {
                            return Number.isNaN(Number.parseFloat(value)) ? '￥0.00' : '￥' + Number.parseFloat(value).toFixed(2);
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
                    },
                ]];
                // payView.build(payViewOp);
                //对话框设置
                var dialogOp = {
                    title: `客户:${memberName}    余额:￥${balance}    折扣:${discount}`,
                    width: 800,
                    top: 120,
                    height: 400,
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
                            rows: [{
                                // employee_id: 1,
                                // commodity_id: 1,
                                // unitPrice: 100,
                                quantity: 1,
                                whetherDiscount: '1',
                                // is_cash: 1,
                                // price: 1,
                            }],
                            total: 1
                        });
                    },
                    buttons: [{
                        text: '保存',
                        handler: function () {

                            dialogDiv.dialog('close');

                            // var sendObject = {
                            //     currentRow: JSON.stringify(view.currentRow),
                            //     menus: JSON.stringify(payView.getTableDiv().datagrid('getChecked'))
                            // };
                            // $.post('userType/setMenus', sendObject)
                            //     .done(function (data) {
                            //         dialogDiv.dialog('close');
                            //         //dialogDiv.dialog('destroy');
                            //         $.messager.alert('提示', data.message, 'info', function () {
                            //             view.getTableDiv().datagrid('reload');
                            //         });
                            //     }).fail(function (err) {
                            //         //console.log(err);
                            //         $.messager.alert('失败', err.responseText, 'warning', function () { });
                            //     });
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
            var recharge = function () {
                //console.log('recharge');
            }
            var printCase = function () {
                //console.log('print');
            }
            op.tableOption = {
                //url: '',
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
                    getPass();
                },



            };

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
                            onLoadSuccess: function (data) {
                                $(this).datagrid('selectRow', 0);

                                //$(this).focus();
                                // $(this).datagrid('getPager').select();
                                // $(this).datagrid('getPanel').focus();
                            },
                            onShowPanel: function () {
                                var value = '';
                                var cell = view.getTableDiv().datagrid('cell');
                                if (cell) {
                                    value = view.getTableDiv().datagrid('getRows')[cell.index][cell.field];
                                }
                                if (value) {
                                    $(this).combogrid('grid').datagrid('load', {
                                        name: 'id',
                                        value: value,
                                        isEq: true
                                    })
                                }
                                //$(this).combogrid('textbox').select();
                            },

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
                        console.log(row);
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