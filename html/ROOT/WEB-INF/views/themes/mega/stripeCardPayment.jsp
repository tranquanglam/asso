<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<link rel="stylesheet" href="/themes/mega/stripe-card-payment/global.css" />
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <form id="payment-form">
                <div id="card-element"><!--Stripe.js injects the Card Element--></div>
                <button id="submit">
                    <div class="spinner hidden" id="spinner"></div>
                    <span id="button-text">Pay</span>
                </button>
                <p id="card-error" role="alert"></p>
                <p class="result-message hidden">
                    Payment succeeded, see the result in your
                    <a href="" target="_blank">Stripe dashboard.</a> Refresh the page to pay again.
                </p>
            </form>
        </div>
    </div>
</div>
<div class="d-none" id="customerorderid">${booking.customerorderid}</div>
<div class="d-none" id="publishable-API-key">${clientId}</div>
<div class="d-none" id="API-clientSecret">${clientSecret}</div>
<script src="https://js.stripe.com/v3/"></script>
<script src="/themes/mega/stripe-card-payment/client.js" defer></script>
