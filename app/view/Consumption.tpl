<div id='consumption' style="height: 100%;"></div>
<script>
    //@ sourceURL=Consumption.js
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
                { name: 'Card.card_number', text: '卡号' },
                { name: 'Member.name', text: '会员名' },
                { name: 'Employee.name', text: '雇员名' },
                { name: 'price', text: '消费金额' },
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
            // view.currentRow = null;
            op.tableOption = {
                // onClickCell: function (index, field, value) {
                //     // if (field === 'updated_at') {
                //     //     $(this).datagrid('cancelEdit', index);
                //     //     return;
                //     // }
                //     $(this).datagrid('cancelEdit', index);
                //     return;
                // },
                singleSelect: true,
                //自添加属性，用于关闭cell编辑功能，目的是避免搜索框失效。
                listOnly: true,

                multiSort: true,
                remoteSort: true,
            };

            var combogridOnLoadSuccess = combogridEvents(view).onLoadSuccess;
            var combogridOnShowPanel = combogridEvents(view).onShowPanel;

            op.tableOption.columns = [[
                {
                    field: 'ck',
                    checkbox: true
                },
                {
                    field: 'id',
                    title: '消费记录ID',
                    hidden: true,
                }, {
                    field: 'price',
                    title: '消费金额',
                    width: 50,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
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
                        if (Number.parseInt(value) === 1) {
                            return '是'
                        } else {
                            return '否';
                        }
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
                        if (Number.parseInt(value) === 1) {
                            return '是'
                        } else {
                            return '否';
                        }
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

            view.build(op);
        };


        init();
    }();
</script>