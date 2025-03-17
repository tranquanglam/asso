<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="account-balance-container">
    <div class="my-4">
        <h2><fmt:message key="affiliate.program"/></h2>
    </div>
    <div class="card">
        <div class="card-body">
            <ul class="nav nav-tabs" id="affiliateTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="affiliateLinkCode-tab" data-bs-toggle="tab" data-bs-target="#affiliateLinkCode" type="button" role="tab" aria-controls="affiliateLinkCode" aria-selected="true">Linking Code</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="affiliateStats-tab" data-bs-toggle="tab" data-bs-target="#affiliateStats" type="button" role="tab" aria-controls="affiliateStats" aria-selected="false">Stats</button>
                </li>
            </ul>
            <div class="tab-content" id="affiliateTabContent">
                <div class="tab-pane fade show active" id="affiliateLinkCode" role="tabpanel" aria-labelledby="affiliateLinkCode-tab">
                    <div class="pt-10"></div>
                    <c:choose>
                        <c:when test="${affiliate == null}">
                            <div class="row">
                                <div class="col-md-6">
                                    <c:choose>
                                        <c:when test="${empty page.content}">
                                                <!-- Surtitle -->
                                                <h5 class="h5 mb-5 text-uppercase text-primary">
                                                    Get started
                                                </h5>
                                                <!-- Heading -->
                                                <h2 class="ls-tight font-bolder mb-5">
                                                    Sharing ${site.domain} and earn commission per paid order!
                                                </h2>
                                                <!-- Text -->
                                                <p class="lead text-muted">
                                                    By joining our affiliate program, you and us get to win and win
                                                </p>
                                        </c:when>
                                        <c:otherwise>
                                            ${page.content}
                                        </c:otherwise>
                                    </c:choose>
                                    <!-- List -->
                                    <ul class="list-unstyled mt-4 mb-0">
                                        <li class="py-2">
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <div class="icon icon-xs icon-shape bg-success text-white text-base rounded-circle me-3">
                                                        <i class="bi bi-check"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <span class="h6 font-semibold mb-0">*.**% earned for every new paid customer you refer.</span>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="py-2">
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <div class="icon icon-xs icon-shape bg-success text-white text-base rounded-circle me-3">
                                                        <i class="bi bi-check"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <span class="h6 font-semibold mb-0">Payouts are finalized and issued on the business day following the 1st and 15th of each month.</span>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="py-2">
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <div class="icon icon-xs icon-shape bg-success text-white text-base rounded-circle me-3">
                                                        <i class="bi bi-check"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <span class="h6 font-semibold mb-0">Your referral link below uniquely identifies your account. Use this code when linking to ${site.domain} and start earning today!</span>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-10 text-center bg-secondary text-white">
                                        <form method="post" action="/share/affiliate-program.html">
                                            <h3>Want the Affiliate Code?</h3>
                                            <button type="submit" class="btn btn-primary">Click to Accept Terms of Service</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <div class="col-md-12">
                                    <c:choose>
                                        <c:when test="${empty page.content}">
                                            <!-- Surtitle -->
                                            <h5 class="h5 mb-5 text-uppercase text-primary">
                                                Get started
                                            </h5>
                                            <!-- Heading -->
                                            <h2 class="ls-tight font-bolder mb-5">
                                                Sharing ${site.domain} and earn commission per paid order!
                                            </h2>
                                            <!-- Text -->
                                            <p class="lead text-muted">
                                                By joining our affiliate program, you and us get to win and win
                                            </p>
                                            <!-- List -->
                                        </c:when>
                                        <c:otherwise>
                                            ${page.content}
                                        </c:otherwise>
                                    </c:choose>
                                    <ul class="list-unstyled mt-4 mb-0">
                                        <li class="py-2">
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <div class="icon icon-xs icon-shape bg-success text-white text-base rounded-circle me-3">
                                                        <i class="bi bi-check"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <span class="h6 font-semibold mb-0"><fmt:formatNumber value="${affiliate.commissionrate * 100}"/>% earned for every new paid customer you refer.</span>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="py-2">
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <div class="icon icon-xs icon-shape bg-success text-white text-base rounded-circle me-3">
                                                        <i class="bi bi-check"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <span class="h6 font-semibold mb-0">Payouts are finalized and issued on the business day following the 1st and 15th of each month.</span>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="py-2">
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <div class="icon icon-xs icon-shape bg-success text-white text-base rounded-circle me-3">
                                                        <i class="bi bi-check"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <span class="h6 font-semibold mb-0">Your referral link below uniquely identifies your account. Use this code when linking to ${site.domain} and start earning today!</span>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-md-12">
                                    <div class="p-10 text-center bg-secondary text-white">
                                        <h3>Your linking url: https://${site.domain}/share/${affiliate.code}/products.html</h3>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="tab-pane fade" id="affiliateStats" role="tabpanel" aria-labelledby="affiliateStats-tab">
                    <div class="my-4">
                        <div class="card">
                            <div class="card-body">
                                <form id="transactionFilterForm" role="form" action="/share/affiliate-program/account-transaction.json">
                                    <div class="row">
                                        <div class="col-auto">
                                            <input type="text" class="form-control" name="fromDate" placeholder="from date" id="fromDate">
                                        </div>
                                        <div class="col-auto">
                                            <input type="text" class="form-control" name="toDate" placeholder="to date" id="toDate">
                                        </div>
                                        <div class="col-auto">
                                            <button type="button" class="btn btn-success" id="transactionFilter">Search</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table id="transactions_table" class="table table-hover w-100">
                            <thead class="table-light">
                            <tr>
                                <th>Transaction time</th>
                                <th>Credit</th>
                                <th>Ordernumber</th>
                                <th>Paymentid</th>
                                <th>Note</th>
                            </tr>
                            </thead>

                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
