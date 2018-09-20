<div id='case' style="height: 100%;"></div>
<script>
    //@ sourceURL=case.js
    void function () {
        var anchorDiv = $('#case');
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
                { name: 'name', text: '病例概述' },
                { name: 'case', text: '病例' },
                { name: 'remark', text: '备注' },
                { name: 'Member.name', text: '会员名' },
                { name: 'Member.phone', text: '会员电话' },
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
                    name: '新病例 ' + Date(),
                    member_id: 1,
                };
            };
            view.currentRow = null;
            op.tableOption = {
                onEndEdit: function (index, row, changes) {
                    if (!Object.keys(changes).includes('number_id')) { return; }
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'number_id'
                    });
                    if (!row.Member) { row.Member = {}; }
                    var selectedMember = $(ed.target).combogrid('grid').datagrid('getSelected');
                    if (!selectedMember) {
                        // $(this).datagrid('updateRow', {
                        //     index: index,
                        //     row: {
                        //         Member_id: 1,
                        //     }
                        // });

                        row.Member_id = 1;
                        row.Member.name = '会员名不能为空';
                        row.Member.phone = '会员名不能为空';
                    } else {
                        row.Member.name = selectedMember.name;
                        row.Member.phone = selectedMember.phone;
                    }


                    //row.UserType.name = $(ed.target).combobox('getText');
                    // if ($(ed.target).combobox('getText').length!=0) { 
                    //     row['UserType.name'] = $(ed.target).combobox('getText');
                    // }
                },

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
                    title: '病例ID',
                    hidden: true,
                }, {
                    field: 'name',
                    title: '病例概述',
                    sortable: true,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'case',
                    title: '病例',
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
                            queryParams: { findBy: ['phone', 'name'] },
                            mode: 'remote',
                            url: '/member/findAll',
                            panelWidth: 300,
                            panelMaxHeight: 265,
                            //panelHeight: 200,
                            idField: 'id',
                            textField: 'name',
                            columns: [[
                                // { field: 'id', title: '会员卡ID', hidden: true, width: 60 },
                                { field: 'name', title: '会员名', width: 100 },
                                { field: 'phone', title: '会员电话', width: 165 },
                            ]],
                            reversed: true,
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
                    field: 'Member.phone',
                    title: '会员电话',
                    width: 100,
                    sortable: true,
                    formatter: function (value, row, index) {
                        //return row['UserType']['name'];        
                        return row.Member ? row.Member.phone : '';
                    },
                }

            ]];

            view.build(op);
        };

        init();

    }();
</script>