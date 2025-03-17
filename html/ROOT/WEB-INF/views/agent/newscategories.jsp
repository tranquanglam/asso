<%@ include file="/common/taglibs.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <ol class="breadcrumb">
            <li><a href="#"><fmt:message key="title.home_page"/></a></li>
            <li class="active"><span><fmt:message key="admin.agent.newscategory.title"/></span></li>
        </ol>

        <h1><fmt:message key="admin.agent.newscategory.title"/></h1>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="main-box clearfix">
            <header class="main-box-header clearfix hide">
                <h2><fmt:message key="admin.agent.newscategory.title"/></h2>
            </header>

            <div class="main-box-body clearfix">
                <div class="table-responsive">
                    <form:form commandName="bean" id="filterForm" class="form-inline"  role="form" action="/agent/categories/newscategories">

                        <div class="form-group col-md-4" style="padding-top: 10px">
                            <label style="margin-top: 10px" class="form-group col-md-3"><fmt:message key="admin.agent.category.title"/></label>
                            <form:select path="categoryid" cssClass="form-control col-md-5" items="${categoryDTOS}" itemValue="categoryid" itemLabel="name"/>
                            <button type="button" class="btn btn-success" id="bookingFilter" style="margin-left: 10px"><fmt:message key="title.filter"/></button>
                        </div>
                    </form:form>

                    <table id="newscategory_table" class="table table-hover">
                        <thead>
                        <tr>
                            <th class="no-sort"><fmt:message key="admin.agent.category.name"/></th>
                            <th class="no-sort"><fmt:message key="admin.agent.newstitle"/></th>
                            <th class="no-sort"><fmt:message key="admin.agent.category.type"/></th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>


        </div>
    </div>
</div> <!--end my tevent-->

