<div id='commodity' style="height: 100%;"></div>
<script>
    //@ sourceURL=commodity.js
    void function () {
        var anchorDiv = $('#commodity');
        var view = new lwTable(anchorDiv);

        var commodityType = null;
        $.post('/commodityType/findAll', {
            sort: 'sn',
            order: 'asc',
            originalModel: true,
        }).done(function (data) {
            commodityType = data.rows;
            init();
        }).fail(function () {

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
                { name: 'name', text: '商品名' },
                { name: 'remark', text: '备注' },
                { name: 'sn', text: '序号' },
                { name: 'CommodityType.name', text: '商品类型' },
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
                    name: '新商品 ' + Math.round(Math.random() * 1000),
                    price: 10000,
                    stocks: 10000,
                    remark: '',
                    sn: newRowIndex ? newRowIndex : 0,
                    //commodity_type_id: 1
                };
            };
            view.currentRow = null;
            op.tableOption = {
                onEndEdit: function (index, row, changes) {
                    if (!Object.keys(changes).includes('commodity_type_id')) { return; }
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'commodity_type_id'
                    });
                    if (!row.CommodityType) { row.CommodityType = {}; }
                    row.CommodityType.name = $(ed.target).combobox('getText');

                    //row.commodityType.name = $(ed.target).combobox('getText');
                    // if ($(ed.target).combobox('getText').length!=0) { 
                    //     row['commodityType.name'] = $(ed.target).combobox('getText');
                    // }
                },
                onClickCell: function (index, field, value) {
                    if (field === 'updated_at') {
                        $(this).datagrid('cancelEdit', index);
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
                },
                {
                    field: 'id',
                    title: '商品ID',
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
                    title: '商品名',
                    sortable: true,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'price',
                    title: '售价',
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
                    field: 'stocks',
                    title: '库存',
                    sortable: true,
                    width: 40,
                    editor: {
                        type: 'numberbox',
                        options: {
                            // prefix: '',
                            max: 100000000,
                            precision: 0
                        }
                    },
                    formatter: function (value, row, index) {
                        return Number.parseInt(value);
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
                    //field: 'commodityType.name',commodity_type_id
                    field: 'commodity_type_id',
                    title: '商品类型',
                    width: 80,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['commodityType']['name'];
                        return row.CommodityType ? row.CommodityType.name : '';
                    },
                    editor: {
                        type: 'combobox',
                        options: {
                            //panelWidth: 160,                    
                            editable: false,
                            valueField: 'id',
                            textField: 'name',
                            data: commodityType,
                            panelMaxHeight: 265,
                            panelHeight: commodityType.length * 30 + 15,
                            // onShowPanel: function () {
                            //     $(this).combobox('loadData', commodityType);
                            //     $(this).combobox('panel').panel('resize', {
                            //         height: commodityType.length * 20 + 15
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