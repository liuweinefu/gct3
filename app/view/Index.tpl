<!-- <!DOCTYPE html> -->

<html>

<head>
    <meta charset="UTF-8">
    <title>东北林业大学就业管理系统</title>
    <!-- <link rel="stylesheet" type="text/css" href="./dropify/css/dropify.min.css"> -->
    <link rel="stylesheet" type="text/css" href="/public/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/public/easyui/themes/icon.css">
    <script type="text/javascript" src="/public/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/public/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/public/easyui/datagrid-cellediting.js"></script>
    <script type="text/javascript" src="/public/easyui/datagrid-detailview.js"></script>
    <script type="text/javascript" src="/public/easyui/datagrid-groupview.js"></script>
    <script type="text/javascript" src="/public/easyui/locale/easyui-lang-zh_CN.js"></script>
    <!--<script type="text/javascript" src="./javascripts/bluebird.min.js"></script>-->
    <!--<script type="text/javascript" src="./jscode/webF.js"></script>-->
    <!--<script type="text/javascript" src="./jscode/local.js"></script>-->


    <!-- <script type="text/javascript" src="./dropify/js/dropify.min.js"></script> -->
    <script type="text/javascript" src="/public/mainPanel.js"></script>



</head>



<body>

    <script>
        //@ sourceURL=index.js
        void function () {
            //主页面
            var mainDiv = null;
            var tabDiv = null;
            var menuDiv = null;
            var initMain = function (data) {
                //初始化布局
                mainDiv = $('<div></div>');
                mainDiv.appendTo('body');
                mainDiv.layout({
                    fit: true
                });
                mainDiv.layout('add', {
                    region: 'west',
                    title: '菜单',
                    hideCollapsedContent: true,
                    split: true,
                    width: 180,
                    //maxWidth: '150px',
                });
                mainDiv.layout('add', {
                    region: 'south',
                    //title: '页底',
                    //split: true,
                    height: 30,
                    //maxWidth: '150px',
                });
                mainDiv.layout('add', {
                    region: 'center',
                    //title: '中',
                    split: true,
                    //height: 30,
                    //maxWidth: '150px',
                });

                //初始化tab
                tabDiv = $('<div></div>');
                tabDiv.appendTo(mainDiv.layout('panel', 'center'));
                tabDiv.tabs({
                    plain: true,
                    narrow: true,
                    fit: true,
                    border: false,
                });

                //初始化菜单
                menuDiv = $('<ul></ul>');
                menuDiv.appendTo(mainDiv.layout('panel', 'west'));
                var treeData = _builtMenuList(data.menus);
                menuDiv.tree({
                    data: treeData,
                    onClick: function (node) {
                        //console.log(node);
                        if (menuDiv.tree('isLeaf', node.target)) {
                            //打开tab
                            var tab = {};
                            tab.name = node.text;
                            tab.url = node.attributes.router;
                            tab.closeable = true;

                            if (tab.url !== '') {
                                _openTab(tab);
                            } else {
                                $.messager.alert('菜单错误', tab.name + '无有效router', 'warning');
                            }

                        } else {
                            if (node.state === 'open') {
                                menuDiv.tree('collapseAll', node.target);
                            } else {
                                menuDiv.tree('expandAll', node.target);
                            }
                        }
                    },
                });

                var findTab = function (tree) {
                    if (tree.attributes && tree.attributes.router) {
                        _openTab({
                            name: tree.text,
                            url: tree.attributes.router
                        });
                        return true;
                    }
                    if (Array.isArray(tree) && tree.length > 0) {
                        for (let node of tree) {
                            if (findTab(node)) {
                                return true;
                                //console.log('abc');
                                //break;
                            }
                        }
                    }
                    if (tree.children && findTab(tree.children)) {
                        return true;
                    }
                };
                findTab(treeData);
            };
            var _builtMenuList = function (menus) {
                menus.sort((one, two) => { return one.sn - two.sn })
                if (!Array.isArray(menus) || menus.length == 0) { return; }
                function builtRoot(menu) {
                    return {
                        id: menu.sn,
                        text: menu.name,
                        children: []
                    };
                }

                function builtLeaf(menu) {
                    return {
                        id: menu.sn,
                        text: menu.name,
                        attributes: {
                            router: menu.router
                        }
                    };
                }

                var list = [];
                var tree = {};
                if (typeof menus[0].router !== 'string' || menus[0].router.trim() !== '') {
                    tree = {
                        id: 0,
                        text: '菜单',
                        children: []
                    };
                }

                menus.forEach(menu => {
                    if (typeof menu.router === 'string' && menu.router.trim() === '') {
                        if (Object.keys(tree).length === 0) {
                            tree = builtRoot(menu);
                        } else {
                            list.push(tree);
                            tree = builtRoot(menu);
                        }
                    } else {
                        tree.children.push(builtLeaf(menu));
                    }
                });
                if (Array.isArray(tree.children) && tree.children.length !== 0) {
                    list.push(tree);
                }
                //console.log(list);
                return list;
            };
            var _openTab = function (tab) {
                if (!tabDiv.tabs('getTab', tab.name)) {
                    tabDiv.tabs('add', {
                        title: tab.name,
                        selected: true,
                        href: tab.url,
                        closable: tab.closeable === undefined ? false : true,
                    });
                } else {
                    tabDiv.tabs('select', tab.name);
                }
            };

            //登录模块
            var loginDialogDiv = null;
            // var indexRefresh = false;
            var initLogin = function (URL) {
                loginDialogDiv = $('<div></div>');
                loginDialogDiv.appendTo('body');


                nameDiv = $('<div></div>');
                nameDiv.appendTo($('<div style="width:100px;height:30px;padding:12px"></div>').appendTo(loginDialogDiv));
                nameDiv.textbox({ prompt: '用户名', iconCls: 'icon-man', iconWidth: 38 });

                passDiv = $('<div></div>');
                passDiv.appendTo($('<div style="width:100px;height:30px;padding:12px"></div>').appendTo(loginDialogDiv));
                passDiv.passwordbox({ prompt: '请输入密码', iconWidth: 38, showEye: true });

                captchaPicDiv = $(`<img style="width:180px;height:50px;padding:12px" src='/captcha?${Math.random()}'/>`);
                captchaPicDiv.appendTo(loginDialogDiv);
                captchaPicDiv.click(function (e) {
                    captchaPicDiv.attr('src', `/captcha?${Math.random()}`);
                });
                // captchaPicDiv.appendTo($('<div style="width:100px;height:30px;padding:12px"></div>').appendTo(loginDialogDiv));

                captchaDiv = $('<div></div>');
                captchaDiv.appendTo($('<div style="width:100px;height:30px;padding:12px"></div>').appendTo(loginDialogDiv));
                captchaDiv.textbox({ prompt: '验证码', iconCls: 'icon-lock', iconWidth: 38 });

                // buttonDiv = $('<div></div>');
                // buttonDiv.appendTo('loginDialogDiv');
                // buttonDiv.linkbutton({ text: '登录' });

                loginDialogDiv.dialog({
                    onBeforeOpen: function () {
                        nameDiv.textbox('clear');
                        passDiv.textbox('clear');
                        captchaPicDiv.click();
                        captchaDiv.textbox('clear');
                    },
                    width: 240,
                    // height: 350,
                    //iconCls: 'icon-save',
                    title: '用户登录',
                    closable: false,
                    modal: true,
                    //toolbar: '#dlg-toolbar',
                    // toolbar: view.getToolBarDiv(),
                    buttons: [{
                        text: '登录',
                        // iconCls: 'icon-save',
                        //handler:confirm,
                        handler: function () {
                            var sendObject = {
                                name: nameDiv.textbox('getValue'),
                                pass: passDiv.textbox('getValue'),
                                captcha: captchaDiv.textbox('getValue')
                            }
                            $.post('/verify', sendObject)
                                .done(function (data) {
                                    captchaPicDiv.click();
                                    if (data !== 'isLogin') {
                                        $.messager.alert('提示', data, 'info', function () {
                                            // tableDiv.datagrid('reload');
                                            // tableDiv.datagrid('loaded');
                                            //tableDiv.datagrid('getPanel').focus();
                                            //searchBoxDiv.textbox('textbox').focus();//重置焦点
                                        });
                                    } else {
                                        if (URL === '/getMenu') { location.reload(); }
                                        loginDialogDiv.dialog('close', false);
                                    }
                                });
                            // console.log('name:' + nameDiv.textbox('getValue') + ';pass:' + passDiv.textbox('getValue') + ';captcha:' + captchaDiv.textbox('getValue'));

                        }
                    },
                        // {

                        //     text: '关闭',
                        //     // iconCls: 'icon-save',
                        //     handler: function () {
                        //         loginDialogDiv.dialog('close', false);
                        //     }
                        // }
                    ],
                });

                // var ll = true;
                // setInterval(function () {
                //     if (ll) {
                //         loginDialogDiv.dialog('close', false);
                //         ll = false;
                //     } else {
                //         loginDialogDiv.dialog('open', false);
                //         ll = true;
                //     }

                // }, 5000);
            };


            //构建
            var buildMain = function () {

                $(document).ajaxError(function (event, jqXHR, ajaxSettings, thrownError) {
                    // console.log(event);
                    //console.log(jqXHR);
                    // console.log(jqXHR.responseJSON);
                    if (jqXHR.responseText === '/logout') {
                        location.reload();
                        return;
                    }
                    if (jqXHR.status === 401) {
                        //indexRefresh = jqXHR.responseText === 'refresh' ? true : false;

                        //console.log('触发登录模块' + jqXHR.status);
                        if (loginDialogDiv) {
                            loginDialogDiv.dialog('open', false);
                            // return;
                        } else {
                            initLogin(jqXHR.responseText);
                        }
                    } else {
                        let message = '网站出错';
                        if (jqXHR.responseJSON && jqXHR.responseJSON.message) {
                            message = jqXHR.responseJSON.message;
                        } else if (jqXHR.responseText) {
                            message = jqXHR.responseText;
                        }
                        $.messager.alert('出错信息', message, 'info', function () {
                            //dialogDiv.dialog('close', true);
                        });
                    };

                });


                $.post('/getMenu')
                    .done(initMain)
            };
            //初始化页面
            buildMain();
        }();

    </script>

</body>

</html>