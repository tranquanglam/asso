<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>Example - API</title>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" type="text/css" href="https://membooking.com/themes/loyalty/css/loyalty.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/md-tabs.css" />
    <link rel="stylesheet" type="text/css" href="/themes/mega/css/doctorcalendar.css" />
    <style>
        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 0 solid rgba(17,17,17,.125);
        }
        .card-badge-left {
            left: 0;
        }
        .card-badge {
            position: absolute;
            top: 1.25rem;
            z-index: 1;
        }
        .card > * {
            flex-shrink: 0;
        }
        .card-img {
            position: relative;
        }
        .card-img-hover {
            display: block;
        }
        .card-img-hover .card-img-back {
            opacity: 0;
        }
        .card-img-hover .card-img-top {
            transition: opacity .2s ease-in-out;
            width: 100%;
        }
        .card-img-hover .card-img-front {
            margin-left: -100%;
        }
        .card-img-hover > * {
            float: left;
        }
        .card-actions {
            position: absolute;
            bottom: 0;
            z-index: 1;
            width: 100%;
            display: flex;
            justify-content: center;
            padding: 1.25rem;
        }
        .card-actions .card-action {
            position: relative;
            top: 0;
            right: 0;
            left: 0;
            opacity: 0;
            transform: translateY(.5rem);
            transition: all .1s ease-in-out;
            transition-property: all;
            transition-property: transform,opacity;
            z-index: 1;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="modal fade" id="loginFormModal" role="dialog" tabindex="-1"
     aria-labelledby="loginFormModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top: 120px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="loginFormModalLabel">Log in</h4>
            </div>
            <div class="modal-body">
                <form name="loginForm" id="loginForm" action="" method="post" class="form-horizontal">
                    <fieldset>
                        <legend>
                            <h2>api Login</h2>
                        </legend>
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input id="username" name='username' class="form-control" type='text'/>
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" id="password" class="form-control" name='password'/>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </fieldset>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="submitLogin">Login</button>
            </div>
        </div>
    </div>
</div>
<div class="container mt-5">
    <ul class="nav nav-tabs md-tabs">
        <li class="nav-item"><a id="listNews" class="nav-link" href="#news-content" aria-controls="news-content" role="tab" data-toggle="tab"><strong class="text-uppercase">News</strong></a></li>
        <li class="nav-item"><a id="listProducts" class="nav-link" href="#products-content" aria-controls="products-content" role="tab" data-toggle="tab"><strong class="text-uppercase">Products</strong></a></li>
        <li class="nav-item"><a id="myprofile" class="nav-link" href="#myprofile-content" aria-controls="myprofile-content" role="tab" data-toggle="tab"><strong class="text-uppercase">My profile</strong></a></li>
        <li class="nav-item"><a id="supplierbooking" class="nav-link" href="#supplierbooking-content" aria-controls="myprofile-content" role="tab" data-toggle="tab"><strong class="text-uppercase">My supplier booking</strong></a></li>
    </ul>
    <div class="tab-content card pt-5">
        <div role="tabpanel" class="tab-pane fade active show group" id="news-content">
            <div class="row" id="newsListData">

            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade group" id="products-content">
            <div id="productListData" class="row">

            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade group" id="myprofile-content">
            <div class="row" id="myprofileData">

            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade group" id="supplierbooking-content">
            <div class="" id="mySupplierBookingData">

            </div>
        </div>
    </div>
</div>
<div id="modal_confirm_booking" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%; max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirm booking</h5>
            </div>
            <div class="modal-body">
                <div id="resultBooking">

                </div>
                <form id="bookingConfirmForm"></form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-main btn-next-tab-sm" id="confirmBookingBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
<div id="newsTemplate" class="d-none">
    <div class="col-sm-4">
        <figure class="mg-room">
            <img src="{image}" alt="{title}" class="img-responsive">
            <figcaption>
                <h2><a href="/blog/{code}">{title}</a></h2>
            </figcaption>
        </figure>
    </div>
</div>
<div class="d-none" id="productPriceTemplate">
    <div class="row">
        <div class="col">{name} : {price}</div>
        <div class="col">
            <input type="number" name="quantity" value="2" min="1" max="100" readonly>
        </div>
        <div class="col">
            <button class="btn btn-primary" onclick="orderProduct('{productcode}')">Order</button>
        </div>
    </div>
</div>
<div id="productTemplate" class="d-none">
    <div class="thumb col-md-4 col-sm-12">
        <div class="product-box" id="product-box_{productid}" numofbooking="0">
            <div class="image-wrapper">
                <img class="product__image" src="{image}" alt="..." width="200">
            </div>
            <div class="detail-wrapper">
                <h4 class="product-title">{producttype}</h4>
                <div>
                    {shortdescription}
                </div>
                <div>
                    {productprices}
                </div>
            </div>
        </div>
    </div>
</div>
<div id="sessionTemplate" class="d-none">
    <div class="col-md-1 col-3 col-sm-2 mt-2 pl-1 pr-1">
        <div class="border border-primary text-center doctorsession bg-{status}" data-productsessionid="{productsessionid}" onclick="bookme(this);">
            <div class="start-time pr-1">{starttime}</div>
            <div class="slot-number">
                {slotnumber}
            </div>
        </div>
    </div>
</div>
<div id="mybookingHeader" class="d-none">
    <div class="row" style="background-color: #f7c93a;padding: 10px; width: 100%">
        <div class="col-2">Booking No</div>
        <div class="col-2">Start date</div>
        <div class="col-2">End date</div>
        <div class="col-1">Adult</div>
        <div class="col-1">Child</div>
        <div class="col-1">Infant</div>
        <div class="col-1">Status</div>
        <div class="col-2 text-right">Amount</div>
    </div>
</div>
<div id="mybookingTemplate" class="d-none">
    <div class="row" style="padding: 10px;width: 100%">
        <div class="col-2"><a href="#" onclick="showBookinginfo('{bookingnumber}')">{bookingnumber}</a></div>
        <div class="col-2">{checkin}</div>
        <div class="col-2">{checkout}</div>
        <div class="col-1">{adult}</div>
        <div class="col-1">{child}</div>
        <div class="col-1">{infant}</div>
        <div class="col-1">{status}</div>
        <div class="col-2 text-right">{amount}</div>
    </div>
</div>
<div id="bookinginfoTemplate" class="d-none">
    <div class="row col-12" style="padding: 10px;">
        <div class="col-4"><strong>Booking No:</strong> {bookingnumber}</div>
        <div class="col-4"><strong>Check In:</strong> {checkin}</div>
        <div class="col-4"><strong>Check Out:</strong> {checkout}</div>
    </div>
    <div class="row col-12" style="padding: 10px;">
        <div class="col-3"><strong>Adult per room:</strong> {adult}</div>
        <div class="col-3"><strong>Child:</strong> {child}</div>
        <div class="col-3"><strong>Guest:</strong> {guestName}</div>
        <div class="col-3"><strong>Status:</strong> {status}</div>
    </div>

    <div class="row col-12" style="padding: 10px;">
        <div class="col-12 text-right"><strong>Total amount:</strong> {amount}</div>
    </div>
</div>
<div id="modal_bookinginfo" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%; max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Booking Information <span id="bookingnumber"></span></h5>
            </div>
            <div class="modal-body">
                <div id="bookinginfo">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary cancelbookingBtn">Cancel</button>
            </div>
        </div>
    </div>
</div>
<div id="modal_myprofile" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" style="width: 66%; max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">My Profile</h5>
            </div>
            <div class="modal-body">
                <form id="myprofileForm" action="" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label>Member ID</label>
                        <input name='memberID' class="form-control" type='text' readonly/>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input name='email' class="form-control" type='text'/>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input name='phone' class="form-control" type='text'/>
                    </div>
                    <div class="form-group">
                        <label>First Name</label>
                        <input name='firstName' class="form-control" type='text'/>
                    </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <input name='lastName' class="form-control" type='text'/>
                    </div>
                    <div class="form-group">
                        <label>Country Code</label>
                        <input name='countryCode' class="form-control" type='text'/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary saveMyprofileBtn">Save</button>
            </div>
        </div>
    </div>
</div>
<div id="supplierbookingHeader" class="d-none">
    <div class="row col-12" style="background-color: #f7c93a;padding: 10px;">
        <div class="col-2">Booking No</div>
        <div class="col-2">Order date</div>
        <div class="col-2">Status</div>
        <div class="col-2 text-right">Amount</div>
    </div>
</div>
<div id="supplierbookingTemplate" class="d-none">
    <div class="row col-12" style="padding: 10px;">
        <div class="col-2"><a href="#" onclick="showSupplierBookinginfo('{bookingid}')">{bookingnumber}</a></div>
        <div class="col-2">{orderdate}</div>
        <div class="col-2">{status}</div>
        <div class="col-2 text-right">{amount}</div>
    </div>
</div>
<div id="modal_supplierbookinginfo" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" style="width: 66%; max-width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Supplier Booking Information <span id="supplierbookingnumber"></span></h5>
            </div>
            <div class="modal-body">
                <div id="supplierbookinginfo">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary cancelbookingBtn">Cancel</button>
            </div>
        </div>
    </div>
</div>
<div id="supplierbookinginfoTemplate" class="d-none">
    <div class="row col-12" style="padding: 10px;">
        <div class="col-4"><strong>Booking No:</strong> {bookingnumber}</div>
        <div class="col-4"><strong>Check In:</strong> {checkin}</div>
        <div class="col-4"><strong>Check Out:</strong> {checkout}</div>
    </div>
    <div class="row col-12" style="padding: 10px;">
        <div class="col-3"><strong>Adult per room:</strong> {adult}</div>
        <div class="col-3"><strong>Child:</strong> {child}</div>
        <%--<div class="col-3"><strong>Guest:</strong> {guestName}</div>--%>
        <div class="col-3"><strong>Status:</strong> {status}</div>
    </div>
    <div class="row col-12" style="padding: 10px;">
        <div class="col-12"><strong>Guest:</strong> {guestName}</div>
    </div>
    <div class="row col-12" style="padding: 10px;">
        {bookingroomrates}
    </div>
    <div class="row col-12" style="padding: 10px;">
        <div class="col-12 text-right"><strong>Total amount:</strong> {amount}</div>
    </div>
    <div class="row col-12">
        {json}
    </div>
</div>
<script type="text/javascript" src="/themes/mega/js/popper.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/bootbox.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/jquery.base64.js"></script>
<script type="text/javascript" src="/themes/mega/js/store.modern.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/jquery.oauth.js"></script>
<script type="text/javascript" src="/themes/mega/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/themes/mega/js/supplier-client.js"></script>
<script>
    var client = new Client;
    $(document).ready(function() {
        client.authClient.logout();
        if (sessionStorage.getItem("access_token") === null || sessionStorage.getItem("access_token") == undefined) {
            $('#loginFormModal').modal('show');
        } else {
            var access_token = sessionStorage.getItem("access_token");
            var expires_in = sessionStorage.getItem("expires_in");
            client.authClient.login(access_token,expires_in);
        }
    });

    function bookme(ele) {
        console.log("Click slot number");
        if ($(ele).hasClass('bg-BOOKABLE_ON')) {
            var productsessionid = $(ele).data('productsessionid');
            var slotnumber = $(ele).find('.slot-number').html();
            var starttime = $(ele).find('.start-time').html();
            $('#sessionForm').find('input[name="productsessionid"]').val(productsessionid);
            $('#sessionModalLabel').find('.slotnumber').html(slotnumber);
            $('#sessionModalLabel').find('.starttime').html(starttime);
            $('#sessionModal').modal('show');
        }
    }

    function bookSessionSubmit() {
        client._bookSession();
    }

    function showSupplierBookinginfo(bookingnumber) {
        $("#supplierbookingnumber").html(bookingnumber);
        $("#supplierbookingnumber").trigger("click");
    }

</script>
</body>
</html>

