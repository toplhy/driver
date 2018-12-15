<html>
<head>
    <style>
        body{
            font-family:SimSun;
        }
        div{
            word-wrap:break-word;
        }
    </style>
</head>
<body>
    <div>
        <#list data as question>
            [<strong>${question.type}</strong>]${question.content}<br/>
            <#list question.options as option>
            ${option.key}.${option.value}<br/>
            </#list>
            正确答案:${question.answer}<br/>
            试题解析:${question.analysis}<br/><hr/>
        </#list>
    </div>
</body>
</html>