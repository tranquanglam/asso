<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="mt-2 mb-4">
    <div class="message-container">
        <div class="row mt-4">
        <div class="col-md-4">
            <h1><fmt:message key="label.my-messages"/> </h1>
        </div>
        <div class="col-md-8">
            <form:form id="myForm" cssClass="form-inline pull-right" action="/my/messages.html" method="post" commandName="mineBean">
                <div class="form-group">
                    <form:input  path="searchTerm" placeholder="email" maxlength="64" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-info"><span><fmt:message key="label.search"/> </span></button>
                </div>
                <form:hidden path="page" id="formPage"/>
            </form:form>
        </div>
        </div>
        <div class="box-table">
            <div class="table-responsive table-responsive-last">
                <table class="table table-borderless table-striped">
                    <thead class="blue">
                    <tr>
                        <th>Subject</th>
                        <th>To</th>
                        <th><fmt:message key="booking.status"/></th>
                        <th>Date</th>
                        <th>Retries</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${items.listResult}" var="em">
                        <tr>
                            <td>
                                    ${em.subject}
                            </td>
                            <td>${em.toaddresses}</td>
                            <td><div class="status ${em.statusText}">${em.statusText}</div></td>
                            <td>${em.sentdate}</td>
                            <td>${em.retries}</td>
                            <td>
                                <a href="#" onclick="javascript:showContent(${em.emailmessageid});">content</a>
                                <div class="d-none" id="content_${em.emailmessageid}">
                                    ${em.content}
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--  -->
        <ul class="pagination pull-right">
            <c:if test="${items.hasPrevious}">
                <li><a href="#"><i class="fa fa-play arrow-left"></i></a></li>
            </c:if>
            <c:forEach begin="1" end="${items.totalPages}" varStatus="loop">
                <li><a ${items.page eq loop.count?'class="current"':''} href="javascript:gotoPage(${loop.count})">${loop.count}</a></li>
            </c:forEach>
            <c:if test="${items.hasNext}">
                <li><a href="#"><i class="fa fa-play arrow-right"></i></a></li>
            </c:if>
        </ul>
    </div>
</div>
<div class="modal fade" id="messageContentModal" tabindex="-1" role="dialog"
     aria-labelledby="messageContentModalLabel">
    <div class="modal-dialog" role="document" style="width: 90%;max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="messageContentModalLabel">Content</h4>
            </div>
            <div class="modal-body">
                <div id="modal-message-content"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script language="JavaScript">
    function gotoPage(page) {
        $("#formPage").val(page);
        $("#myForm").submit();
    }
    function showContent(id) {
        var content = $("#content_"+id).html();
        $('#modal-message-content').html(content);
        $("#messageContentModal").modal('show');
    }
</script>