<!DOCTYPE html>

<html>

<head>
    <meta charset="UTF-8">
</head>

<body style="width:215mm;margin:0 auto;border-style:solid  ">

    <!-- <body style="width:215mm;margin:0 auto;border-style:solid  solid solid solid;"> -->

    <table style="width:210mm;margin:0 auto;">
        <tr>
            <td style="width:50mm;">卡号： {{ cardNumber }} </td>
            <td rowspan="4">
                <img src="/public/LOGO.jpg" alt="logo" style="width:120mm;height:25mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>

        </tr>
        <tr>
            <td>电话： {{ phone}} </td>

        </tr>
        <tr>
            <td>姓名： {{ name }} </td>
        </tr>
        <tr>
            <td>日期： {{ created_at }} </td>
        </tr>
    </table>
    <hr>

    <!-- <table style="width:210mm;height:10mm;margin:0 auto;">
        <tr>
            <td>描述：
                {{ case }} </td>
        </tr>
    </table> -->

    <!-- <table style="width:210mm;height:180mm;margin:0 auto;"> -->
    <table style="width:210mm;margin:0 auto;">
        <tr>
            <td>
                <img src="/public/memberCase/ID_up.jpg" alt="正面" style="width:100mm;height:105mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>
            <td>
                <img src="/public/memberCase/ID_down.jpg" alt="背面" style="width:100mm;height:105mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>
        </tr>
        <tr>

            <td>
                <img src="/public/memberCase/ID_right.jpg" alt="右面" style="width:100mm;height:95mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>
            <td>
                <img src="/public/memberCase/ID_left.jpg" alt="左面" style="width:100mm;height:95mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>

        </tr>
    </table>
    <hr>
    <!-- <table style="width:210mm;height:10mm;margin:0 auto;">
        <tr>
            <td>描述：
                {{ case }} </td>
        </tr>
    </table>
    <table style="width:210mm;height:40mm;margin:0 auto;">
        <tr>
            <td>
                治疗方案:
                {{case_remark[0].one }}
            </td>
        </tr>
    </table> -->

    <table style="width:210mm;margin:0 auto;">
        <tr>
            <td>

                <table style="width:100mm;margin:0 auto;">
                    <tr>
                        <td>
                            描述： {{ case }}
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                治疗方案：
                <table style="width:100mm;margin:0 auto;">
                    <tr>
                        <td>
                            第一组
                        </td>
                        <td>
                            第二组
                        </td>
                        <td>
                            第三组
                        </td>
                        <td>
                            第四组
                        </td>
                    </tr>
                    <tr>
                        <td>
                            {{case_remark[0].one }}
                        </td>
                        <td>
                            {{case_remark[1].one }}
                        </td>
                        <td>
                            {{case_remark[2].one }}
                        </td>
                        <td>
                            {{case_remark[3].one }}
                        </td>
                    </tr>
                    <tr>

                        <td>
                            {{case_remark[0].two }}
                        </td>
                        <td>
                            {{case_remark[1].two }}
                        </td>
                        <td>
                            {{case_remark[2].two }}
                        </td>
                        <td>
                            {{case_remark[3].two }}
                        </td>
                    </tr>
                    <tr>

                        <td>
                            {{case_remark[0].three }}
                        </td>
                        <td>
                            {{case_remark[1].three }}
                        </td>
                        <td>
                            {{case_remark[2].three }}
                        </td>
                        <td>
                            {{case_remark[3].three }}
                        </td>
                    </tr>
                    <tr>

                        <td>
                            {{case_remark[0].four }}
                        </td>
                        <td>
                            {{case_remark[1].four }}
                        </td>
                        <td>
                            {{case_remark[2].four }}
                        </td>
                        <td>
                            {{case_remark[3].four }}
                        </td>
                    </tr>
                    <tr>

                        <td>
                            {{case_remark[0].five }}
                        </td>
                        <td>
                            {{case_remark[1].five }}
                        </td>
                        <td>
                            {{case_remark[2].five }}
                        </td>
                        <td>
                            {{case_remark[3].five }}
                        </td>
                    </tr>
                    <tr>

                        <td>
                            {{case_remark[0].six }}
                        </td>
                        <td>
                            {{case_remark[1].six }}
                        </td>
                        <td>
                            {{case_remark[2].six }}
                        </td>
                        <td>
                            {{case_remark[3].six }}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <script>
        window.print(); 
    </script>
</body>

</html>