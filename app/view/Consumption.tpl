<div id='consumption' style="height: 100%;"></div>
<script>

    //# sourceURL=consumption.js
    void function () {
        var anchorDiv = $('#consumption');
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
                { name: 'Card.card_number', text: '会员卡号' },
                { name: 'Member.name', text: '会员名' },
                { name: 'Employee.name', text: '雇员名' },
                { name: 'price', text: '消费金额' },
                { name: 'User.name', text: '记录员名' },

            ];

            //buttons设置**************************************************
            var expandGroupView = function () {
                if (view.collapseGroup) {
                    view.getTableDiv().datagrid('expandGroup');
                    view.collapseGroup = false;
                } else {
                    view.getTableDiv().datagrid('collapseGroup');
                    view.collapseGroup = true;
                }

                // $.messager.confirm('确认对话框', '是否继续结算？', function (r) {
                //     if (r) {
                //         listWageHandler();
                //     }
                // });
            };
            op.buttonOption = {
                // importExcel: true,
                // exportExcel: true,
                expand: {
                    text: '全部展开或折叠',
                    iconCls: 'icon-search',
                    onClick: expandGroupView,
                },
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
            op.tableOption = {
                onClickCell: function (index, field, value) {
                    if (field !== 'action_revoke') { return; }
                    view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                    if (!view.currentRow || !view.currentRow.id) {
                        $.messager.alert('提示', '当前行出错', 'warning');
                        return;
                    }
                    var revoke = function () {
                        $.post('consumption/revoke', { id: view.currentRow.id })
                            .done(function (data) {
                                if (data.message) {
                                    $.messager.alert('警告', data.message, 'warning',
                                        function () {
                                            view.getTableDiv().datagrid('reload');
                                        });
                                } else {
                                    $.messager.alert('撤销成功！',
                                        `商品名称：${data.commdityName}</br>
                                                商品库存：${data.commdityNowQuantity}(撤销前：${data.commdityLastQuantity})</br ></br >
                                                会员名称：${data.memberName}(卡号：${data.card_number})</br >
                                                当前余额：￥${Number.parseFloat(data.cardNowBalance).toFixed(2)}</br >
                                                撤销前余额：￥${Number.parseFloat(data.cardLastBalance).toFixed(2)}`,
                                        'info',
                                        function () {
                                            view.getTableDiv().datagrid('reload');
                                        });
                                };
                            });
                    }

                    $.messager.confirm('是否继续撤销', '是否撤销当前消费记录？', function (r) {
                        if (r) {
                            revoke();
                        }
                    });
                },

                queryParams: {
                    where: JSON.stringify([{
                        "leftBracket": "", "field": "updated_at", "compareSymbol": "gt", "value": new Date(Date.now() - 86400000 * 1), "rightBracket": "", "logicalSymbol": "and", "viewValue": null
                    }])
                },
                // queryParams: {
                //     where: JSON.stringify([{
                //         "leftBracket": "", "field": "updated_at", "compareSymbol": "lt", "value": new Date(), "rightBracket": "", "logicalSymbol": "and", "viewValue": null
                //     }, {
                //         "leftBracket": "", "field": "updated_at", "compareSymbol": "gt", "value": "2018-11-29", "rightBracket": "", "logicalSymbol": "and", "viewValue": null
                //     }])
                // },
                url: '/consumption/findAll',
                showFooter: true,
                view: groupview,
                groupField: 'commodity_id',
                groupFormatter: function (value, rows) {
                    if (!Array.isArray(rows) && rows.length === 0) {
                        return;
                    };


                    var message = '';

                    var commodityName = rows[0].Commodity ? rows[0].Commodity.name : '已删除商品';
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
                pageSize: '1000',
                pageList: [1000, 5000, 10000, 50000],

                singleSelect: true,
                //自添加属性，用于关闭cell编辑功能，目的是避免搜索框失效。
                listOnly: true,


                multiSort: true,
                remoteSort: true,
                sortName: 'updated_at',
                sortOrder: 'desc',
                onLoadSuccess: function (data) {
                    // expand();
                    // console.log(data);
                    // data.footer = [{
                    //     name: 'aaaaaa',
                    //     price: 0.00
                    // }];
                    expandGroupView();

                    var allprice = data.rows.reduce((prev, curr) => {
                        return prev - (-curr.price);
                    }, 0);

                    view.getTableDiv().datagrid('reloadFooter', [{
                        action_revoke: 1,
                        Commodity: { name: '合计' },
                        price: allprice,
                    }]);

                }
            };

            var combogridOnLoadSuccess = combogridEvents(view).onLoadSuccess;
            var combogridOnShowPanel = combogridEvents(view).onShowPanel;

            op.tableOption.columns = [[
                {
                    field: 'id',
                    title: '消费记录ID',
                    hidden: true,
                }, {
                    field: 'action_revoke',
                    title: '撤销结算',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `<button onclick='actionButton.resetPass(${JSON.stringify(row)})'>修改密码</button>`;
                        if (value) { return }
                        return '<button>撤销结算</button>';
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
                        type: 'datebox',
                        options: {}
                    },
                },
                {
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
                    field: 'commodity_price',
                    title: '商品单价',
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
                        if (row.Commodity && row.Commodity.price) {
                            return `￥${Number.parseFloat(row.Commodity.price).toFixed(2)}`;
                        } else {
                            return '￥0.00';
                        }
                    }
                }, {
                    field: 'quantity',
                    title: '数量',
                    sortable: true,
                    width: 60,
                }, {
                    field: 'is_discount',
                    title: '是否打折',
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
                        switch (value) {
                            case true:
                            case '1': return '是';
                            case false:
                            case '0': return '否';
                            default: return '';
                        }
                    },
                }, {
                    field: 'price',
                    title: '消费金额',
                    width: 200,
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
                        switch (value) {
                            case true:
                            case '1': return '是';
                            case false:
                            case '0': return '否';
                            default: return '';
                        }
                    },
                }, {
                    //field: 'UserType.name',user_type_id
                    field: 'employee_id',
                    title: '治疗师',
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
                    field: 'remark',
                    title: '备注',
                    width: 100,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
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
                        switch (value) {
                            case true:
                            case '1': return '是';
                            case false:
                            case '0': return '否';
                            default: return '';
                        }
                    },
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
                },

            ]];

            view.build(op);
        };


        init();
    }();
</script>