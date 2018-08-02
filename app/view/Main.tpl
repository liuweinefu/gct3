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
    <script type="text/javascript" src="/public/page.js"></script>


</head>

<!--<body class="easyui-layout">-->

<body>

    <script>
        //void function () {
        var mainDiv = null;
        var tabDiv = null;
        var menuDiv = null;
        var init = function (data) {
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
                            console.log('abc');
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


        var setLogin = function () {

        };
        var buildMain = function () {


            $.post('/getMenu')
                .done(init)
                .fail(setLogin);
        };
        //初始化页面
        buildMain();
        //}();

    </script>

</body>

</html>