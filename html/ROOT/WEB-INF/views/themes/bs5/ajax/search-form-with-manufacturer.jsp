<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="search-area bg-secondary">
    <div class="search-area-inner">
        <form action="/search.html" method="GET">
            <div class="row g-0">
                <input type="hidden" name="type" value="advance">
                <div class="col-md form-group b-right">
                    <input type="text" name="q" class="input-text search-fields" placeholder="Enter Keyword">
                </div>
                <div class="col-md form-group">
                    <select class="form-select form-select-lg search-fields advanced-search-state" name="state">
                        <option value="">--<fmt:message key="label.state"/>--</option>
                        <c:forEach items="${states}" var="st">
                            <option value="${st.code}" ${st.code eq state ? 'selected' : ''}>${st.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md form-group">
                    <select class="form-select form-select-lg search-fields advanced-search-city" name="city">
                        <option value="">--<fmt:message key="label.city"/>--</option>
                    </select>
                </div>
                <div class="col-md form-group">
                    <select class="form-select form-select-lg search-fields" name="caturl">
                        <option value="">-- <fmt:message key="label.categories"/> --</option>
                        <c:forEach items="${categories}" var="cat">
                            <option value="${cat.nameurl}" ${cat.nameurl eq caturl ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md form-group">
                    <button class="btn-search bg-gradient-primary text-white" type="submit">Search</button>
                </div>

            </div>
        </form>
    </div>
</div>
<div class="d-none">
    <div class="advanced-search-country-id">${country.countryid}</div>
</div>
