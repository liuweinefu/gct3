<div id='card' style="height: 100%;">
</div>
<script>
    //# sourceURL=card.js
    void function () {
        var anchorDiv = $('#card');
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
                    if (name.endsWith('card_number')) {
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
                { name: 'card_number', text: '会员卡号' },
                { name: 'name', text: '主会员名' },
                { name: 'phone', text: '卡电话' },
                { name: 'otherphone', text: '卡其他电话' },
                { name: 'remark', text: '备注' },
                { name: 'CardType.name', text: '会员卡类型' },
            ];

            //buttons设置**************************************************
            op.buttonOption = {
                //importExcel: true,
                exportExcel: true,
                sort: true,
                search: true,
                replace: true,
                headAdd: true,
                //insert: true,
                save: true,
                delete: true,
                // del: {
                //     text: '删除条件(<ins>D</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                //     iconCls: 'icon-search',
                //     onClick: function () {
                //         console.log(view);
                //     }
                // },
                redo: true,
            };

            //表格设置**************************************************
            view.makeNewRow = (newRowIndex) => {
                return {
                    card_number: newRowIndex ? newRowIndex : 9999,
                    name: '新会员卡 ' + Math.round(Math.random() * 1000),
                    balance: 0,
                    phone: '00000000000',
                    otherphone: '0000',
                    remark: '',
                };
            };

            view.currentRow = null;
            var changePass = function () {
                if (!view.currentRow.id) {
                    $.messager.alert('提示', '请先保存再设置密码', 'info');
                    return;
                }
                if (view.dialogPage.passDiv) {
                    view.dialogPage.passDiv.dialog('setTitle', `修改   ${view.currentRow.name}   的密码`);
                    view.dialogPage.passDiv.dialog('open', true);
                    return;
                }
                var dialogDiv = $('<div></div>');
                var passwordboxDiv = $('<div></div>');
                passwordboxDiv.appendTo(dialogDiv);
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.passDiv = dialogDiv;

                var dialogOp = {
                    title: `修改   ${view.currentRow.name}   的密码`,
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
                            var value = passwordboxDiv.textbox('getValue');
                            $.post('card/resetPass', {
                                id: view.currentRow.id,
                                pass: value
                            }).done(function (data) {
                                dialogDiv.dialog('close');
                                //dialogDiv.dialog('destroy');
                                $.messager.alert('提示', data.message, 'info', function () {
                                });
                            }).fail(function (err) {
                                //console.log(err);
                                $.messager.alert('失败', err.responseText, 'warning', function () {
                                    //重置焦点
                                    passwordboxDiv.textbox('textbox').focus();
                                });
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
            };
            op.tableOption = {
                onEndEdit: function (index, row, changes) {
                    if (!Object.keys(changes).includes('card_type_id')) { return; }
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'card_type_id'
                    });
                    if (!row.CardType) { row.CardType = {}; }
                    row.CardType.name = $(ed.target).combobox('getText');

                    //row.UserType.name = $(ed.target).combobox('getText');
                    // if ($(ed.target).combobox('getText').length!=0) { 
                    //     row['UserType.name'] = $(ed.target).combobox('getText');
                    // }
                },
                onClickCell: function (index, field, value) {
                    if (field === 'updated_at') {
                        $(this).datagrid('cancelEdit', index);
                    }
                    if (field !== 'action_pass') { return; }
                    view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                    changePass();

                },

                showFooter: true,
                multiSort: true,
                remoteSort: true,

            };

            op.tableOption.columns = [[
                {
                    field: 'ck',
                    checkbox: true
                },
                {
                    field: 'id',
                    title: '会员卡ID',
                    hidden: true,
                }, {
                    field: 'card_number',
                    title: '会员卡号',
                    sortable: true,
                    width: 20,
                    editor: {
                        type: 'numberbox',
                        options: {
                            min: 1,
                        }
                    }
                }, {
                    field: 'name',
                    title: '会员卡名',
                    sortable: true,
                    width: 30,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'balance',
                    title: '余额',
                    sortable: true,
                    width: 40,
                    editor: {
                        type: 'numberbox',
                        options: {
                            prefix: '￥',
                            max: 100000000,
                            precision: 2
                        }
                    },
                    formatter: function (value, row, index) {
                        return Number.isNaN(Number.parseFloat(value)) ? '￥0.00' : '￥' + Number.parseFloat(value).toFixed(2);
                    }
                }, {
                    //field: 'UserType.name',user_type_id
                    field: 'card_type_id',
                    title: '会员类型',
                    width: 50,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['UserType']['name'];
                        //return row.UserType ? row.UserType.name : '';
                        return row.CardType ? row.CardType.name : '';
                    },
                    editor: {
                        type: 'combobox',
                        options: {
                            queryParams: { sort: 'sn', order: 'asc' },
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
                            // onLoadSuccess: function () {
                            //     var panelHeight = $(this).combobox('getData').length * 30 + 15;
                            //     $(this).combobox('panel').panel('resize', {
                            //         height: panelHeight
                            //     });
                            // },
                            onShowPanel: function () {
                                // var panelHeight = $(this).combobox('getData').length * 30 + 15;
                                // $(this).combobox('panel').panel('resize', {
                                //     height: panelHeight
                                // });
                                //替换后无法选中
                                // $(this).combobox('textbox').select();
                            }

                        }
                    }
                }, {
                    field: 'phone',
                    title: '卡电话',
                    width: 35,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'action_pass',
                    title: '密码',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        return '<button>修改密码</button>';

                    },
                }, {
                    field: 'remark',
                    title: '备注',
                    width: 50,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'otherphone',
                    title: '卡其他电话',
                    width: 35,
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
                    editor: {
                        type: 'datetimebox',
                        options: {}
                    },
                    formatter: function (value, row, index) {
                        if (!Number.isNaN(Date.parse(value))) {
                            return new Date(Date.parse(value)).toLocaleString();
                        } else {
                            return '';
                        }
                    },
                },

            ]];

            view.build(op);
        };

        init();

    }();
</script>
