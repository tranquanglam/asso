<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<div id="omnisearch" class="omnisearch">
    <div class="container">
        <!-- Search form -->
        <div class="omnisearch-form">
            <div class="form-group">
                <div class="input-group input-group-merge input-group-flush">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                    </div>
                    <input type="text" class="form-control" id="omnisearch-search-input" placeholder="Type ...">
                </div>
            </div>
        </div>
        <div class="omnisearch-suggestions">
            <h6 class="heading"><fmt:message key="label.search.suggestion"/></h6>
            <div class="row">
                <div class="col-12">
                    <ul class="list-unstyled mb-0" id="omnisearch-result">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="popup-cart-items" class="popup-cart-items">
    <div class="container">
        <div class="cart-items-container">
            <p class="heading h6"><fmt:message key="title.shopping-cart"/></p>
            <div class="row">
                <div class="col-12">
                    <div class="cart-item-list mb-0" id="cart-item-list">
                    </div>
                    <div class="mt-3 btn-checkout">
                        <div class="text-right">
                            <a href="/booking.html" class="btn btn-sm btn-primary btn-icon rounded-pill">
                                <span class="btn-inner--text"><fmt:message key="book-now"/></span>
                                <span class="btn-inner--icon"><i class="fas fa-long-arrow-alt-right"></i></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
