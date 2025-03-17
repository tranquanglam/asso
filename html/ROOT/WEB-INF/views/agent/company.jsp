<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/common/taglibs.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <ol class="breadcrumb">
            <li><a href="#">Home</a></li>
            <li class="active"><span>Company</span></li>
        </ol>

        <h1>Edit Company</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="main-box">
            <header class="main-box-header clearfix">
                <h2>Company Information</h2>
            </header>

            <div class="main-box-body clearfix">
                <form:form method="post" id="formBean" commandName="formBean" class="form-horizontal" role="form"
                           enctype="multipart/form-data">

                    <div class="form-group">
                        <label for="pojo.name" class="col-lg-2 control-label">Name:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="pojo.name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pojo.address" class="col-lg-2 control-label">Address:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="pojo.address"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pojo.note" class="col-lg-2 control-label">Note:</label>

                        <div class="col-lg-10">
                            <form:textarea class="form-control" path="pojo.note"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">Logo:</label>

                        <div class="col-lg-10">
                            <img src="${formBean.pojo.logo}" height="100px">
                            <br/>
                            <br/>
                            <form:input type="file" path="logo"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label">Signature:</label>

                        <div class="col-lg-10">
                            <img src="${formBean.pojo.signature}" height="100px">
                            <br/>
                            <br/>
                            <form:input type="file" path="signature"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pojo.signaturename" class="col-lg-2 control-label">Name:</label>

                        <div class="col-lg-10">
                            <form:input type="text" class="form-control" path="pojo.signaturename"/>
                        </div>
                    </div>

                    <%--<div class="form-group">
                        <div class="col-lg-offset-2 col-lg-10">
                            <div class="checkbox-nice">
                                <form:checkbox path="agent.agentFlag" label="Is Agent?"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-10">
                            <div class="checkbox-nice">
                                <form:checkbox path="agent.supplierFlag" label="Is Supplier?"/>
                            </div>
                        </div>
                    </div>--%>


                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-10">
                            <button type="submit" class="btn btn-success">&nbsp;Save</button>
                        </div>
                    </div>

                </form:form>


            </div>
        </div>
    </div>
</div>

