var Client = function Client() {
    this.authClient = null;
    this._setupAuth();
    this._setupEventHandlers();
}

Client.prototype._login = function _login() {
    sessionStorage.clear();
    var self = this;
    var username = $("#username").val();
    var password = $("#password").val();
    $.ajax({
        url: "/v0/oauth/token.json",
        method: "POST",
        dataType: "json",
        data : {
            'client_id' : username,
            'client_secret' : password,
            'grant_type' : 'password',
            'username' : username,
            'password' : password,
            'scope' : 'redeem'
        },
        beforeSend: function(xhr) {
            xhr.setRequestHeader("Authorization", "Basic " + $.base64.encode(username + ':' + password) );
            xhr.setRequestHeader("scope", "redeem");
        },
        statusCode: {
            200: function(response) {
                if (response.access_token === undefined || response.access_token == null) {
                    alert('Something went wrong');
                } else {
                    var expiredAt = new Date();
                    expiredAt.setSeconds(expiredAt.getSeconds() + response.expires_in);
                    self.authClient.login(response.access_token, response.expires_in);
                    sessionStorage.setItem('access_token', response.access_token);
                    sessionStorage.setItem('expires_in', response.expires_in);
                    sessionStorage.setItem('client_id', username);
                    sessionStorage.setItem('client_secret', password);
                    sessionStorage.setItem('refresh_token',response.refresh_token);
                }
                $('#loginFormModal').modal('hide');
            },
            401: function() {
                alert('Login failed');
            }
        }
    });
}

Client.prototype._logout = function _logout() {
    this.authClient.logout();
}
Client.prototype._getNews = function _getNews() {
    $("#newsListData").html('');
    var searchFilter = {};
    searchFilter.version = "1.0";
    searchFilter.level = 1;
    searchFilter.start = 0;
    searchFilter.length = 25;
    var newsEle = $('#newsTemplate').html();
    $.ajax({
        url: '/api/v0/news.json',
        type: 'POST',
        contentType: "application/json",
        data: JSON.stringify(searchFilter),
        dataType: "json",
        success: function(result) {
            if (result.totalRecords > 0) {
                var nn = result.news;
                for (var i = 0; i < nn.length; i++) {
                    var h = newsEle.replace('{title}',nn[i].title).replace('{title}',nn[i].title).replace('{code}',nn[i].code);
                    h = h.replace("{image}",nn[i].image1);
                    $("#newsListData").append(h);
                }
            }
        }
    })
}
Client.prototype._getProducts = function _getProducts() {
    $('#productListData').html('');
    var productEle = $('#productTemplate').html();
    var priceEle = $('#productPriceTemplate').html();
    var requestProduct = {};
    requestProduct.start = 0;
    requestProduct.length = 25;
    requestProduct.search = $("#inputSearch").val();
    requestProduct.categoryid = $("#categoryid").val();
    $.ajax({
        url: '/api/v0/dataProducts.json',
        type: "POST",
        dataType: "json",
        data: JSON.stringify(requestProduct),
        contentType: "application/json",
        success: function (result) {
            if (result.totalRecords > 0) {
                var products = result.products;
                for (var i = 0; i < products.length; i++) {
                    var producti = products[i];
                    var h = productEle.replace('{productid}',producti.productid).replace('{producttype}',producti.producttype).replace('{shortdescription}',producti.shortdescription);
                    h = h.replace("{image}",producti.image);
                    var prices = '';
                    var productprices = producti.productprices;
                    for (var j=0;j<productprices.length;j++) {
                        var oneItem = priceEle.replace('{name}',productprices[j].name).replace('{price}',productprices[j].price).replace('{productcode}',productprices[j].productcode);
                        prices += oneItem;
                    }
                    h = h.replace("{productprices}",prices);
                    $("#productListData").append(h);
                }
            }
        }
    });
}

Client.prototype._myprofile = function _myprofile() {
    $.ajax({
        url: '/api/v0/myprofile.json',
        type: 'POST',
        contentType: "application/json",
        dataType: "json",
        success: function(result) {
            $("#myprofileForm").find('input[name="email"]').val(result.email);
            $("#myprofileForm").find('input[name="phone"]').val(result.phone);
            $("#myprofileForm").find('input[name="firstName"]').val(result.firstName);
            $("#myprofileForm").find('input[name="lastName"]').val(result.lastName);
            $("#myprofileForm").find('input[name="countryCode"]').val(result.countryCode);
            $("#myprofileForm").find('input[name="memberID"]').val(result.memberID);
            $("#modal_myprofile").modal('show');
        }
    });
}
Client.prototype._updateMyprofile = function _updateMyprofile() {
    var requestMyprofile = {};
    requestMyprofile.email = $("#myprofileForm").find('input[name="email"]').val();
    requestMyprofile.phone = $("#myprofileForm").find('input[name="phone"]').val();
    requestMyprofile.firstName = $("#myprofileForm").find('input[name="firstName"]').val();
    requestMyprofile.lastName = $("#myprofileForm").find('input[name="lastName"]').val();
    requestMyprofile.countryCode = $("#myprofileForm").find('input[name="countryCode"]').val();
    $.ajax({
        url: '/api/v0/updateMyprofile.json',
        type: 'POST',
        data: JSON.stringify(requestMyprofile),
        contentType: "application/json",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("Authorization", "Bearer " + sessionStorage.getItem('access_token'));
        },
        success: function(result) {
            $("#modal_myprofile").modal('hide');
        }
    });
};
Client.prototype._mybooking = function _mybooking() {
    var requestMyBooking = {};
    requestMyBooking.version = "1.0";
    requestMyBooking.fromDate = '2019-03-01';
    requestMyBooking.toDate = '2030-05-01';
    var mybookingEle = $('#mybookingTemplate').html();
    var mybookingHeader = $('#mybookingHeader').html();
    $.ajax({
        url: '/api/v0/mybooking.json',
        type: 'POST',
        contentType: "application/json",
        data: JSON.stringify(requestMyBooking),
        dataType: "json",
        success: function(result) {
            if (result.totalRecords) {
                $("#mybookingData").html('');
                $("#mybookingData").append(mybookingHeader);
                for (var i=0; i< result.productorders.length; i++) {
                    var bookingI = result.productorders[i];
                    var bEle = mybookingEle.replace('{bookingnumber}',bookingI.ordernumber).replace('{bookingid}',bookingI.customerorderid).replace('{orderdate}',bookingI.orderdate);
                    /*bEle = bEle.replace('{adult}',bookingI.adult).replace('{child}',bookingI.child).replace('{guestName}',bookingI.guestName);*/
                    bEle = bEle.replace('{status}',bookingI.status).replace('{amount}',bookingI.amount);
                    $("#mybookingData").append(bEle);
                }
            } else {
                $("#mybookingData").html(result.errorMessage);
            }
        }
    });
};

Client.prototype._bookingdetails = function _bookingdetails() {
    var infoEle = $('#supplierbookinginfoTemplate').html();
    var bookingId = $('#supplierbookingnumber').html();
    if (bookingId.length < 1) return;
    $.ajax({
        url: '/api/v0/'+bookingId+'/mybooking.json',
        type: 'GET',
        contentType: "application/json",
        dataType: "json",
        success: function(result) {
            if (result.ordernumber) {
                var bEle = infoEle.replace('{bookingnumber}',result.ordernumber).replace('{checkin}',result.checkin).replace('{checkout}',result.checkout);
                bEle = bEle.replace('{adult}',result.adult).replace('{child}',result.child).replace('{guestName}',result.guestName);
                bEle = bEle.replace('{status}',result.status).replace('{amount}',result.amount);
                var rowTempalte = '<div class="row col-12">'
                    + '<div class="col-md-4">{roomrate}</div>'
                    + '<div class="col-md-4">{quantity}</div>'
                    + '<div class="col-md-4">{totalprice}</div>'
                    + '</div>';
                var bookingroomrates = rowTempalte;
                for (var i=0;i<result.products.length;i++) {
                    var rateI = result.products[i];
                    var rr = rowTempalte.replace('{roomrate}',rateI.productcode).replace('{quantity}',rateI.quantity).replace('{totalprice}',rateI.amount);
                    bookingroomrates += rr;
                }
                bEle = bEle.replace('{bookingroomrates}',bookingroomrates);
                $("#bookinginfo").html(bEle);
                if (result.status != 'CONFIRMED') {
                    $('.cancelbookingBtn').addClass('d-none');
                } else {
                    $('.cancelbookingBtn').removeClass('d-none');
                }
            } else {
                $("#bookinginfo").html(result.errorMessage);
            }
            $("#modal_supplierbookinginfo").modal('show');
        }
    });
}
Client.prototype._setupAuth = function _setupAuth() {
    var self = this;

    this.authClient = new jqOAuth({
        events: {
            login: function() {
                //alert("You are now authenticated.");
            },
            logout: function() {
                //alert("You are now logged out.");
            },
            tokenExpiration: function() {
                var username = sessionStorage.getItem("client_id");
                var password = sessionStorage.getItem("client_secret");
                $.ajax({
                    url: "/v0/oauth/token.json",
                    method: "POST",
                    dataType: "json",
                    data : {
                        'client_id' : username,
                        'client_secret' : password,
                        'grant_type' : 'refresh_token',
                        'refresh_token' : sessionStorage.getItem("refresh_token")
                    },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("Authorization", "Basic " + $.base64.encode(username + ':' + password) )
                        xhr.setRequestHeader("scope", "redeem")
                    },
                    statusCode: {
                        200: function(response) {
                            self.authClient.setAccessToken(response.access_token, response.expires_in);
                        },
                        401: function() {
                            alert('Login failed');
                        }
                    }
                });
            }
        }
    });

}

Client.prototype._setupEventHandlers = function _setupEventHandlers() {
    $("#submitLogin").click(this._login.bind(this));
    $("#logout").click(this._logout.bind(this));
    $("#listNews").click(this._getNews.bind(this));
    $("#listProducts").click(this._getProducts.bind(this));
    $("#myprofile").click(this._myprofile.bind(this));
    $('.saveMyprofileBtn').click(this._updateMyprofile.bind(this));
    $('#mybooking').click(this._mybooking.bind(this));
    $("#bookingnumber").click(this._bookingdetails.bind(this));
};


