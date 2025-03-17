<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="container">
    <div class="row">
        <form class="form-horizontal" style="padding-top: 40px;padding-bottom: 40px;">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text">Query Transaction</span>
                </div>
                <input id="input-vpc-merch-txn-ref" name="vpc_MerchTxnRef" type="text" value="${param.code}" class="form-control"  placeholder="input transaction code">
                <div class="input-group-append">
                    <a class="btn btn-success" href="javascript:querydr()">Search</a>
                </div>
            </div>
        </form>
    </div>
    <div class="row">
        <div class="col-md-12 text-left">
            <div id="result">

            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function querydr() {
        $.post("${pageContext.request.contextPath}/${target}", {"vpc_MerchTxnRef": $('#input-vpc-merch-txn-ref').val()}, function(response){
            $("#result").html('');
            var eles = response.data.split('&');
            for (i=0;i<eles.length;i++) {
                $("#result").append(eles[i]).append('<br>');
            }
        });
    }
    $(document).ready(function() {
        if ($("#input-vpc-merch-txn-ref").val() != '') {
            querydr();
        }
    });
</script>