<div id='member' style="height: 100%;"></div>
<script>
    //# sourceURL=member.js
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
                { name: 'name', text: '会员名' },
                { name: 'phone', text: '会员电话' },
                { name: 'otherphone', text: '其他电话' },
                { name: 'remark', text: '备注' },
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
                    remark: '',
                    //card_id: newRowIndex ? newRowIndex : 0,
                };
            };

            view.currentRow = null;
            var recordCase = function () {
                if (!view.currentRow) {
                    return;
                }
                if (view.dialogPage.recordCaseDiv) {
                    view.dialogPage.recordCaseDiv.dialog('setTitle', `修改   ${view.currentRow.name}   的诊疗方案`);
                    view.dialogPage.recordCaseDiv.dialog('open', true);
                    return;
                }
                var dialogDiv = $('<div></div>');
                dialogDiv.appendTo(view.getDialogContainerDiv());
                view.dialogPage.recordCaseDiv = dialogDiv;

                //基本信息
                var nameDiv = $('<div></div>');
                var cardNumberDiv = $('<div></div>');
                var cardTypeDiv = $('<div></div>');

                var phoneDiv = $('<div></div>');
                var otherphoneDiv = $('<div></div>');
                var remarkDiv = $('<div></div>');

                $('<div style="padding:12px"></div>').appendTo(dialogDiv)
                    .append($('<span></span>').append(nameDiv))
                    .append($('<span style="margin-left:20px;"></span>').append(cardNumberDiv))
                    .append($('<span style="margin-left:20px;"></span>').append(cardTypeDiv));

                $('<div style="padding:12px"></div>').appendTo(dialogDiv)
                    .append($('<span ></span>').append(phoneDiv))
                    .append($('<span style="margin-left:20px;"></span>').append(otherphoneDiv))
                    .append($('<span style="margin-left:20px;"></span>').append(remarkDiv));

                dialogDiv.append('<hr/>');

                nameDiv.textbox({
                    label: '会员名:',
                    // //prompt: 'Ent',
                    width: 240,
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    latipPosition: 'right',
                    labelWidth: '80',
                    // validType: ['isNumber', 'length[8,11]'],
                    disabled: true,
                    // value: view.currentRow.name,
                });

                cardNumberDiv.textbox({
                    label: '会员卡号:',
                    // //prompt: 'Ent',
                    width: 240,
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    latipPosition: 'right',
                    labelWidth: '80',
                    // validType: ['isNumber', 'length[8,11]'],
                    disabled: true,
                    // value: view.currentRow.Card.card_number,
                });

                cardTypeDiv.textbox({
                    label: '会员类型:',
                    // //prompt: 'Ent',
                    width: 240,
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    latipPosition: 'right',
                    labelWidth: '80',
                    // validType: ['isNumber', 'length[8,11]'],
                    disabled: true,
                    // value: view.currentRow.Card.CardType.name,
                });

                phoneDiv.textbox({
                    label: '电话:',
                    // //prompt: 'Ent',
                    width: 240,
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    latipPosition: 'right',
                    labelWidth: '80',
                    // validType: ['isNumber', 'length[8,11]'],
                    disabled: true,
                    // value: view.currentRow.name,
                });

                otherphoneDiv.textbox({
                    label: '其他电话:',
                    // //prompt: 'Ent',
                    width: 240,
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    latipPosition: 'right',
                    labelWidth: '80',
                    // validType: ['isNumber', 'length[8,11]'],
                    disabled: true,
                    // value: view.currentRow.Card.card_number,
                });

                remarkDiv.textbox({
                    label: '备注:',
                    // //prompt: 'Ent',
                    width: 240,
                    labelPosition: 'before',
                    labelAlign: 'left',
                    // required: true,
                    latipPosition: 'right',
                    labelWidth: '80',
                    // validType: ['isNumber', 'length[8,11]'],
                    disabled: true,
                    // readonly: true,
                    // value: view.currentRow.Card.CardType.name,
                });

                //反馈
                var caseDiv = $('<div></div>');
                var caseRemarkDiv = $('<div></div>');


                $('<div style="padding:12px"></div>').appendTo(dialogDiv).append(caseDiv);
                dialogDiv.append('<hr/>');
                $('<div style="padding:12px"></div>').appendTo(dialogDiv).append(caseRemarkDiv);

                caseDiv.textbox({
                    label: '身体状态描述:',
                    prompt: '70字',
                    width: '100%',
                    labelPosition: 'top',
                    labelAlign: 'left',
                    // required: true,
                    latipPosition: 'right',
                    labelWidth: '200',
                    // validType: ['isNumber', 'length[8,11]'],
                    // disabled: true,
                    multiline: true,
                    height: 80,
                    // value: view.currentRow.Card.CardType.name,
                });
                // caseRemarkDiv.textbox({
                //     label: '诊疗步骤:',
                //     // //prompt: 'Ent',
                //     width: '100%',
                //     labelPosition: 'top',
                //     labelAlign: 'left',
                //     // required: true,
                //     latipPosition: 'right',
                //     labelWidth: '200',
                //     // validType: ['isNumber', 'length[8,11]'],
                //     // disabled: true,
                //     multiline: true,
                //     height: 180,
                //     // value: view.currentRow.Card.CardType.name,
                // });
                caseRemarkDiv.datagrid({
                    title: '诊疗步骤',
                    width: '100%',
                    columns: [[
                        { field: 'zero', title: '分组', width: 100, editor: { type: 'textbox', options: {} } },
                        { field: 'one', title: '一', width: 100, editor: { type: 'textbox', options: {} } },
                        { field: 'two', title: '二', width: 100, editor: { type: 'textbox', options: {} } },
                        { field: 'three', title: '三', width: 100, editor: { type: 'textbox', options: {} } },
                        { field: 'four', title: '四', width: 100, editor: { type: 'textbox', options: {} } },
                        { field: 'five', title: '五', width: 100, editor: { type: 'textbox', options: {} } },
                        { field: 'six', title: '六', width: 100, editor: { type: 'textbox', options: {} } },
                    ]],
                }).datagrid('enableCellEditing');




                var dialogOp = {
                    title: `修改   ${view.currentRow.name}   的诊疗方案`,
                    width: 800,
                    top: 120,
                    //height: 120,
                    closed: false,
                    cache: false,
                    //content: '<input class="easyui-passwordbox" prompt="密码" iconWidth="28" style="width:100%;height:34px;padding:10px">',
                    //href: 'get_content.php',
                    modal: true,
                    onBeforeOpen: function () {

                    },
                    onOpen: function () {


                        if (!view.currentRow.Card) {
                            cardNumberDiv.textbox('reset');
                        } else {
                            cardNumberDiv.textbox('setText', view.currentRow.Card.card_number);
                        };
                        if (!view.currentRow.Card || !view.currentRow.Card.CardType) {
                            cardTypeDiv.textbox('reset');
                        } else {
                            cardTypeDiv.textbox('setText', view.currentRow.Card.CardType.name);
                        };
                        nameDiv.textbox('setText', view.currentRow.name);
                        phoneDiv.textbox('setText', view.currentRow.phone);
                        otherphoneDiv.textbox('setText', view.currentRow.otherphone);
                        remarkDiv.textbox('setText', view.currentRow.remark);

                        caseDiv.textbox('setText', view.currentRow.case);


                        let caseRemarkArray = [];
                        try {
                            caseRemarkArray = JSON.parse(view.currentRow.case_remark);
                        } catch (e) {
                            // console.log(e);
                        }
                        caseRemarkArray = caseRemarkArray ? caseRemarkArray : [
                            { zero: '第一组', one: '', two: '', three: '', four: '', five: '', six: '' },
                            { zero: '第二组', one: '', two: '', three: '', four: '', five: '', six: '' },
                            { zero: '第三组', one: '', two: '', three: '', four: '', five: '', six: '' },
                            { zero: '第四组', one: '', two: '', three: '', four: '', five: '', six: '' },
                        ];

                        caseRemarkDiv.datagrid('loadData', caseRemarkArray);
                        // if (Array.isArray(caseRemarkArray) && caseRemarkArray.length === 4) {
                        //     caseRemarkDiv.datagrid('loadData', caseRemarkArray);
                        // };
                        // caseRemarkDiv.textbox('setText', view.currentRow.case_remark);



                        //设置焦点                               
                        caseDiv.textbox('textbox').focus();
                    },
                    buttons: [{
                        text: '保存',
                        handler: function () {
                            var caseValue = caseDiv.textbox('getValue');
                            // var caseRemarkValue = caseRemarkDiv.textbox('getValue');

                            //结束当前编辑
                            if (caseRemarkDiv.datagrid('cell')) {
                                caseRemarkDiv.datagrid('endEdit', caseRemarkDiv.datagrid('cell').index);
                            }
                            var caseRemarkValue = JSON.stringify(caseRemarkDiv.datagrid('getRows'));
                            $.post('member/saveCase', {
                                id: view.currentRow.id,
                                name: view.currentRow.name,
                                caseValue,
                                caseRemarkValue
                            }).done(function (data) {
                                if (data.message) {
                                    $.messager.alert('提示', data.message, 'info', function () {
                                    });
                                    return;
                                }

                                $.messager.alert('提示', `会员：<b>${data.memberName}</b>的诊疗方案更新成功`, 'info', function () {
                                    view.getTableDiv().datagrid('reload');
                                    dialogDiv.dialog('close');
                                    printCase();
                                });
                            });
                        },
                    }, {
                        text: '关闭',
                        handler: function () {
                            //dialogDiv.dialog('destroy');
                            dialogDiv.dialog('close');
                        }
                    }]
                };
                dialogDiv.dialog(dialogOp);
            };
            var printCase = function () {
                if (!view.currentRow) {
                    return;
                }
                // window.location.href = "http://www.jb51.net";
                window.open(`/member/list/?id=${view.currentRow.id}`);
            };
            op.tableOption = {
                onEndEdit: function (index, row, changes) {
                    if (!Object.keys(changes).includes('card_id')) { return; }
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'card_id'
                    });
                    if (!row.Card) { row.Card = {}; }
                    var selectedCard = $(ed.target).combogrid('grid').datagrid('getSelected');
                    if (!selectedCard) {
                        // $(this).datagrid('updateRow', {
                        //     index: index,
                        //     row: {
                        //         card_id: 1,
                        //     }
                        // });

                        row.card_id = null;
                        row.Card.card_number = '卡号为空';
                        row.Card.name = '卡号为空';
                    } else {
                        row.Card.card_number = selectedCard.card_number;
                        row.Card.name = selectedCard.name;
                    }


                    //row.UserType.name = $(ed.target).combobox('getText');
                    // if ($(ed.target).combobox('getText').length!=0) { 
                    //     row['UserType.name'] = $(ed.target).combobox('getText');
                    // }
                },
                onClickCell: function (index, field, value) {
                    if (!field.includes('action_')) { return; }
                    view.currentRow = view.getTableDiv().datagrid('getRows')[index];
                    if (field === 'action_case') {
                        recordCase();
                        return;
                    }
                    if (field === 'action_print') {
                        printCase();
                        return;
                    }

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
                }, {
                    field: 'id',
                    title: '会员ID',
                    hidden: true,
                }, {
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
                    field: 'name',
                    title: '会员名',
                    sortable: true,
                    width: 60,
                    editor: {
                        type: 'textbox',
                        options: {}
                    }
                }, {
                    field: 'action_print',
                    title: '方案',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `< button onclick = 'actionButton.resetPass(${JSON.stringify(row)})' > 修改密码</button > `;
                        return '<button>打印</button>';
                    },
                }, {
                    field: 'action_case',
                    title: '方案',
                    //width: 90,
                    formatter: function (value, row, index) {
                        // return `< button onclick = 'actionButton.resetPass(${JSON.stringify(row)})' > 修改密码</button > `;
                        return '<button>调整</button>';
                    },
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
                    field: 'remark',
                    title: '备注',
                    width: 100,
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
                },

            ]];

            view.build(op);
        };

        init();

    }();
</script>