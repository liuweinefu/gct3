<div id='employeeType' style="height: 100%;"></div>
<script>
    //@ sourceURL=employeeType.js
    void function () {
        var anchorDiv = $('#employeeType');
        var view = new lwTable(anchorDiv);

        // var employeeType = null;
        // $.post('/employeeType/findAll', {
        //     sort: 'sn',
        //     order: 'asc',
        //     originalModel: true,
        // })
        //     .done(function (data) {
        //         employeeType = data.rows;
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
                { name: 'name', text: '技师类型' },
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
                    name: '技师类型 ' + Math.round(Math.random() * 1000),
                    wage: 0,
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
                //     if (!row.employeeType) { row.employeeType = {}; }
                //     row.employeeType.name = $(ed.target).combobox('getText');

                //     //row.employeeType.name = $(ed.target).combobox('getText');
                //     // if ($(ed.target).combobox('getText').length!=0) { 
                //     //     row['employeeType.name'] = $(ed.target).combobox('getText');
                //     // }
                // },

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
                    title: '技师类型ID',
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
                    },

                }, {
                    field: 'wage',
                    title: '工资',
                    sortable: true,
                    width: 40,
                    editor: {
                        type: 'numberbox',
                        options: {
                            prefix: '￥',
                            max: 100000,
                            precision: 2
                        }
                    },
                    formatter: function (value, row, index) {
                        return Number.isNaN(Number.parseFloat(value)) ? '￥0.00' : '￥' + Number.parseFloat(value).toFixed(2);
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
                },
            ]];

            view.build(op);
        };

        init();

    }();
</script>