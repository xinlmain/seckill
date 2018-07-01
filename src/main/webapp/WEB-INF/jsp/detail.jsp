<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="common/head.jsp"%>
    <title>秒杀详情页</title>
</head>
<body>
    <div class="container">
        <div class="panel panel-default text-center">
            <div class="pannel-heading">
                <h1>${seckill.name}</h1>
            </div>
        </div>
        <div class="panel-body">
            <h2 class="text-danger text-center">
                <%-- time图标 --%>
                <span class="glyphicon glyphicon-time"></span>
                <%-- 倒计时 --%>
                <span class="glyphicon" id="seckill_box"></span>
            </h2>
        </div>
    </div>

    <div id="killPhoneModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title text-center">
                        <span class="glyphicon glyphicon-phone"></span>
                        秒杀电话：
                    </h3>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-8 col-xs-offset-2">
                            <input type="text" name="killPhone" id="killPhoneKey"
                                placeholder="填手机号^o^" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <%-- 验证信息 --%>
                    <span id="killPhoneMessage" class="glyphicon"></span>
                    <button id="killPhoneBtn" type="button" class="btn btn-success">
                        <span class="glyphicon glyphicon-phone"></span>
                        Submit
                    </button>
                </div>
            </div>
        </div>

    </div>
</body>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<%-- jQuery cookie 插件 --%>
<script src="https://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<%-- jQuery countdown倒计时插件 --%>
<script src="https://cdn.bootcss.com/jquery.countdown/2.2.0/jquery.countdown.min.js"></script>

<script src="/resources/scripts/seckill.js" type="text/javascript"></script>

<script type="text/javascript">
    $(function () {
        //使用EL表达式传入参数
        seckill.detail.init({
            seckillId: ${seckill.seckillId},
            startTime: ${seckill.startTime.time},
            endTime: ${seckill.endTime.time}
        });
    })
</script>
</html>
