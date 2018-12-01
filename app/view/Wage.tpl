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
            //         remark: '',
            //         sn: newRowIndex ? newRowIndex : 0,
            //     };
            // };
            view.currentRow = null;
            var listWage = function () {
                if (view.dialogPage.listWageDiv) {
                    // console.log(view.currentRow);
                    view.dialogPage.listWageDiv.dialog('setTitle', `${view.currentRow.Employee.name}于${new Date(Date.parse(view.currentRow.updated_at)).toLocaleString()} 结算工资的消费记录`);
                    view.dialogPage.listWageDiv.dialog('open', true);
                    return;
                }

                var dialogDiv = $('<div></div>');
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.listWageDiv = dialogDiv;

                var listWageView = new lwTable(dialogDiv);

                var listWageViewOp = {};
                listWageViewOp.tableOption = {
                    // idField: 'id',
                    // loadMsg: '数据加载中,请稍后',
                    // fit: true,
                    // fitColumns: true,
                    // singleSelect: true,
                    url: '/consumption/findAll',
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
                    // showFooter: true,

                    singleSelect: true,
                    //自添加属性，用于关闭cell编辑功能，目的是避免搜索框失效。
                    listOnly: true,
                    groupField: 'commodity_id',
                    view: groupview,
                    groupFormatter: function (value, rows) {
                        if (!Array.isArray(rows) && rows.length === 0) {
                            return;
                        };


                        var message = '';

                        var commodityName = rows[0].Commodity.name;
                        message += `（商品：${commodityName}）`.padEnd(20, '_');

                        var count = rows.reduce((prev, curr) => {
                            return prev - (-curr.quantity);
                        }, 0);
                        message += `（${count}次）`.padEnd(10, '_');

                        var allprice = rows.reduce((prev, curr) => {
                            return prev - (-curr.price);
                        }, 0);
                        message += `（总价${allprice.toFixed(2)}）`.padEnd(20, '_')


                        var cash = rows.reduce((prev, curr) => {
                            if (curr.is_cash) {
                                return prev - (-curr.price);
                            } else {
                                return prev;
                            }
                        }, 0);

                        message += `[现金:￥${cash.toFixed(2)}]`.padEnd(20, '_');
                        var noCash = rows.reduce((prev, curr) => {
                            if (curr.is_cash) {
                                return prev;
                            } else {
                                return prev - (-curr.price);
                            }
                        }, 0);
                        message += `[卡刷:￥${noCash.toFixed(2)}]`;
                        // return `商品：${commodityName}_________${count.toString().padEnd(3, '0')}次------总价：${price}`;
                        // return `（商品：${commodityName})------(${count}次)------(总价：￥${allprice.toFixed(2)})---[现金:￥${cash.toFixed(2)}]---[卡刷:￥${noCash.toFixed(2)}]`;
                        return message;
                    },
                    // onLoadSuccess: function () {

                    //     listWageView.getTableDiv().datagrid('collapseGroup');
                    //     listWageView.collapseGroup = true;

                    // },

                };

                var combogridOnLoadSuccess = combogridEvents(view).onLoadSuccess;
                var combogridOnShowPanel = combogridEvents(view).onShowPanel;
                listWageViewOp.tableOption.columns = [[
                    // {
                    //     field: 'ck',
                    //     checkbox: true
                    // },
                    {
                        field: 'id',
                        title: '消费记录ID',
                        hidden: true,
                    }, {
                        field: 'price',
                        title: '消费金额',
                        width: 100,
                        sortable: true,
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
                        field: 'quantity',
                        title: '数量',
                        sortable: true,
                        width: 60,
                    }, {
                        field: 'is_cash',
                        title: '是否现金',
                        sortable: true,
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
                            return value ? '是' : '否'
                        },
                    }, {
                        field: 'is_close',
                        title: '是否已结算',
                        sortable: true,
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
                            return value ? '是' : '否'
                        },
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
                        //field: 'UserType.name',user_type_id
                        field: 'commodity_id',
                        title: '商品名',
                        width: 80,
                        sortable: true,
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
                        //field: 'UserType.name',user_type_id
                        field: 'card_id',
                        title: '会员卡号',
                        width: 50,
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
                        //field: 'UserType.name',user_type_id
                        field: 'member_id',
                        title: '会员名',
                        width: 80,
                        sortable: true,
                        formatter: function (value, row, index) {
                            return row.Member ? row.Member.name : '';
                        },
                        editor: {
                            type: 'combogrid',
                            options: {
                                //queryParams: { findBy: ['card_number', 'name'] },
                                mode: 'remote',
                                url: '/member/findAll',
                                panelWidth: 300,
                                //panelMaxHeight: 265,
                                //panelHeight: 200,
                                idField: 'id',
                                textField: 'name',
                                columns: [[
                                    // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },                                
                                    { field: 'name', title: '会员名', width: 165 },
                                ]],
                                //reversed: true,
                                sortName: 'name',
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
                        //field: 'UserType.name',user_type_id
                        field: 'employee_id',
                        title: '雇员名',
                        width: 80,
                        sortable: true,
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
                                onShowPanel: combogridOnShowPanel,
                            }
                        }
                    }, {
                        //field: 'UserType.name',user_type_id
                        field: 'user_id',
                        title: '记录员名',
                        width: 80,
                        sortable: true,
                        formatter: function (value, row, index) {
                            return row.User ? row.User.name : '';
                        },
                        editor: {
                            type: 'combogrid',
                            options: {
                                // queryParams: { findBy: ['card_number', 'name'] },
                                mode: 'remote',
                                url: '/user/findAll',
                                panelWidth: 300,
                                //panelMaxHeight: 265,
                                //panelHeight: 200,
                                idField: 'id',
                                textField: 'name',
                                columns: [[
                                    // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },
                                    // { field: 'card_number', title: '会员卡号', width: 100 },
                                    { field: 'name', title: '记录员名', width: 165 },
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
                    },
                ]];



                //对话框设置
                var dialogOp = {
                    title: `${view.currentRow.Employee.name}于${new Date(Date.parse(view.currentRow.updated_at)).toLocaleString()} 结算工资的消费记录`,
                    width: 1000,
                    top: 120,
                    height: 500,
                    closable: false,
                    closed: false,
                    cache: false,
                    //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                    //href: 'get_content.php',
                    modal: true,
                    onBeforeOpen: function () {
                        listWageView.build(listWageViewOp);
                    },
                    onOpen: function () {

                        listWageView.getTableDiv().datagrid('load', {
                            name: 'wage_id',
                            value: view.currentRow.id,
                            isEq: true,
                            // where: JSON.stringify([{ "leftBracket": "", "field": "employee_id", "compareSymbol": "eq", "value": view.currentRow.id, "rightBracket": "", "logicalSymbol": "and" }, { "leftBracket": "", "field": "is_close", "compareSymbol": "eq", "value": "0", "rightBracket": "", "logicalSymbol": "and" }]),
                        });


                        // // payView.getTableDiv().datagrid('appendRow', payView.makeNewRow());
                        // payView.getTableDiv().datagrid('loadData', {
                        //     footer: [
                        //         { Commodity: { name: '现金应收：' }, price: 0 },
                        //         { Commodity: { name: '卡内应收：' }, price: 0 },
                        //         { Commodity: { name: '合计应收：' }, price: 0 }
                        //     ],
                        //     rows: [payView.makeNewRow()],
                        //     total: 1
                        // });
                    },
                    buttons: [
                        //     {
                        //     text: '保存',
                        //     handler: function () {
                        //         dialogDiv.dialog('close');
                        //         // $.messager.confirm('确认对话框', '是否继续结算？', function (r) {
                        //         //     if (r) {
                        //         //         listWageHandler();
                        //         //     }
                        //         // });
                        //     },
                        // }, 
                        {
                            text: '全部展开或折叠',
                            handler: function () {
                                if (listWageView.collapseGroup) {
                                    listWageView.getTableDiv().datagrid('expandGroup');
                                    listWageView.collapseGroup = false;
                                } else {
                                    listWageView.getTableDiv().datagrid('collapseGroup');
                                    listWageView.collapseGroup = true;
                                }

                                // $.messager.confirm('确认对话框', '是否继续结算？', function (r) {
                                //     if (r) {
                                //         listWageHandler();
                                //     }
                                // });
                            },
                        },
                        {
                            text: '关闭',
                            // handler: _closeDlg,
                            handler: function () {
                                dialogDiv.dialog('close');

                                // $.post('card/clearCurrentCard')
                                //     .done(function (data) {
                                //         if (data.cleared) {
                                //             view.currentRow.passed = false;
                                //             dialogDiv.dialog('close');
                                //         } else {
                                //             $.messager.alert('提示', '系统内部错误', 'info', function () {
                                //                 $.get('logout');
                                //             });
                                //         }
                                //     })
                            }
                        }]
                };
                dialogDiv.dialog(dialogOp);

            }


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
                    if (field === 'action_listWage') {
                        view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                        listWage();
                        return;
                    }

                },
                singleSelect: true,
                //自添加属性，用于关闭cell编辑功能，目的是避免搜索框失效。
                listOnly: true,
                multiSort: true,
                remoteSort: true,

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
                    title: '工资ID',
                    hidden: true,
                }, {
                    field: 'action_listWage',
                    title: '查看消费记录',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `< button onclick = 'actionButton.resetPass(${JSON.stringify(row)})' > 修改密码</button > `;
                        return '<button>查看消费记录</button>';
                    },
                },
                //  {
                //     field: 'action_list',
                //     title: '结算记录',
                //     //width: 90,
                //     formatter: function (value, row, index) {
                //         // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                //         return '<button>结算记录</button>';
                //     },
                // }, {
                //     field: 'action_delete',
                //     title: '撤销结算',
                //     //width: 90,
                //     formatter: function (value, row, index) {
                //         // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                //         return '<button>撤销结算</button>';
                //     },
                // },
                {
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
                            onLoadSuccess: combogridOnLoadSuccess,
                            onShowPanel: combogridOnShowPanel,
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
                            onLoadSuccess: combogridOnLoadSuccess,
                            onShowPanel: combogridOnShowPanel,
                        }
                    }
                }, {
                    field: 'wage',
                    title: '基础工资',
                    width: 60,
                    sortable: true,
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
                    field: 'bonus',
                    title: '奖金',
                    sortable: true,
                    width: 60,
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