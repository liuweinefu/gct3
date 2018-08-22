<div id='userType' style="height: 100%;"></div>
<script>
    //@ sourceURL=userType.js
    void function () {
        var anchorDiv = $('#userType');
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
                { name: 'name', text: '用户类型' },
                { name: 'sn', text: '序号' },
                { name: 'remark', text: '备注' },
            ];

            //buttons设置**************************************************
            op.buttonOption = {
                // importExcel: true,
                // exportExcel: true,
                sort: true,
                search: true,
                replace: true,
                headAdd: true,
                insert: true,
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
                    name: '新用户类型 ' + Math.round(Math.random() * 1000),
                    remark: '备注' + Math.round(Math.random() * 1000),
                    sn: newRowIndex ? newRowIndex : 0,
                };
            };
            view.currentRow = null;
            op.tableOption = {
                // onEndEdit: function (index, row, changes) {
                //     if (!Object.keys(changes).includes('user_type_id')) { return; }
                //     var ed = $(this).datagrid('getEditor', {
                //         index: index,
                //         field: 'user_type_id'
                //     });
                //     if (!row.UserType) { row.UserType = {}; }
                //     row.UserType.name = $(ed.target).combobox('getText');

                //     //row.UserType.name = $(ed.target).combobox('getText');
                //     // if ($(ed.target).combobox('getText').length!=0) { 
                //     //     row['UserType.name'] = $(ed.target).combobox('getText');
                //     // }
                // },

                onClickCell: function (index, field, value) {
                    if (field === 'updated_at') {
                        $(this).datagrid('cancelEdit', index);
                        return;
                    }


                    if (field !== 'action_menu') { return; }

                    view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                    if (!view.currentRow.id) {
                        $.messager.alert('提示', '请先保存再授权', 'info');
                        return;
                    }
                    if (view.dialogPage.menuDiv) {
                        view.dialogPage.menuDiv.dialog('setTitle', `为   ${view.currentRow.name}   进行菜单授权`);
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

                },
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
                    title: '类型ID',
                    hidden: true,
                }, {
                    field: 'sn',
                    title: '排序号',
                    width: 20,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'name',
                    title: '类型名称',
                    sortable: true,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
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
                }, {
                    field: 'action_menu',
                    title: '菜单',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        return '<button>菜单授权</button>';

                    },
                },
            ]];

            view.build(op);
        };

        init();

    }();
</script>