<div id='cardRecharge' style="height: 100%;"></div>
<script>
    //# sourceURL=cardRecharge.js
    void function () {
        var anchorDiv = $('#cardRecharge');
        var view = new lwTable(anchorDiv);

        // var cardRechargeType = null;
        // $.post('/cardRechargeType/findAll', {
        //     sort: 'sn',
        //     order: 'asc',
        //     originalModel: true,
        // })
        //     .done(function (data) {
        //         cardRechargeType = data.rows;
        //         init();
        //     })
        //     .fail(function () {

        //     });


        var init = function () {
            var op = {};
            //searchBox设置**************************************************
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
            op.searchBoxOption.menu = [
                { name: 'Card.card_number', text: '会员卡号' },
                { name: 'Card.name', text: '会员卡主名' },
                { name: 'remark', text: '备注(会员名)' },
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
            op.tableOption = {
                // onEndEdit: function (index, row, changes) {
                //     if (!Object.keys(changes).includes('cardRecharge_type_id')) { return; }
                //     var ed = $(this).datagrid('getEditor', {
                //         index: index,
                //         field: 'cardRecharge_type_id'
                //     });
                //     if (!row.UserType) { row.UserType = {}; }
                //     row.UserType.name = $(ed.target).combobox('getText');

                //     //row.UserType.name = $(ed.target).combobox('getText');
                //     // if ($(ed.target).combobox('getText').length!=0) { 
                //     //     row['UserType.name'] = $(ed.target).combobox('getText');
                //     // }
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
                // {
                //     field: 'ck',
                //     checkbox: true
                // },
                {
                    field: 'id',
                    title: '充值记录ID',
                    hidden: true,
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
                            onLoadSuccess: combogridOnLoadSuccess,
                            onShowPanel: combogridOnShowPanel,
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
                    field: 'price',
                    title: '充值金额',
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
                    field: 'remark',
                    title: '备注(会员名)',
                    width: 50,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    //field: 'UserType.name',cardRecharge_type_id
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
                }

            ]];

            view.build(op);
        };


        init();
    }();
</script>