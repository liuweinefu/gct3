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
                    remark: '备注' + Math.round(Math.random() * 1000),
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
                    if (!row.employeeType) { row.employeeType = {}; }
                    row.employeeType.name = $(ed.target).combobox('getText');

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
                    title: '技师ID',
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
                            // panelHeight: employeeType.length * 20 + 15,
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