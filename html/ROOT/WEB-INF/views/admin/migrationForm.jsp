<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <form method="post" class="form-horizontal" action="/admin/migration/sync-all-in-agent.html">
                <div class="form-group">
                    <label>Site Url</label>
                    <input class="form-control" name="siteurl" value="https://domain">
                </div>
                <div class="form-group">
                    <label>Company name</label>
                    <input class="form-control" name="companyname" value="">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Migrate all</button>
                </div>
            </form>
            <div class="mt-5 mb-5 bg-dark pt-1 pb-1"></div>
            <form method="post" class="form-horizontal" action="/admin/migration/pull-products.html">
                <div class="form-group">
                    <label>Site Url</label>
                    <input class="form-control" name="siteurl" value="">
                </div>
                <div class="form-group">
                    <label>clientid</label>
                    <input class="form-control" name="clientid" value="">
                </div>
                <div class="form-group">
                    <label>clientsecret</label>
                    <input class="form-control" name="clientsecret" value="">
                </div>
                <div class="form-group">
                    <label>brandid</label>
                    <input class="form-control" name="brandid" value="">
                </div>
                <div class="form-group">
                    <label>categoryid</label>
                    <input class="form-control" name="categoryid" value="">
                </div>
                <div class="form-group">
                    <label>toAgentid</label>
                    <input class="form-control" name="toAgentid" value="">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success">&nbsp;Pull products</button>
                </div>
            </form>
            <div class="mt-5 mb-5 bg-dark pt-1 pb-1"></div>
            <form method="post" class="form-horizontal" action="/admin/migration/copy-destinations.html">
                <div class="form-group">
                    <label>fromAgentid</label>
                    <input class="form-control" name="fromAgentid" value="">
                </div>
                <div class="form-group">
                    <label>toAgentid</label>
                    <input class="form-control" name="toAgentid" value="">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success">&nbsp;Copy destinations</button>
                </div>
            </form>
            <div class="mt-5 mb-5 bg-dark pt-1 pb-1"></div>
            <form method="post" class="form-horizontal" action="/admin/migration/copy-site.html">
                <div class="form-group">
                    <label>Domain hosting by this server</label>
                    <input class="form-control" name="domain" value="">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success">&nbsp;Copy this site</button>
                </div>
            </form>
        </div>
    </div>
</div>