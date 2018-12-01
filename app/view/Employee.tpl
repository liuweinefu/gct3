<div id='employee' style="height: 100%;"></div>
<script>
    //@ sourceURL=employee.js
    void function () {
        var anchorDiv = $('#employee');
        var view = new lwTable(anchorDiv);

        var employeeType = null;
        $.post('/employeeType/findAll', {
            sort: 'sn',
            order: 'asc',
            originalModel: true,
        })
            .done(function (data) {
                employeeType = data.rows;
                init();
            })
            .fail(function () {

            });


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
                { name: 'name', text: '技师名' },
                { name: 'phone', text: '技师电话' },
                { name: 'otherphone', text: '技师其他电话' },
                { name: 'remark', text: '备注' },
                { name: 'sn', text: '序号' },
                { name: 'EmployeeType.name', text: '技师类型' },
            ];
            view.currentRow = null;
            var payWage = function () {
                if (view.dialogPage.payWageDiv) {
                    view.dialogPage.payWageDiv.dialog('setTitle', `为   ${view.currentRow.name}   结算截至目前的工资`);
                    view.dialogPage.payWageDiv.dialog('open', true);
                    return;
                }

                var dialogDiv = $('<div></div>');
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.payWageDiv = dialogDiv;

                var payWageView = new lwTable(dialogDiv);

                var wageDiv = $('<div></div>').appendTo($('<span style="margin-left:60px"></span>').appendTo(payWageView.getToolBarDiv()));
                var bonusDiv = $('<div></div>').appendTo($('<span style="margin-left:30px"></span>').appendTo(payWageView.getToolBarDiv()));

                wageDiv.numberbox({
                    width: '160',
                    label: '工资:',
                    // //prompt: 'Ent',                    
                    labelPosition: 'before',
                    labelAlign: 'left',
                    required: true,
                    min: 0,
                    precision: 2,
                    latipPosition: 'right',
                    labelWidth: '40',
                    value: view.currentRow.EmployeeType.wage ? view.currentRow.EmployeeType.wage : '0.00',
                    editable: false,
                    // disabled: true,
                });
                bonusDiv.numberbox({
                    width: '160',
                    label: '奖金:',
                    // //prompt: 'Ent',                    
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    min: 0,
                    precision: 2,
                    latipPosition: 'right',
                    labelWidth: '40',
                    value: '0.00',
                });

                var payWageViewOp = {};
                payWageViewOp.buttonOption = {
                    delete: {
                        text: '取消记录(<ins>A</ins>)',
                    },
                    redo: true,


                    expandOrCollapse: {
                        text: '全部展开或折叠(<ins>L</ins>)',//alt+d QQ浏览器拦截 考虑换其他快捷键
                        iconCls: 'icon-search',
                        onClick: function () {
                            if (payWageView.collapseGroup) {
                                payWageView.getTableDiv().datagrid('expandGroup');
                                payWageView.collapseGroup = false;
                            } else {
                                payWageView.getTableDiv().datagrid('collapseGroup');
                                payWageView.collapseGroup = true;
                            }
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
                payWageViewOp.tableOption = {
                    // idField: 'id',
                    // loadMsg: '数据加载中,请稍后',
                    // fit: true,
                    // fitColumns: true,
                    // singleSelect: true,

                    url: '/consumption/findAll',

                    queryParams: {
                        name: 'id',
                        value: '-1'
                    },

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

                    listOnly: true,
                    groupField: 'commodity_id',
                    view: groupview,
                    groupFormatter: function (value, rows) {
                        //return '(' + rows[0].Commodity.name + '): ' + rows.length + '次';                        
                        // var name = rows[0].Commodity.name;
                        // if (name.length < 30) {
                        //     let l = 30 - name.length
                        // }
                        return `${rows.length.toString().padStart(3, '0')}次---商品：${rows[0].Commodity.name}`;
                    },
                    onLoadSuccess: function () {

                        payWageView.getTableDiv().datagrid('collapseGroup');
                        payWageView.collapseGroup = true;

                    },

                };

                var combogridOnLoadSuccess = combogridEvents(view).onLoadSuccess;
                var combogridOnShowPanel = combogridEvents(view).onShowPanel;
                payWageViewOp.tableOption.columns = [[
                    {
                        field: 'ck',
                        checkbox: true
                    }, {
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


                var payWageHandler = function () {
                    var tableDiv = payWageView.getTableDiv();
                    //校验数据
                    // var rows = tableDiv.datagrid('getData').rows;

                    var sendObject = {
                        ////////////////////////////////////////////////////////////////////////////////////////////////
                        //添加 工资 奖金
                        ////////////////////////////////////////////////////////////////////////////////////////////////

                        wage: wageDiv.textbox('getValue'),
                        bonus: bonusDiv.textbox('getValue'),
                        employeeId: view.currentRow.id,
                        // consumptionIdArrray: JSON.stringify(tableDiv.datagrid('getData').rows.map(row => row.id))//只返回 消费id
                        consumptionIdArrray: tableDiv.datagrid('getData').rows.map(row => row.id)//只返回 消费id
                    };

                    $.post('employee/payWage', sendObject)
                        .done(function (data) {
                            if (data.message) {
                                $.messager.alert('错误', data.message, 'info');
                                return;
                            }
                            $.messager.alert('工资结算完成', `技师：${data.employeeName}</br>
                                                             实发工资:￥${Number.parseFloat(data.wage).toFixed(2)}`,
                                'info', function () {
                                    //清空已结算信息                                        
                                    dialogDiv.dialog('close');
                                });
                        });
                };

                dialogDiv.keydown(function (e) {
                    if (e.key === 'Enter') {
                        payWageHandler();
                    }
                })


                //对话框设置
                var dialogOp = {
                    title: `为   ${view.currentRow.name}   结算截至目前的工资`,
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
                        payWageView.build(payWageViewOp);
                    },
                    onOpen: function () {
                        wageDiv.numberbox('setValue', view.currentRow.EmployeeType.wage ? view.currentRow.EmployeeType.wage : '0.00');
                        bonusDiv.numberbox('setValue', '0.00');

                        // payWageView.getTableDiv().datagrid({ url: '/consumption/findAll' });
                        payWageView.getTableDiv().datagrid('load', {
                            // name: 'employee_id',
                            // value: view.currentRow.id,
                            where: JSON.stringify([{ "leftBracket": "", "field": "employee_id", "compareSymbol": "eq", "value": view.currentRow.id, "rightBracket": "", "logicalSymbol": "and" }, { "leftBracket": "", "field": "is_close", "compareSymbol": "eq", "value": "0", "rightBracket": "", "logicalSymbol": "and" }]),
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
                    buttons: [{
                        text: '保存',
                        handler: function () {
                            $.messager.confirm('确认对话框', '是否继续结算？', function (r) {
                                if (r) {
                                    payWageHandler();
                                }
                            });
                        },
                    }, {
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
                    name: '新员工 ' + Math.round(Math.random() * 1000),
                    phone: '00000000000',
                    remark: '',
                    sn: newRowIndex ? newRowIndex : 0,
                };
            };
            view.currentRow = null;
            op.tableOption = {
                onEndEdit: function (index, row, changes) {
                    if (!Object.keys(changes).includes('employee_type_id')) { return; }
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'employee_type_id'
                    });
                    if (!row.EmployeeType) { row.EmployeeType = {}; }
                    row.EmployeeType.name = $(ed.target).combobox('getText');

                    //row.employeeType.name = $(ed.target).combobox('getText');
                    // if ($(ed.target).combobox('getText').length!=0) { 
                    //     row['employeeType.name'] = $(ed.target).combobox('getText');
                    // }
                },
                onClickCell: function (index, field, value) {
                    if (field === 'updated_at') {
                        $(this).datagrid('cancelEdit', index);
                        return;
                    }
                    if (field === 'action_payWage') {
                        view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                        payWage();
                        return;
                    }

                },
                multiSort: true,
                remoteSort: true,

            };

            op.tableOption.columns = [[
                {
                    field: 'ck',
                    checkbox: true
                }, {
                    field: 'id',
                    title: '技师ID',
                    hidden: true,
                }, {
                    field: 'action_payWage',
                    title: '开工资',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `< button onclick = 'actionButton.resetPass(${JSON.stringify(row)})' > 修改密码</button > `;
                        return '<button>开工资</button>';
                    },
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
                    title: '技师名',
                    sortable: true,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
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
                    //field: 'employeeType.name',employee_type_id
                    field: 'employee_type_id',
                    title: '员工类型',
                    width: 80,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['employeeType']['name'];
                        return row.EmployeeType ? row.EmployeeType.name : '';
                    },
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 160,                    
                            editable: false,
                            valueField: 'id',
                            textField: 'name',
                            data: employeeType,
                            panelMaxHeight: 265,
                            panelHeight: employeeType.length * 30 + 15,
                            // onShowPanel: function () {
                            //     $(this).combobox('loadData', employeeType);
                            //     $(this).combobox('panel').panel('resize', {
                            //         height: employeeType.length * 20 + 15
                            //     });
                            // }
                        }
                    }
                },
            ]];

            view.build(op);
        };



    }();
</script>