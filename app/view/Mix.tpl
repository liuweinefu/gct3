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
                    view.getTableDiv().datagrid('load', {
                        name: name,
                        value: value
                    });
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

                console.log('pay');
                if (view.dialogPage.payDiv) {
                    view.dialogPage.payDiv.dialog('setTitle', `客户: ${view.currentRow.name}   余额：￥${view.currentRow.Card.balance}`);
                    view.dialogPage.menuDiv.dialog('open', true);
                    return;
                }
                var dialogDiv = $('<div></div>');
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.menuDiv = dialogDiv;

                //初始化内部菜单内容
                var menuView = new lwTable(dialogDiv);

                var menuViewOp = {};
                menuViewOp.buttonOption = {};

                menuViewOp.tableOption = {
                    // idField: 'id',
                    // loadMsg: '数据加载中,请稍后',
                    // fit: true,
                    // fitColumns: true,
                    // singleSelect: true,
                    url: '/menu/findAll',
                    // method: 'post',
                    // toolbar: '',
                    // striped: true,
                    pagination: false,
                    // rownumbers: true,
                    // pageNumber: 1,
                    // pageSize: '50',
                    // pageList: [50, 200, 500, 5000],
                    // sortName: 'sn',
                    // sortOrder: 'asc',
                    // onLoadSuccess: menuViewTableOnLoadSuccess,
                    onLoadSuccess: function (data) {
                        $(this).datagrid('uncheckAll');
                        var checkedRowArray = view.currentRow.Menus.map(menu => menu.id);
                        var checkedIndexArray = checkedRowArray.map(row => $(this).datagrid('getRowIndex', row));
                        checkedIndexArray.forEach(index => $(this).datagrid('checkRow', index));
                    },
                    onSelectCell: function (index, field) {
                        var checkIndexArray = $(this).datagrid('getChecked').map(row => $(this).datagrid('getRowIndex', row));
                        if (checkIndexArray.includes(index)) {
                            $(this).datagrid('uncheckRow', index);
                        } else {
                            $(this).datagrid('checkRow', index);
                        }
                    },
                    remoteSort: false,
                    multiSort: false,
                };
                menuViewOp.tableOption.columns = [[
                    {
                        field: 'ck',
                        checkbox: true
                    },
                    {
                        field: 'id',
                        title: '菜单ID',
                        hidden: true,
                    }, {
                        field: 'sn',
                        title: '排序号',
                        width: 30,
                    }, {
                        field: 'name',
                        title: '菜单名',
                        width: 60,
                    }, {
                        field: 'router',
                        title: 'url指向',
                        width: 100,
                    }
                ]];
                // menuView.build(menuViewOp);
                //对话框设置
                var dialogOp = {
                    title: `为   ${view.currentRow.name}   进行菜单授权`,
                    width: 600,
                    top: 120,
                    height: 400,
                    closed: false,
                    cache: false,
                    //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                    //href: 'get_content.php',
                    modal: true,
                    onBeforeOpen: function () {
                        menuView.build(menuViewOp);
                    },
                    onOpen: function () {
                        menuView.getTableDiv().datagrid('load');
                    },
                    buttons: [{
                        text: '保存',
                        handler: function () {
                            var sendObject = {
                                currentRow: JSON.stringify(view.currentRow),
                                menus: JSON.stringify(menuView.getTableDiv().datagrid('getChecked'))
                            };
                            $.post('userType/setMenus', sendObject)
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
                console.log('recharge');
            }
            var printCase = function () {
                console.log('print');
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