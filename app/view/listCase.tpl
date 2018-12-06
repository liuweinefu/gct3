<!DOCTYPE html>

<html>

<head>
    <meta charset="UTF-8">
</head>

<body style="width:215mm;margin:0 auto;border-style:solid  solid none solid;">

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

    <table style="width:210mm;height:10mm;margin:0 auto;">
        <tr>
            <td>描述：
                {{ case }} </td>
        </tr>
    </table>

    <table style="width:210mm;height:230mm;margin:0 auto;">

        <tr>
            <td>
                <img src="/public/memberCase/ID_up.jpg" alt="正面" style="width:100mm;height:120mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>
            <td>
                <img src="/public/memberCase/ID_down.jpg" alt="背面" style="width:100mm;height:120mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>
        </tr>
        <tr>

            <td>
                <img src="/public/memberCase/ID_right.jpg" alt="右面" style="width:100mm;height:105mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>
            <td>
                <img src="/public/memberCase/ID_left.jpg" alt="左面" style="width:100mm;height:105mm;clear:both;display:block; margin:auto;padding-bottom:2mm;padding-top:2mm">
            </td>

        </tr>
    </table>
    <hr>
    <table style="width:210mm;height:40mm;margin:0 auto;">
        <tr>
            <td>
                治疗方案:
                {{ case_remark }}
            </td>
        </tr>
    </table>


    <script>
        // window.print(); 
    </script>
</body>

</html>