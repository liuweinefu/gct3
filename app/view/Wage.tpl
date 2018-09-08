<div id='wage' style="height: 100%;"></div>
<script>
    //@ sourceURL=wage.js
    void function () {
        var anchorDiv = $('#wage');
        var view = new lwTable(anchorDiv);

        // var wageType = null;
        // $.post('/wageType/findAll', {
        //     sort: 'sn',
        //     order: 'asc',
        //     originalModel: true,
        // })
        //     .done(function (data) {
        //         wageType = data.rows;
        //         init();
        //     })
        //     .fail(function () {

        //     });


        var init = function () {
            var op = {};
            //searchBox设置**************************************************
            op.searchBoxOption = {};
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
                { name: 'Employee.name', text: '雇员名' },
                { name: 'User.name', text: '记录员名' },
            ];

            //buttons设置**************************************************
            op.buttonOption = {
                // importExcel: true,
                // exportExcel: true,
                sort: true,
                search: true,
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
            // view.makeNewRow = (newRowIndex) => {
            //     return {
            //         name: '新登录用户 ' + Math.round(Math.random() * 1000),
            //         remark: '备注' + Math.round(Math.random() * 1000),
            //         sn: newRowIndex ? newRowIndex : 0,
            //     };
            // };
            view.currentRow = null;
            op.tableOption = {
                // onEndEdit: function (index, row, changes) {
                //     if (!Object.keys(changes).includes('wage_type_id')) { return; }
                //     var ed = $(this).datagrid('getEditor', {
                //         index: index,
                //         field: 'wage_type_id'
                //     });
                //     if (!row.UserType) { row.UserType = {}; }
                //     row.UserType.name = $(ed.target).combobox('getText');

                //     //row.UserType.name = $(ed.target).combobox('getText');
                //     // if ($(ed.target).combobox('getText').length!=0) { 
                //     //     row['UserType.name'] = $(ed.target).combobox('getText');
                //     // }
                // },

                onClickCell: function (index, field, value) {
                    $(this).datagrid('cancelEdit', index);
                    return;


                    if (field === 'updated_at') {
                        $(this).datagrid('cancelEdit', index);
                        return;
                    }

                    if (field !== 'action_pass') { return; }

                    view.currentRow = view.getTableDiv().datagrid('getRows')[index];
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
                                $.post('wage/resetPass', {
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

                },

                multiSort: true,
                remoteSort: true,

            };

            op.tableOption.columns = [[
                // {
                //     field: 'ck',
                //     checkbox: true
                // },
                {
                    field: 'id',
                    title: '工资ID',
                    hidden: true,
                }, {
                    field: 'action_list',
                    title: '结算记录',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        return '<button>结算记录</button>';
                    },
                }, {
                    field: 'action_delete',
                    title: '撤销结算',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        return '<button>撤销结算</button>';
                    },
                }, {
                    //field: 'UserType.name',wage_type_id
                    field: 'employee_id',
                    title: '雇员名',
                    width: 80,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['UserType']['name'];
                        return row.Employee ? row.Employee.name : '';
                    },
                    editor: {
                        type: 'combogrid',
                        options: {
                            queryParams: { findBy: ['phone', 'name'] },
                            mode: 'remote',
                            url: '/employee/findAll',
                            panelWidth: 300,
                            panelMaxHeight: 265,
                            //panelHeight: 200,
                            idField: 'id',
                            textField: 'name',
                            columns: [[
                                // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },
                                { field: 'name', title: '雇员名', width: 100 },
                                { field: 'phone', title: '雇员电话', width: 165 },
                            ]],
                            //reversed: true,
                            sortName: 'name',
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
                                        name: 'name',
                                        value: value,
                                        isEq: true
                                    })
                                }
                                //$(this).combogrid('textbox').select();
                            },

                        }
                    }
                }, {
                    //field: 'UserType.name',wage_type_id
                    field: 'user_id',
                    title: '记录员名',
                    width: 80,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['UserType']['name'];
                        return row.User ? row.User.name : '';
                    },
                    editor: {
                        type: 'combogrid',
                        options: {
                            queryParams: { findBy: ['phone', 'name'] },
                            mode: 'remote',
                            url: '/user/findAll',
                            panelWidth: 300,
                            panelMaxHeight: 265,
                            //panelHeight: 200,
                            idField: 'id',
                            textField: 'name',
                            columns: [[
                                // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },
                                { field: 'name', title: '记录员名', width: 100 },
                                { field: 'phone', title: '记录员电话', width: 165 },
                            ]],
                            //reversed: true,
                            sortName: 'name',
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
                                        name: 'name',
                                        value: value,
                                        isEq: true
                                    })
                                }
                                //$(this).combogrid('textbox').select();
                            },

                        }
                    }
                }, {
                    field: 'wage',
                    title: '基础工资',
                    width: 60,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'bonus',
                    title: '奖金',
                    sortable: true,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'created_at',
                    title: '创建时间',
                    //width: 100,
                    sortable: true,
                    formatter: function (value, row, index) {
                        if (!Number.isNaN(Date.parse(value))) {
                            return new Date(Date.parse(value)).toLocaleString();
                        } else {
                            return '';
                        }
                    },
                    editor: {
                        type: 'datetimebox',
                        options: {}
                    },
                }, {
                    field: 'updated_at',
                    title: '最后更新时间',
                    //width: 100,
                    sortable: true,
                    formatter: function (value, row, index) {
                        if (!Number.isNaN(Date.parse(value))) {
                            return new Date(Date.parse(value)).toLocaleString();
                        } else {
                            return '';
                        }
                    },
                    editor: {
                        type: 'datetimebox',
                        options: {}
                    },
                }

            ]];

            view.build(op);
        };


        init();
    }();
</script>