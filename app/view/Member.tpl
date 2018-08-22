<div id='member' style="height: 100%;"></div>
<script>
    void function () {
        var anchorDiv = $('#member');
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
                { name: 'name', text: '会员名' },
                { name: 'phone', text: '会员电话' },
                { name: 'otherphone', text: '其他电话' },
                { name: 'remark', text: '备注' },
                { name: 'Card.card_number', text: '会员卡号' },
                { name: 'Card.name', text: '会员卡主名' },
            ];

            //buttons设置**************************************************
            op.buttonOption = {
                // importExcel: true,
                exportExcel: true,
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
                    name: '新会员 ' + Math.round(Math.random() * 1000),
                    phone: '00000000000',
                    otherphone: '0000',
                    remark: '备注' + Math.round(Math.random() * 1000),
                    card_id: newRowIndex ? newRowIndex : 0,
                };
            };
            view.currentRow = null;
            op.tableOption = {
                onEndEdit: function (index, row, changes) {
                    if (!Object.keys(changes).includes('card_id')) { return; }
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'card_id'
                    });
                    if (!row.Card) { row.Card = {}; }
                    row.Card.card_number = $(ed.target).combobox('getText');

                    //row.UserType.name = $(ed.target).combobox('getText');
                    // if ($(ed.target).combobox('getText').length!=0) { 
                    //     row['UserType.name'] = $(ed.target).combobox('getText');
                    // }
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
                    title: '会员ID',
                    hidden: true,
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
                    field: 'phone',
                    title: '电话',
                    width: 20,
                    sortable: true,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'otherphone',
                    title: '会员名',
                    width: 20,
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
                }, {
                    //field: 'UserType.name',user_type_id
                    field: 'card_id',
                    title: '会员卡号',
                    width: 80,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['UserType']['name'];
                        return row.Card ? row.Card.card_number : '';

                    },
                    editor: {
                        type: 'combogrid',
                        options: {
                            queryParams: { findBy: ['card_number', 'name'] },
                            mode: 'remote',
                            url: '/card/findAll',
                            // panelWidth: 120,
                            idField: 'id',
                            textField: 'card_number',
                            columns: [[
                                // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },
                                { field: 'card_number', title: '会员卡号', width: 50 },
                                { field: 'name', title: '会员卡主名', width: 100 },
                            ]],
                            loadFilter: function (data) {
                                return data.rows;
                            },
                            // panelHeight: 100,
                            // pagination: true,
                        }
                    }
                }, {
                    field: 'Card.name',
                    title: '会员名',
                    width: 100,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['UserType']['name'];
                        return row.Card ? row.Card.name : '';

                    },
                }

            ]];

            view.build(op);
        };

        init();

    }();
</script>