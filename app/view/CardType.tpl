<div id='cardType' style="height: 100%;"></div>
<script>
    //@ sourceURL=cardType.js
    void function () {
        var anchorDiv = $('#cardType');
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
                { name: 'name', text: '会员卡类型' },
                { name: 'remark', text: '备注' },
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
                    name: '会员卡类型 ' + Math.round(Math.random() * 1000),
                    discount: 1,
                    sn: newRowIndex ? newRowIndex : 9999,
                    remark: '备注' + Math.round(Math.random() * 1000),
                };
            };

            var currentRow = null;
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
                    }
                },

                // onClickCell: function (index, field, value) {
                //     if (field != 'action_pass') { return; }
                //     //高阶currentRow 否则dialog的buttons值绑定当前;
                //     currentRow = view.getTableDiv().datagrid('getRows')[index];
                //     if (!currentRow.id) {
                //         $.messager.alert('提示', '请先保存再授权', 'info');
                //         return;
                //     }
                //     if (view.dialogPage.passDiv) {
                //         view.dialogPage.passDiv.dialog('setTitle', `修改   ${currentRow.name}   的密码`);
                //         view.dialogPage.passDiv.dialog('open', true);
                //         return;
                //     }
                //     var dialogDiv = $('<div></div>');
                //     var passwordboxDiv = $('<div></div>');
                //     passwordboxDiv.appendTo(dialogDiv);
                //     dialogDiv.appendTo(view.getDialogContainerDiv());
                //     view.dialogPage.passDiv = dialogDiv;

                //     var dialogOp = {
                //         title: `修改   ${currentRow.name}   的密码`,
                //         width: 400,
                //         top: 120,
                //         //height: 120,
                //         closed: false,
                //         cache: false,
                //         //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                //         //href: 'get_content.php',
                //         modal: true,
                //         onBeforeOpen: function () {
                //             passwordboxDiv.passwordbox({
                //                 width: '100%',
                //                 height: 34,
                //                 prompt: '请输入密码',
                //                 iconWidth: 28,
                //                 showEye: true
                //             });
                //         },
                //         onOpen: function () {
                //             passwordboxDiv.textbox('clear');
                //             //设置焦点                            
                //             passwordboxDiv.textbox('textbox').focus();
                //         },
                //         buttons: [{
                //             text: '保存',
                //             handler: function () {
                //                 var value = passwordboxDiv.textbox('getValue');
                //                 $.post('user/resetPass', {
                //                     id: currentRow.id,
                //                     pass: value
                //                 })
                //                     .done(function (data) {
                //                         dialogDiv.dialog('close');
                //                         //dialogDiv.dialog('destroy');
                //                         $.messager.alert('提示', data.message, 'info', function () {
                //                         });
                //                     })
                //                     .fail(function (err) {
                //                         //console.log(err);
                //                         $.messager.alert('失败', err.responseText, 'warning', function () {
                //                             //重置焦点
                //                             passwordboxDiv.textbox('textbox').focus();
                //                         });
                //                     });
                //             },
                //         }, {
                //             text: '关闭',
                //             handler: function () {
                //                 //dialogDiv.dialog('destroy');
                //                 dialogDiv.dialog('close');
                //             }
                //         }]
                //     };
                //     dialogDiv.dialog(dialogOp);

                // },

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
                    title: '会员卡类型ID',
                    hidden: true,
                }, {
                    field: 'name',
                    title: '会员卡类型',
                    sortable: true,
                    width: 30,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'discount',
                    title: '余额',
                    sortable: true,
                    width: 40,
                    editor: {
                        type: 'numberbox',
                        options: {
                            //suffix: '折',
                            min: 0.1,
                            max: 1,
                            precision: 2
                        }
                    },
                    formatter: function (value, row, index) {
                        return Number.parseInt(value * 100) + '折';
                    }
                }, {
                    field: 'sn',
                    title: '序号',
                    width: 30,
                    sortable: true,
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
                }
            ]];

            view.build(op);
        };

        init();

    }();
</script>