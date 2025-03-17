<%@ include file="/common/taglibs.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <ol class="breadcrumb">
            <li><a href="/"><fmt:message key="title.home_page"/></a></li>
            <li class="active"><span><fmt:message key="label.comments"/></span></li>
        </ol>

        <h1><fmt:message key="label.comments"/></h1>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="main-box clearfix">
            <header class="main-box-header clearfix">
                <c:if test="${param['q'] == null}">
                    <h2><fmt:message key="label.comments"/></h2>
                </c:if>
                <c:if test="${param['q'] != null}">
                    <h2>You are searching items of <strong>"${param['q']}"</strong></h2>
                </c:if>
            </header>

            <div class="main-box-body clearfix">
                <div class="table-responsive">
                    <table id="page_comments_table" class="table table-hover">
                        <thead>
                        <tr>
                            <th class="col-sm-2">Page ID</th>
                            <th class="col-sm-3"><fmt:message key="admin.agent.tevent_review.content"/></th>
                            <th class="col-sm-2"><fmt:message key="admin.agent.tevent_review.review_by"/></th>
                            <th class="col-sm-1"><fmt:message key="admin.agent.tevent_review.score"/></th>
                            <th class="col-sm-1"><fmt:message key="admin.agent.tevent_review.number_likes"/></th>
                            <th class="col-sm-1"><fmt:message key="admin.agent.tevent_review.number_dislikes"/></th>
                            <th class="col-sm-1"><fmt:message key="admin.agent.tevent_review.visible"/></th>
                            <th class="col-sm-1"></th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <form class="hide" id="commentFilterForm">
                <c:if test="${not empty param.pageid}">
                    <input type="hidden" name="pageid" value="${param.pageid}">
                </c:if>
            </form>
        </div>
    </div>
</div>
