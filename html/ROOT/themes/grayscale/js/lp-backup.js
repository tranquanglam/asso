(function ($) {
    $.fn.imagesLoaded = function (callback) {
        var i, c = true, t = this, l = t.length;
        for (i = 0; i < l; i++) {
            if (this[i].tagName === "IMG") {
                c = (c && this[i].complete && this[i].height !== 0);
            }
        }
        if (c) {
            if (typeof callback === "function") {
                callback();
            }
        } else {
            setTimeout(function () {
                jQuery(t).imagesLoaded(callback);
            }, 200);
        }
    }
})(jQuery);

function CommonUtil() {
    var me = this;

    function ApiCallback(func, dynamic) {
        if (func !== null && func !== undefined && func !== "" && typeof func === 'function') {
            var args = [];
            for (var i = 1; i < arguments.length; i++)
                args.push(arguments[i]);
            func.apply(this, args)
        }
    }

    me.genUUID = function (p) {
        var c = 0, i;
        p = (typeof p === "string") ? p : "";
        do {
            i = p + c++;
        } while (document.getElementById(i) !== null);
        return i;
    };
    me.executeAjaxPost = function (url, data, optionCallback) {
        $.ajax({
            type: 'POST',
            url: url,
            dataType: "json",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (data) {
                ApiCallback(optionCallback.success, data);
            },
            error: function (data) {
                ApiCallback(optionCallback.error, data);
            }
        });
    };
    me.executeAjaxGet = function (url, data, optionCallback) {
        var queryString = Object.keys(data).map((key) => {
            return encodeURIComponent(key) + '=' + encodeURIComponent(data[key])
        }).join('&');
        $.ajax({
            type: 'GET',
            url: url + "?" + queryString,
            dataType: "json",
            contentType: "application/json",
            success: function (data) {
                ApiCallback(optionCallback.success, data);
            },
            error: function (data) {
                ApiCallback(optionCallback.error, data);
            }
        });
    };
    me.screen = {};
    me.screen.isMd = function () {
        if ($(window).width() >= 768) {
            return true;
        }
        return false;
    };
    me.screen.isXs = function () {
        if ($(window).width() < 576) {
            return true;
        }
        return false;
    };

}

var COMMON = new CommonUtil();

function SformComponent() {
    var me = this;
    this.renderLayout = function ($container, componentData) {
        var $component = me.generateComponentLayout(componentData);
        $container.append($component);
        $component.append(componentData.content);
        return $component;
    };
    this.generateComponentLayout = function (componentData) {
        var $component = $('<component category="' + componentData.category + '" componentType="' + componentData.componentType + '" componentId="' + componentData.componentId + '"></component>');
        $component.data("COMPONENT-DATA", componentData);

        return $component;
    };
    this.getSformData = function ($containercontent, sform) {
        var isValid = true;
        var sformData = {};
        var sformfieldDataArray = [];
        var datafields = sform.sformfields;
        $containercontent.removeClass('was-validated').addClass('was-validated');
        if (datafields != null && datafields.length > 0) {
            for (var i = 0; i < datafields.length; i++) {
                var fi = datafields[i];
                var sformfieldData = {};
                sformfieldData.tag = fi.tag;
                sformfieldData.fieldname = fi.fieldname;
                var tagname = fi.tag + '[name="' + fi.fieldname + '"]';
                if (fi.singlevalue) {
                    var $ele = $containercontent.find(tagname);
                    $ele.parent().find('.invalid-feedback').remove();
                    if (fi.tag == 'input') {
                        sformfieldData.type = $ele.attr('type');
                        if ($ele.attr('type') == 'checkbox' || $ele.attr('type') == 'radio') {
                            var elevalue = $ele.prop('checked') ? $ele.val() : '';
                            sformfieldData.value = elevalue;
                        } else {
                            sformfieldData.value = $ele.val();
                        }
                    } else {
                        sformfieldData.value = $ele.val();
                    }

                    //validate tag sformField
                    if (!sformfieldData.value) {
                        isValid = false;
                        if ($($ele.attr('required') == 'required')) {
                            var htmlInvalid = `<div class="invalid-feedback">\n` +
                                `      Vui lòng nhập ${$ele.attr('placeholder')}.\n` +
                                `    </div>`;
                            $ele.parent().append(htmlInvalid);
                        } else {
                            $($('.resource-action')[0]).append(`
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                              <strong>Error!</strong>.
                              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>`)
                        }
                    }
                } else {
                    var vs = [];
                    $containercontent.find(tagname).each(function () {
                        if (fi.tag == 'input') {
                            if ($(this).attr('type') == 'checkbox') {
                                var elevalue = $(this).prop('checked') ? $(this).val() : '';
                                vs.push(elevalue);
                            } else {
                                vs.push($(this).val());
                            }
                        } else {
                            vs.push($(this).val());
                        }
                    });
                    sformfieldData.values = vs;
                }

                sformfieldDataArray.push(sformfieldData);
            }
        }
        if (!isValid) {
            return null;
        }
        sformData.sformid = sform.sformid;
        sformData.code = sform.code;
        sformData.name = sform.name;
        sformData.data = sformfieldDataArray;
        sformData.content = $containercontent.html();
        return sformData;
    }
}

var SFORM_COMPONENT = new SformComponent();

function McContentComponent() {
    var me = this;
    this.generateComponentLayout = function (componentData) {
        var $component = $('<component category="' + componentData.category + '" componentType="' + componentData.componentType + '" componentId="' + componentData.componentId + '"></component>');
        $component.data("COMPONENT-DATA", componentData);

        return $component;
    };
    this.renderLayout = function ($container, componentData) {
        var $component = me.generateComponentLayout(componentData);
        $container.append($component);
        $component.append(componentData.printcontent);
        $component.find('.mc-container').attr('pid', componentData.pid);
        $component.find('.mc-container').find('.btn-mc-option').on('click', function () {
            var op = $(this).attr('data-option');
            $component.find('.mc-container').attr('op', op);
            var targetnum = $(this).attr('data-targetnum');
            if (targetnum != null && targetnum != '') {
                $component.find('.mc-container').removeClass('active');
                $('.cms-resource-item').find('.mc-container[ordernumber="' + targetnum + '"]').addClass('active animate__animated animate__fadeInRightBig');
                //TODO submit data
            }
        });
        return $component;
    };
}

var MC_CONTENT_COMPONENT = new McContentComponent();

function ShoppintCartComponent() {
    var me = this;
    var toastCart = null;

    var cartEleTemplate = '<div id="rate_{productcode}" class="border-top pt-2 pb-2">' +
        '<div class="row">' +
        '<div class="col-8">' +
        '   <div class="media align-items-center">' +
        '       <img src="{image}" class="me-2" alt="" width="60px">' +
        '       <div class="media-body"><div class="text-limit lh-100"><small class="font-weight-bold mb-0">{productname}</small></div>' +
        '       <div class="description lh-100"><small class="mb-0">{description}</small></div>' +
        '       <small class="text-muted">{quantity} x {price}</small></div>' +
        '   </div>' +
        '</div>' +
        '<div class="col-3"><small class="text-dark">{amount}đ</small></div>' +
        '<div class="col-1"><a href="javascript:void(0);" onclick="removePriceitem(\'{productcode}\')"><i class="bi bi-trash"></i></a></div>' +
        '</div>' +
        '</div>';

    var toastCartTemplate = '' +
        '       <div id="toastCart" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="10000">' +
        '            <div class="toast-header">' +
        '                <i class="bi bi-cart"></i>' +
        '                <strong class="me-auto">&nbsp;Giỏ hàng</strong>' +
        '                <small class="text-muted"></small>' +
        '                <button type="button" class="ms-2 mb-1 close" data-bs-dismiss="toast" aria-label="Close">' +
        '                    <span aria-hidden="true">&times;</span>' +
        '                </button>' +
        '            </div>' +
        '            <div class="toast-body" data-action="popup-cart-items-open" data-target="#popup-cart-items">' +
        '                Thêm vào giỏ hàng thành công' +
        '            </div>' +
        '        </div>'
    this.showModalResult = function () {
        if (toastCart == null) {
            var toastCartEl = document.getElementById('toastCart');
            if (toastCartEl == null) {
                var toastLayout = document.createElement('div');
                toastLayout.className = 'position-fixed top-0 end-0 p-3'
                toastLayout.innerHTML = toastCartTemplate;
                toastLayout.style.cssText = 'z-index: 110;';
                document.body.append(toastLayout);
                toastCartEl = document.getElementById('toastCart');
            }
            toastCart = bootstrap.Toast.getOrCreateInstance(toastCartEl);
        }
        toastCart.show();
    }

    this.updateCartWithResutl = function (result, isShowModal) {
        $("#cart-item-list").html('');
        var quantity = 0;
        if (result.products != null && result.products.length > 0) {
            for (var i = 0; i < result.products.length; i++) {
                var pi = result.products[i];
                quantity += pi.quantity;
                var ele = cartEleTemplate.replace('{productcode}', pi.productcode).replace('{productcode}', pi.productcode).replace('{productname}', pi.productname).replace('{amount}', pi.amount).replace('{quantity}', pi.quantity);
                ele = ele.replace('{image}', pi.image).replace('{price}', pi.price).replace('{description}', pi.description);
                $("#cart-item-list").append(ele);
            }
            $('.popup-cart-items .btn-checkout').addClass('show');
            if (isShowModal) {
                me.showModalResult();
            }
        } else {
            $('.popup-cart-items .btn-checkout').removeClass('show');
        }
        $("#cart-items-badge").attr('data-count', quantity);
    }

    this.updateCart = function () {
        $.ajax({
            url: '/ajax/cart.json',
            type: "GET",
            contentType: "application/json",
            success: function (result) {
                me.updateCartWithResutl(result);
            }
        });
    }
}

var SHOPPING_CART_COMPONENT = new ShoppintCartComponent();

function SupplierAccountService() {
    var me = this;
    this.isInitialize = function () {
        if ($('#supplierProductForm').length) {
            return true;
        }
        return false;
    };
    this.initialize = function () {
        if ($('#supplierProductForm').length) {
            me.initSupplierProductForm();
        }
        $('.select-country-code').on('change', function () {
            var countryid = $(this).val();
            $.ajax({
                url: '/ajax/findCitiesByCountry?countryid=' + countryid,
                type: 'GET',
                contentType: "application/json",
                success: function (result) {
                    $('.select-city-code').html('');
                    if (result.array.length > 0) {
                        var ctArray = result.array;
                        for (var i = 0; i < ctArray.length; i++) {
                            var $option = '<option value="' + ctArray[i].code + '">' + ctArray[i].name + '</option>';
                            $('.select-city-code').append($option);
                        }
                    }
                }
            });
        });
    };

    this.saveFormData = function (formid, callback) {
        var formData = $("#" + formid).serializeFormJSON();
        $.ajax({
            url: '/membershipRegisterStartup.json',
            type: 'POST',
            data: JSON.stringify(formData),
            contentType: "application/json",
            dataType: 'json',
            success: function (result) {
                callback();
            }
        });
    };

    this.initSupplierProductForm = function () {
        function initStep() {
            let urlParams = new URLSearchParams(window.location.search);
            let step = urlParams.get('step');
            if (step) {
                $('.form-step').removeClass('show');
                $('.step-' + step).addClass('show animate__animated animate__fadeInRightBig');
                checkShowBtns();
            } else {
                $('.form-step').removeClass('show');
                $('.step-one').addClass('show animate__animated animate__fadeInRightBig');
            }
        }

        function initDropzone() {
            if ($('#uploadDesktopLogo').length) {
                var myDropzone = new Dropzone("div#uploadDesktopLogo", {
                    url: "/membershipRegisterStartup/uploadLogo?action=uploadDesktopLogo",
                    uploadMultiple: false,
                });
            }

            if ($('#uploadMobileLogo').length) {
                var myDropzone = new Dropzone("div#uploadMobileLogo", {
                    url: "/membershipRegisterStartup/uploadLogo?action=uploadMobileLogo",
                    uploadMultiple: false,
                });
            }

            if ($('#uploadFavicon').length) {
                var myDropzone = new Dropzone("div#uploadFavicon", {
                    url: "/membershipRegisterStartup/uploadLogo?action=uploadFavicon",
                    uploadMultiple: false,
                });
            }
        }

        function checkShowBtns() {
            var nextstep = $('.form-step.show').attr('nextstep');
            if (nextstep != null && nextstep != '') {
                $('.btn-next').addClass('show');
            } else {
                $('.btn-next').removeClass('show');
            }
            var prevstep = $('.form-step.show').attr('prevstep');
            if (prevstep != null && prevstep != '') {
                $('.btn-back').addClass('show');
            } else {
                $('.btn-back').removeClass('show');
            }
        }

        initStep();
        checkShowBtns();
        initDropzone();

        $('.btn-back').on('click', function () {
            var prevstep = $('.form-step.show').attr('prevstep');
            if (prevstep != null && prevstep != '') {
                $('.form-step').removeClass('show');
                $('.step-' + prevstep).addClass('show animate__animated animate__fadeInLeftBig');
            }
            checkShowBtns();
        });
        $('.btn-next').on('click', function () {
            var nextstep = $('.form-step.show').attr('nextstep');
            if (nextstep != null && nextstep != '') {
                if (nextstep != 'submit') {
                    $('.form-step').removeClass('show');
                    $('.step-' + nextstep).addClass('show animate__animated animate__fadeInRightBig');
                    var formData = $("#supplierProductForm").serializeFormJSON();
                    me.saveFormData('supplierProductForm', function () {
                    });
                    checkShowBtns();
                } else {
                    me.saveFormData('supplierProductForm', function () {
                        $('.form-step').removeClass('show');
                        $('.step-thankyou').addClass('show animate__animated animate__fadeInRightBig');
                        checkShowBtns();
                    });
                }
            }
        });

        $('.js-site-color').on('input', function (e) {
            let currentTarget = $(e.currentTarget);
            let rootCss = currentTarget.data('root-css');
            if (rootCss) {
                document.documentElement.style.setProperty(rootCss, currentTarget.val());
            }
        });
    }
}

var SUPPLIER_ACCOUNT_SERVICE = new SupplierAccountService();

function BlogComponent() {
    var me = this;

    me.buildUID = function ($e) {
        var id = COMMON.genUUID("HEADING");
        $e.attr('id', id);
        return id;
    }

    function generateToc() {
        let htmlToc = '';
        htmlToc += `<ol id="blog-toc-list" class="level1 ">`;
        $(".blog-content").each(function () {
            $(this).find("h2").each(function () {
                var id = $(this).attr('id') || me.buildUID($(this));
                var text = $(this).text();

                htmlToc += '<li class="heading1"><a href="javascript:void(0)" data-action="scroll-to-element" data-target="' + id + '">' + text + '</a>';
                isLevel2 = false;
                isLevel3 = false;

                $(this).nextUntil("h2").each(function () {
                    var id2 = $(this).attr('id') || me.buildUID($(this));
                    var text2 = $(this).text();
                    let e = $(this);
                    if (e[0].localName === "h3") {
                        if (isLevel3) {
                            htmlToc += `</li></ol>`;
                            isLevel2 = false;
                        }
                        if (isLevel2) {
                            htmlToc += `</li>`;
                        }

                        if (!isLevel2) {
                            htmlToc += `<ol class="level2 ">`;
                            isLevel2 = true;
                        }
                        htmlToc += '<li class="heading2"><a href="javascript:void(0)" data-action="scroll-to-element" data-target="' + id2 + '">' + text2 + '</a>';
                    }
                    if (e[0].localName === "h4") {
                        if (!isLevel2) {
                            htmlToc += `<ol class="level2"><li class="heading2">`;
                            isLevel3 = false;
                        }
                        if (!isLevel3) {
                            htmlToc += `<ol class="level3 ">`;
                            isLevel3 = true;
                        }
                        htmlToc += '<li class="heading3"><a href="javascript:void(0)" data-action="scroll-to-element" data-target="' + id2 + '">' + text2 + '</a></li>';
                    }
                });

                if (isLevel3) {
                    htmlToc += `</a></ol>`;
                }

                if (isLevel2) {
                    htmlToc += `</a></li></ol>`;
                }

                htmlToc += "</a></li>";
            });
        });
        htmlToc += '</ol>';
        $('#blog-toc').html(htmlToc);
    }

    this.apiGetBlogs = function ($element, opt) {
        var ajaxurl = `/ajax/blogs-for-view.html?keyword=${opt.keyword}&maxSize=${opt.maxSize}`;
        $element.load(ajaxurl, function () {
            if (ENET_LEAD_SERVICE) {
                ENET_LEAD_SERVICE.generateSwiper();
            }
        });
    };

    this.renderLayout = function () {
        if ($('#blog-toc').length) {
            generateToc();
        }
        if ($('.enet-ajax-load-blogs').length) {
            $('.enet-ajax-load-blogs').each(function (i) {
                let keyword = $(this).data('enet-keyword');
                me.apiGetBlogs($(this), {'keyword': keyword, 'maxSize': 8});
            });
        }
    };

    this.isInitialize = function () {
        if ($('#blog-toc').length) {
            return true;
        }
        if ($('.enet-ajax-load-blogs').length) {
            return true;
        }
        return false;
    };
    this.init = function () {
        me.renderLayout();
    };
}

var BLOG_COMPONENT = new BlogComponent();

function CatelogueComponent() {
    var me = this;
    var mapLoadAjax = {};
    this.loadProductsByCat = function (cat, targetid) {
        if ($('#' + targetid).length) {
            var pmaxN = 12;
            var attMaxN = $('#' + targetid).attr('maxN');
            if (attMaxN != null && attMaxN != '') {
                pmaxN = parseInt(attMaxN);
            }
            var query = $('#' + targetid).attr('query');
            if (query == null) {
                query = '';
            }
            var showprice = $('#' + targetid).attr('showprice');
            if (showprice == null) {
                showprice = true;
            }
            var showcart = $('#' + targetid).attr('showcart');
            if (showcart == null) {
                showcart = true;
            }
            var col = $('#' + targetid).attr('col');
            if (col == null) {
                col = 2;
            }
            var colmd = $('#' + targetid).attr('colmd');
            if (colmd == null) {
                colmd = 4;
            }
            var swiper = $('#' + targetid).attr('swiper');
            if (swiper == null) {
                swiper = "";
            }
            var ajaxurl = '/ajax/' + pmaxN + '/products-for-view.html?query=' + query + '&cat=' + cat + '&showprice=' + showprice + '&showcart=' + showcart + '&col=' + col + '&colmd=' + colmd + '&targetid=' + targetid + '&swiper=' + swiper;
            $('#' + targetid).load(ajaxurl, function () {
                if (ENET_LEAD_SERVICE) {
                    ENET_LEAD_SERVICE.generateSwiper();
                }
            });
        }
    }
    this.generateLayout = function () {
        $('.catalogue.cat-link').on('click', function () {
            $('.catalogue.cat-link').removeClass('active');
            $(this).addClass('active');
            var cat = $(this).data('cat');
            var targetid = $(this).data('targetid');
            var collapseId = targetid.replace('ajax-products-by-cat-', 'collapse-');
            if ($('#' + collapseId).length > 0 && !$('#' + collapseId).hasClass('show')) {
                $('#' + collapseId).addClass('show')
            }
            if ($('#' + targetid).html() == 'empty' && mapLoadAjax[targetid] == undefined) {
                mapLoadAjax[targetid] = 'loading';
                me.loadProductsByCat(cat, targetid);
            }
        });

        if ($('.nav-tabs').has('.catalogue.cat-link').length > 0) {
            $('.nav-tabs').has('.catalogue.cat-link').each(function () {
                var $ele = $($(this).find('.catalogue.cat-link:first'));
                $ele.addClass('active');
                var cat = $ele.data('cat');
                var targetid = $ele.data('targetid');
                if ($('#' + targetid).html() == 'empty' && mapLoadAjax[targetid] == undefined) {
                    mapLoadAjax[targetid] = 'loading';
                    me.loadProductsByCat(cat, targetid);
                }
            });
        }

        $('.catalogue.cat-link-mobile').on('click', function () {
            $('.catalogue.cat-link-mobile').removeClass('active');
            $(this).addClass('active');
            var cat = $(this).data('cat');
            var targetid = $(this).data('targetid');
            if ($('#' + targetid).html() == 'empty' && mapLoadAjax[targetid] == undefined) {
                mapLoadAjax[targetid] = 'loading';
                me.loadProductsByCat(cat, targetid);
            }
        });
    };
    this.isInit = function () {
        if ($('.nav-tabs').has('.catalogue.cat-link').length > 0) {
            return true;
        }
        return false;
    };
    this.init = function () {
        me.generateLayout()
    };
}

var CATELOGUE_COMPONENT = new CatelogueComponent();

function CustomSectionComponent() {
    var me = this;
    this.renderLayout = function () {
        if ($('.ajax-custom-section-container').length) {
            $('.ajax-custom-section-container').each(function () {
                var view = $(this).attr('view');
                if (view == null) {
                    return;
                }
                var ajaxurl = '/ajax/custom/' + view + '.html';
                $(this).load(ajaxurl, function (response, status, xhr) {
                    me.processAfterload;
                });
            });
        }
    };
    this.processAfterload = function () {
    }
}

var CUSTOM_SECTION_COMPONENT = new CustomSectionComponent();

function BannerComponent() {
    var me = this;

    this.apiGetBanners = function ($element, opt) {
        var ajaxurl = `/ajax/banners-for-view.html?album=${opt.name}&type=${opt.type}&layout=${opt.layout}&caturl=${opt.caturl}`;
        $element.load(ajaxurl, function () {
            ENET_LEAD_SERVICE.generateSwiper();
        });
    };

    this.renderLayout = function () {
        if (COMMON.screen.isMd()) {
            $('.enet-ajax-load-banners.d-md-block').each(function (i) {
                var name = $(this).data('enet-album');
                var type = $(this).data('enet-type') || 'slide';
                var layout = $(this).data('enet-layout') || '';
                var caturl = $(this).data('enet-caturl') || '';
                me.apiGetBanners($(this), {'name': name, 'type': type, 'layout': layout, 'caturl': caturl});
            });
        }
        if (COMMON.screen.isXs()) {
            $('.enet-ajax-load-banners.d-xs-block').each(function (i) {
                var name = $(this).data('enet-album');
                var type = $(this).data('enet-type') || 'slide';
                var layout = $(this).data('enet-layout') || '';
                var caturl = $(this).data('enet-caturl') || '';
                me.apiGetBanners($(this), {'name': name, 'type': type, 'layout': layout, 'caturl': caturl});
            });
        }
    };

    this.isInitialize = function () {
        if ($('.enet-ajax-load-banners').length) {
            return true;
        }
        return false;
    };

    this.initialize = function () {
        me.renderLayout();
    };
}

var BANNER_COMPONENT = new BannerComponent();

function EnetLeadService() {
    var me = this;
    var SFORM_CONTAINER = null;
    var loadedCssMap = {};
    var loadedScriptMap = {};

    function loadScript(url, callback) {
        $.ajax({
            url: url,
            dataType: 'script',
            success: callback,
            async: true,
            cache: true
        });
    }

    function loadCss(css) {
        if (loadedCssMap[css] == undefined) {
            var styles = document.createElement('link');
            styles.rel = 'stylesheet';
            styles.type = 'text/css';
            styles.media = 'screen';
            styles.href = css;
            document.getElementsByTagName('head')[0].appendChild(styles);
            loadedCssMap[css] = 'loaded';
        }
    }

    this.generateSwiper = function () {
        function checkSwiper($this) {
            var $el = $this.find('.swiper-container')
            if ($el.hasClass('swiper-container-initialized')) {
                return false;
            }
            return true;
        }

        loadCss('/themes/grayscale/js/swiper/css/swiper.min.css');
        loadScript('/themes/grayscale/js/swiper/js/swiper.min.js', function () {
            var $swiperContainer = $(".swiper-js-container");
            if ($swiperContainer.length) {
                $swiperContainer.each(function (i, swiperContainer) {
                    if (checkSwiper($(swiperContainer))) {
                        _initSwiper($(swiperContainer));
                    }
                });
            }
        });

    };
    this.initialize = function (opt, callback) {
        _initLayout();
        if (opt.isswiper) {
            loadCss('/themes/grayscale/js/swiper/css/swiper.min.css');
            loadScript('/themes/grayscale/js/swiper/js/swiper.min.js', function () {
                var $swiperContainer = $(".swiper-js-container");
                if ($swiperContainer.length) {
                    $swiperContainer.each(function (i, swiperContainer) {
                        _initSwiper($(swiperContainer));
                    });
                }
            });
        }
        if (opt.issticky) {
            loadScript('/themes/grayscale/js/sticky/js/sticky.min.js', function () {
                _sticky();
            });
        }
        if (opt.omnisearch) {
            _initOnmisearch();
        }
        if (opt.navbarcollapse) {
            _initNavCollapse();
        }
        if (opt.oldheader) {
            _fixOldHeader();
        }
        if (opt.blogToc) {
            _initBlogToc();
        }
        if (opt.blogs) {
            _initBlogs();
        }
        if (opt.catalogue) {
            _initCatalogue();
        }
        if (opt.slideToggle) {
            _initSlideToggle();
        }
        if (opt.banners) {
            _initBanners();
        }
        if (opt.jarallax) {
            _initJaralax();
        }
        if (opt.fullPage) {
            _initFullPage();
        }
        _initLightbox();
        _initAnimation();
        var $subcribeContainer = $(".subcribe-container");
        if ($subcribeContainer.length) {
            $subcribeContainer.each(function (i, oneSubcribeContainer) {
                _initStoreLead($(oneSubcribeContainer));
            });
        }
        _initTooltip();
        _initCart();
        _initSupplierAccount();


        SFORM_CONTAINER = {};
        $('.sform-container').each(function () {
            var code = $(this).data('code');
            SFORM_CONTAINER[code] = $(this);
        });
        callback();
    };

    function _initCatalogue() {
        CATELOGUE_COMPONENT.init();
    }

    function _fixOldHeader() {
        $('a[data-toggle="dropdown"]').each(function (e) {
            if (!$(this).hasClass('nav-link')) {
                $(this).addClass('nav-link')
            }
        })

        var listGrid = [['ml-', 'ms-'], ['mr-', 'me-']];
        listGrid.forEach(function (prefix) {
            $("[class*='" + prefix[0] + "']").each(function (e) {
                var me = this;
                $(this).attr('class').split(' ').map(function (cls) {
                    if (cls.indexOf(prefix[0]) == 0) {
                        let newClass = cls.replace(prefix[0], prefix[1]);
                        $(me).removeClass(cls).addClass(newClass);
                    }
                });
            });
        });

        $('a[data-toggle="dropdown"]').each(function (e) {
            $(this).attr('data-bs-toggle', 'dropdown');
        });

        if ($('.header').length > 0) {
            if (!$('.header').hasClass('w-100')) {
                $($('.header')[0]).addClass('w-100');
            }
        }
    }

    function _initSwiper($this) {

        // Swiper elements

        var $el = $this.find('.swiper-container'),
            pagination = $this.find('.swiper-pagination'),
            navNext = $this.find('.swiper-button-next'),
            navPrev = $this.find('.swiper-button-prev');


        // Swiper options

        var effect = $el.data('swiper-effect') ? $el.data('swiper-effect') : 'slide',
            direction = $el.data('swiper-direction') ? $el.data('swiper-direction') : 'horizontal',
            initialSlide = $el.data('swiper-initial-slide') ? $el.data('swiper-initial-slide') : 0,
            autoHeight = $el.data('swiper-autoheight') ? $el.data('swiper-autoheight') : false,
            autoplay = $el.data('swiper-autoplay') ? $el.data('swiper-autoplay') : false,
            centeredSlides = $el.data('swiper-centered-slides') ? $el.data('swiper-centered-slides') : false,
            paginationType = $el.data('swiper-pagination-type') ? $el.data('swiper-pagination-type') : 'bullets';


        // Items per slide

        var items = $el.data('swiper-items');
        var itemsSm = $el.data('swiper-sm-items');
        var itemsMd = $el.data('swiper-md-items');
        var itemsLg = $el.data('swiper-lg-items');
        var itemsXl = $el.data('swiper-xl-items');

        // Items per slide

        var rowitems = $el.data('swiper-row-items');
        var rowitemsSm = $el.data('swiper-sm-row-items');
        var rowitemsMd = $el.data('swiper-md-row-items');
        var rowitemsLg = $el.data('swiper-lg-row-items');
        var rowitemsXl = $el.data('swiper-xl-row-items');


        // Space between items

        var spaceBetween = $el.data('swiper-space-between');
        var spaceBetweenSm = $el.data('swiper-sm-space-between');
        var spaceBetweenMd = $el.data('swiper-md-space-between');
        var spaceBetweenLg = $el.data('swiper-lg-space-between');
        var spaceBetweenXl = $el.data('swiper-xl-space-between');


        // Slides per view written in data attributes for adaptive resoutions

        rowitems = rowitems ? rowitems : 1;
        rowitemsSm = rowitemsSm ? rowitemsSm : rowitems;
        rowitemsMd = rowitemsMd ? rowitemsMd : rowitemsSm;
        rowitemsLg = rowitemsLg ? rowitemsLg : rowitemsMd;
        rowitemsXl = rowitemsXl ? rowitemsXl : rowitemsLg;

        items = items ? items : 1;
        itemsSm = itemsSm ? itemsSm : items;
        itemsMd = itemsMd ? itemsMd : itemsSm;
        itemsLg = itemsLg ? itemsLg : itemsMd;
        itemsXl = itemsXl ? itemsXl : itemsLg;


        // Space between slides written in data attributes for adaptive resoutions

        spaceBetween = !spaceBetween ? 0 : spaceBetween;
        spaceBetweenSm = !spaceBetweenSm ? spaceBetween : spaceBetweenSm;
        spaceBetweenMd = !spaceBetweenMd ? spaceBetweenSm : spaceBetweenMd;
        spaceBetweenLg = !spaceBetweenLg ? spaceBetweenMd : spaceBetweenLg;
        spaceBetweenXl = !spaceBetweenXl ? spaceBetweenLg : spaceBetweenXl;

        var $swiper = new Swiper($el, {
            loop: true,
            pagination: {
                el: pagination,
                clickable: true,
                type: paginationType
            },
            navigation: {
                nextEl: navNext,
                prevEl: navPrev,
            },
            slidesPerView: items,
            spaceBetween: spaceBetween,
            initialSlide: initialSlide,
            autoHeight: autoHeight,
            centeredSlides: centeredSlides,
            mousewheel: false,
            keyboard: {
                enabled: true,
                onlyInViewport: false,
            },
            grabCursor: true,
            autoplay: autoplay,
            effect: effect,
            coverflowEffect: {
                rotate: 10,
                stretch: 0,
                depth: 50,
                modifier: 3,
                slideShadows: false
            },
            speed: 800,
            direction: direction,
            preventClicks: true,
            preventClicksPropagation: true,
            observer: true,
            observeParents: true,
            breakpointsInverse: true,
            breakpoints: {
                575: {
                    slidesPerView: itemsSm,
                    slidesPerColumn: rowitemsSm,
                    spaceBetweenSlides: spaceBetweenSm
                },
                767: {
                    slidesPerView: itemsMd,
                    slidesPerColumn: rowitemsMd,
                    spaceBetweenSlides: spaceBetweenMd
                },
                991: {
                    slidesPerView: itemsLg,
                    slidesPerColumn: rowitemsLg,
                    spaceBetweenSlides: spaceBetweenLg
                },
                1199: {
                    slidesPerView: itemsXl,
                    slidesPerColumn: rowitemsXl,
                    spaceBetweenSlides: spaceBetweenXl
                }
            }
        });
    }

    function _initSlideToggle() {
        function toggle() {
            if ($('[data-action="slide-toggle"]').length) {
                if ($(window).width() > 768) {
                    $('[data-action="slide-toggle"]').each(function (i, el) {
                        let target = $(this).data('target');
                        $('#' + target).slideToggle('high');
                    });
                }
            }
        }

        function categorySubMenuToggle() {
            $('.categories_menu_toggle li.menu_item_children > a').on('click', function () {
                if ($(window).width() < 991) {
                    $(this).removeAttr('href');
                    var element = $(this).parent('li');
                    if (element.hasClass('open')) {
                        element.removeClass('open');
                        element.find('li').removeClass('open');
                        element.find('ul').slideUp();
                    } else {
                        element.addClass('open');
                        element.children('ul').slideDown();
                        element.siblings('li').children('ul').slideUp();
                        element.siblings('li').removeClass('open');
                        element.siblings('li').find('li').removeClass('open');
                        element.siblings('li').find('ul').slideUp();
                    }
                }
            });
            $('.categories_menu_toggle li.menu_item_children > a').append('<span class="expand"></span>');
        }

        function calHeightCategoryMenu() {
            function calHeight() {
                if ($(window).width() > 768) {
                    let height = $('.categories_content').height();
                    let categories_title_height = $('.categories_title').height();
                    let categories_menu_toggle_height = (height - categories_title_height) < 500 ? 500 : (height - categories_title_height)
                    $('.categories_menu_toggle').css('height', categories_menu_toggle_height);
                    if ($('.categories_menu_toggle ul:first').length) {
                        let lengthLi = $('.categories_menu_toggle ul:first').children().length;
                        let newHeight = (height - categories_title_height) / lengthLi - (2 / lengthLi);
                        //$('.categories_menu_toggle ul:first').children().css('height', newHeight > 50 ? newHeight : 50);
                        $('.categories_menu_toggle ul:first').children().find('a.menu_item_children__1').css('line-height', newHeight + 'px');
                        $('.categories_menu_toggle ul:first').children().find('a.menu_item_children__1 i').css('line-height', newHeight + 'px');
                    }
                }
            }

            var interval = setInterval(function () {
                let height = $('.categories_content').height();
                let categories_title_height = $('.categories_title').height();
                let categories_menu_toggle = $('.categories_menu_toggle').height();
                if (height != (categories_title_height + categories_menu_toggle)) {
                    calHeight();
                } else {
                    console.log('clearInterval');
                    //toggle();
                    clearInterval(interval);
                }
            }, 500);
        }

        categorySubMenuToggle();
        calHeightCategoryMenu();
    }

    function _initFullPage() {
        var pageHeight = window.innerHeight;
        var isAnimating = false;
        var listSection = $('section');
        var index = 0;

        document.body.style.transform = 'translate3d(0px,0px,0px)';
        document.body.style.transition = 'all 700ms ease 0s';
        //transition: all 700ms ease 0s;


        document.addEventListener('scroll', function (e) {
            document.body.scrollTop = 0;
        });
        document.addEventListener('wheel', wheelListener);

        function getListSection() {
            listSection = $('section');
        }

        function wheelListenerIndex(e) {
            if (e.deltaY > 0) {
                scrollPage(-pageHeight);
            } else {
                scrollPage(+pageHeight);
            }
        }

        function wheelListener(e) {
            if (e.deltaY > 0) {
                scrollPage(-pageHeight);
            } else {
                scrollPage(+pageHeight);
            }
        }

        function scrollPage(scrollSize) {
            console.log('scrollPage', scrollSize);
            console.log('isAnimating', isAnimating);
            if (isAnimating) {
                var yPos = -listSection[index].offsetTop;
                document.body.style.transform = 'translate3d(0px,' + yPos + 'px,0px)';
                return;
            }
            isAnimating = true;

            if (scrollSize > 0) {
                if (index > 0) index--;
            } else {
                if (index < listSection.length - 1) index++;
            }
            console.log('index', index);
            var yPos = -listSection[index].offsetTop;
            console.log('yPos', yPos);
            document.body.style.transform = 'translate3d(0px,' + yPos + 'px,0px)';
            setTimeout(function () {
                isAnimating = false;
            }, 700);
        }

        function getNewYPos(add) {
            var oldYPos = document.body.style.transform.split(',')[1];
            oldYPos = parseInt(oldYPos.replace(/px/, ''));
            var newYPos = oldYPos + add;
            if (newYPos > 0) {
                isAnimating = false;
            }
            return Math.min(0, newYPos) + 'px';
        }

        getListSection();

        document.body.addEventListener('transitionend', function () {
            setTimeout(function () {
                isAnimating = false;
            }, 700);
            document.addEventListener('wheel', wheelListener);
        })
    }

    function _initTooltip() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
    }

    function _initSupplierAccount() {
        if (SUPPLIER_ACCOUNT_SERVICE.isInitialize()) {
            loadCss('/themes/mega/css/dropzone.min.css');
            loadScript('/themes/mega/js/dropzone.min.js', function () {
                Dropzone.autoDiscover = false;
                loadScript('/themes/mega/js/jquery.validate.min.js', function (res) {
                    SUPPLIER_ACCOUNT_SERVICE.initialize();
                });
            });

        }
    }

    function _initStoreLead($subcribeContainer) {
        var $btnSubscribe = $subcribeContainer.find('.btn-subscribe-email');
        $btnSubscribe.on('click', function () {
            var $inputEmail = $subcribeContainer.find('.input-email');
            if ($inputEmail.length && $inputEmail.val().length > 6) {
                var subscribeReq = {};
                subscribeReq.inputEmail = $inputEmail.first().val();
                subscribeReq.comment = 'subcribe';
                if (me.validateEmail(subscribeReq.inputEmail)) {
                    $.ajax({
                        url: '/ajax/subscribe.json',
                        type: "POST",
                        data: JSON.stringify(subscribeReq),
                        dataType: "json",
                        contentType: "application/json",
                        success: function (result) {
                            if (result.errorCode == null) {
                                $subcribeContainer.html('Thank you for your information');
                            }
                        }
                    });
                } else {
                    console.log("invalid email");
                }
            }
        });
    }

    function _initCart() {
        SHOPPING_CART_COMPONENT.updateCart();
    }

    function _initBlogToc() {
        BLOG_COMPONENT.init();
    }

    function _initBlogs() {
        BLOG_COMPONENT.init();
    }

    function _initBanners() {
        BANNER_COMPONENT.initialize();
    }

    function _initAnimation() {
        function scrollTrigger(selector, options = {}) {
            let els = document.querySelectorAll(selector)
            els = Array.from(els)
            els.forEach(el => {
                addObserver(el, options)
            })
        }

        function addObserver(el, options) {
            let observer = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add(entry.target.dataset['enetAnimationtype']);
                        observer.unobserve(entry.target)
                    }
                })
            }, options)
            observer.observe(el)
        }

        $('.animate__animated').each(function (i) {
            var isNotAnimationTypes = ['animate__animated', 'animate__infinite']
            let $element = $($('.animate__animated')[i]);
            let arr = $element.attr('class').split(' ');
            arr.forEach(function (classItem) {
                if (!isNotAnimationTypes.includes(classItem) && classItem.indexOf("animate__") >= 0) {
                    $element.attr('data-enet-animationtype', classItem);
                    $element.removeClass(classItem);
                }
            });
        });

        scrollTrigger('.animate__animated');
    }

    function _sticky() {
        //
        // Variables
        //

        var $sticky = $('[data-toggle="sticky"]');


        //
        // Methods
        //

        function init($this) {

            var offset = $this.data('sticky-offset') ? $this.data('sticky-offset') : 0;
            var options = {
                'offset_top': offset
            };

            if ($(window).width() > 1000) {
                $this.stick_in_parent(options);
            } else {
                $this.trigger("sticky_kit:detach");
            }
        }


        //
        // Events
        //

        $(window).on('load resize', function () {
            if ($sticky.length) {
                // Init selects
                $sticky.each(function () {
                    init($(this));
                });
            }
        })

    }

    function _initLightbox() {
        loadScript('/themes/grayscale/js/bs5-lightbox.min.js', function () {
            console.log('loadScript lightbox');
        });
    }

    function _dropdown() {
        // Variables
        debugger;
        var $dropdown = $('.dropdown-animate'),
            $dropdownSubmenu = $('.dropdown-submenu [data-toggle="dropdown"]');


        // Methods

        function hideDropdown($this) {

        }

        function initSubmenu($this) {
            if (!$this.next().hasClass('show')) {
                $this.parents('.dropdown-menu').first().find('.show').removeClass("show");
            }

            var $submenu = $this.next(".dropdown-menu");

            $submenu.toggleClass('show');
            $submenu.parent().toggleClass('show');

            $this.parents('.nav-item.dropdown.show').on('hidden.bs.dropdown', function (e) {
                $('.dropdown-submenu .show').removeClass("show");
            });
        }

        // Events

        if ($dropdown.length) {
            $dropdown.on({
                'hide.bs.dropdown': function () {
                    hideDropdown($dropdown);
                }
            })
        }

        if ($dropdownSubmenu.length) {
            $dropdownSubmenu.on('click', function (e) {

                initSubmenu($(this))

                return false;
            });
        }

    }

    function _initOnmisearch() {
        function searchLdealItems() {
            var tempLi = '<li class="py-2"><a class="list-link" href="{link}"><i class="bi bi-search"></i> <span>{name}</span> <span class="price">{price}</span> </a> </li>';
            $("#omnisearch-result").html('');
            var searchRequest = {};
            searchRequest.start = 0;
            searchRequest.length = 3;
            searchRequest.search = $("#omnisearch-search-input").val();
            $.ajax({
                url: '/api/v0/dataProducts.json',
                type: 'POST',
                dataType: "json",
                data: JSON.stringify(searchRequest),
                contentType: "application/json",
                success: function (result) {
                    if (result.totalRecords > 0) {
                        var items = result.products;
                        for (var i = 0; i < items.length; i++) {
                            var item = items[i];
                            var h = tempLi.replace('{name}', item.name);
                            h = h.replace('{currency}', item.currency).replace('{price}', item.price);
                            var link = '/' + item.code + '.html';
                            h = h.replace('{link}', link);

                            $("#omnisearch-result").append(h);
                        }
                    }
                }
            });
        }

        $('#omnisearch-search-input').on('input', function (e) {
            e.preventDefault();
            searchLdealItems();
        });
        $('.omnisearch-container .omnisearch-search-input').on('focus', function () {
            $('.omnisearch-container .omnisearch-suggestions').addClass('show');
        });
        $('.omnisearch-container .omnisearch-search-input').on('blur', function () {
            if ($('.omnisearch-container .omnisearch-suggestions.show').length) {
                var isHover = false;
                $('.omnisearch-result .list-link').each(function () {
                    if ($(this).is(':hover')) {
                        isHover = true;
                    }
                });
                if (!isHover) {
                    $('.omnisearch-container .omnisearch-suggestions').removeClass('show');
                }
            }
        });
    }

    function _initNavCollapse() {

        // Variables

        var $nav = $('#navbar-main'),
            $collapse = $('#navbar-main-collapse'),
            $navTop = $('#navbar-top-main');


        // Methods

        function showNavbarCollapse($this) {
            $nav.addClass('navbar-collapsed');
            $navTop.addClass('navbar-collapsed');
            $('#header-main').addClass('header-collapse-show')
        }

        function hideNavbarCollapse($this) {
            $this.removeClass('collapsing').addClass('collapsing-out');
            $nav.removeClass('navbar-collapsed').addClass('navbar-collapsed-out');
            $navTop.removeClass('navbar-collapsed').addClass('navbar-collapsed-out');
        }

        function hiddenNavbarCollapse($this) {
            $this.removeClass('collapsing-out');
            $nav.removeClass('navbar-collapsed-out');
            $navTop.removeClass('navbar-collapsed-out');
            $('#header-main').removeClass('header-collapse-show')
        }


        // Events

        if ($collapse.length) {
            $collapse.on({
                'show.bs.collapse': function () {
                    showNavbarCollapse($collapse);
                }
            })

            $collapse.on({
                'hide.bs.collapse': function () {
                    hideNavbarCollapse($collapse);
                }
            })

            $collapse.on({
                'hidden.bs.collapse': function () {
                    hiddenNavbarCollapse($collapse);
                }
            })
        }
    }

    function _initLayout() {
        $('.banner-link').on('click', function () {
            var link = $(this).data('link');
            if (link != '' && link.length > 0) {
                window.location = link;
            }
        });

        $("body").on("click", "[data-action]", function (e) {

            e.preventDefault();

            var $this = $(this);
            var action = $this.data('action');
            var target = $this.data('target');

            switch (action) {
                case "offcanvas-open":
                    target = $this.data("target"), $(target).addClass("open"), $("body").append('<div class="body-backdrop" data-action="offcanvas-close" data-target=' + target + " />");
                    break;

                case "offcanvas-close":
                    target = $this.data("target"), $(target).removeClass("open"), $("body").find(".body-backdrop").remove();
                    break;

                case 'aside-open':
                    debugger;
                    target = $this.data('target');
                    $this.addClass('active');
                    $(target).addClass('show');
                    $('body').append('<div class="mask-body mask-body-light" data-action="aside-close" data-target=' + target + ' />');
                    break;

                case 'aside-close':
                    debugger;
                    target = $this.data('target');
                    $this.removeClass('active');
                    $(target).removeClass('show');
                    $('body').find('.body-backdrop').remove();
                    break;

                case 'omnisearch-open':
                    target = $this.data('target');
                    $this.addClass('active');
                    $(target).addClass('show');
                    $(target).find('.form-control').focus();
                    $('body').addClass('omnisearch-open').append('<div class="mask-body mask-body-dark" data-action="omnisearch-close" data-target="' + target + '" />');
                    break;

                case 'omnisearch-close':
                    target = $this.data('target');
                    $('[data-action="search-open"]').removeClass('active');
                    $(target).removeClass('show');
                    $('body').removeClass('omnisearch-open').find('.mask-body').remove();
                    break;

                case 'search-open':
                    target = $this.data('target');
                    $this.addClass('active');
                    $(target).addClass('show');
                    $(target).find('.form-control').focus();
                    break;

                case 'search-close':
                    target = $this.data('target');
                    $('[data-action="search-open"]').removeClass('active');
                    $(target).removeClass('show');
                    break;

                case 'sidenav-pin':
                    pinSidenav($this);
                    break;

                case 'sidenav-unpin':
                    unpinSidenav($this);
                    break;
                case 'popup-cart-items-open':
                    target = $this.data('target');
                    $this.addClass('active');
                    $(target).addClass('show');
                    $('body').addClass('popup-cart-items-open').append('<div class="mask-body mask-body-dark" data-action="popup-cart-items-close" data-target="' + target + '" />');
                    break;

                case 'popup-cart-items-close':
                    target = $this.data('target');
                    $(target).removeClass('show');
                    $('body').removeClass('popup-cart-items-open').find('.mask-body').remove();
                    break;

                case 'back-to-top':
                    $("html, body").animate({
                        scrollTop: 0
                    }, 700);
                    break;

                case 'scroll-to-element':
                    target = $this.data('target');
                    let top = $('#' + target).offset().top - $('#header-main').height();
                    $("html, body").animate({
                        scrollTop: top
                    }, 100);
                    break;
                case 'slide-toggle':
                    target = $this.data('target');
                    $this.toggleClass('active');
                    $('#' + target).slideToggle('medium');
                    break;
            }
        })

        if ($('[data-offset-top]').length && $('.header.header-transparent').length) {
            var $el = $('[data-offset-top]'),
                $offsetEl = $($el.data('offset-top')),
                offset = $offsetEl.height();


            $el.css({'padding-top': offset + 'px'})
        }
    }

    function _initJaralax() {
        loadCss('/themes/grayscale/js/jarallax/css/jarallax.css')
        loadScript('/themes/grayscale/js/jarallax/js/jarallax.min.js', function () {
            loadScript('/themes/grayscale/js/jarallax/js/jarallax-video.min.js', function () {
                console.log('loadScript jarallax');
                jarallax(document.querySelectorAll(".jarallax"));
            });
        });
    }

    this.validateEmail = function (email) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    };

    this.viewSformResource = function (resourceData, storeDataSubmitFunc) {
        var sformCode = "sform-" + resourceData.resourceId + "";
        var $resourceContent = SFORM_CONTAINER[sformCode].find('.resource-item-content[resourceId="' + resourceData.resourceId + '"]');
        if ($resourceContent.length == 0) {
            $resourceContent = $('<div class="resource-item-content active" resourceId="' + resourceData.resourceId + '">' +
                '<div class="resource-content-display"></div>' +
                '<div class="resource-action"></div>' +
                '</div>');
            SFORM_CONTAINER[sformCode].append($resourceContent);
            var $resourceItem = $resourceContent.find('.resource-content-display');
            me.renderLayout($resourceItem, resourceData, {
                onCompletedFunc: function () {
                }, onInteractFunc: function () {
                }
            });
            var footer = $resourceContent.find('.resource-action');
            if ($resourceContent.find('.btn-submit-sform').length == 0) {
                footer.append('<span class="btn btn-primary btn-submit-sform ml-2 me-2">Submit</span>');
            }
            if (resourceData.resourceComponents && resourceData.resourceComponents.length > 1) {
                footer.append('<span class="btn btn-secondary btn-skip-sform ml-2 me-2">Skip</span>');
            }
            $resourceContent.find('.btn-submit-sform').click(function () {
                me.submitSform($resourceItem, function (sformData) {
                    sformData.sformid = resourceData.sformid;
                    var passageResult = {};
                    passageResult['servicenumber'] = window.location.pathname;
                    if ($resourceContent.find('.mc-container').length) {
                        $resourceContent.find('.mc-container').each(function () {
                            var ordernumber = 'Q' + $(this).attr('ordernumber');
                            var op = $(this).attr('op');
                            if (op != undefined) {
                                var txt = $(this).find('.btn-mc-option[data-option="' + op + '"]').find('.mc-option-text').html();
                                passageResult[ordernumber] = op + ': ' + txt;
                            }
                        });
                    }
                    sformData.passageResult = passageResult;
                    storeDataSubmitFunc(sformData);
                })
            });
            footer.find('.btn-skip-sform').click(function () {

            });
            $resourceContent.append(footer);
        }

        SFORM_CONTAINER[sformCode].find('.resource-item-content.active').removeClass("active");
        $resourceContent.addClass("active");
    };

    this.renderLayout = function ($resourceItem, resourceData, params) {
        $resourceItem.addClass("cms-resource-item");
        $resourceItem.attr("resourceId", resourceData.resourceId);
        $resourceItem.data("RESOURCE-DATA", resourceData);

        for (var i = 0; i < resourceData.resourceComponents.length; i++) {
            var componentData = resourceData.resourceComponents[i];
            if (componentData.componentType == 'sform') {
                SFORM_COMPONENT.renderLayout($resourceItem, componentData);
            } else if (componentData.componentType == 'mc') {
                MC_CONTENT_COMPONENT.renderLayout($resourceItem, componentData);
            }
        }

        if (resourceData.resourceComponents.length > 1) {
            $resourceItem.find('.mc-container').first().addClass('active');
        }


        if (params.onCompletedFunc != null) {
            params.onCompletedFunc();
        }
    };

    this.submitSform = function ($resourceItem, callback) {
        var sformData = null;
        $resourceItem.find('component').each(function (idx, component) {
            var componentData = $(component).data("COMPONENT-DATA");
            if (componentData.componentType == 'sform') {
                sformData = SFORM_COMPONENT.getSformData($(component), componentData);
            }
        });
        if (sformData != null && callback != null) {
            callback(sformData);
        }
    };

    this.showSform = function (code) {
        $.ajax({
            url: '/sform/' + code + '/get-sform.json',
            type: "GET",
            contentType: "application/json",
            success: function (resourceData) {
                if (resourceData.resourceId != '0') {
                    me.viewSformResource(resourceData, function (sformData) {
                        _storeSform(sformData);
                    });
                }
            }
        });
    };

    function _showSformModal(text) {
        if ($('.sform-alert-modal').length > 0) {
            $('.sform-alert-modal').modal('show');
        } else {
            window.alert(text);
        }
    }

    function _storeSform(sformData) {
        $.ajax({
            url: '/sform/save-sform-data.json',
            type: "POST",
            data: JSON.stringify(sformData),
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
                if (result.errorCode == null) {
                    //SFORM_CONTAINER.html('<div class="text-info">Thank you for your information</div>');
                    _showSformModal('Cám ơn bạn để lại thông tin');
                } else {
                    console.log(result);
                }
            }
        });
    }

    this.shoppingCartService = SHOPPING_CART_COMPONENT;
}

var ENET_LEAD_SERVICE = new EnetLeadService();

$(document).ready(function () {
    var loadMode = $('#load-mode').html() || '';
    var opt = {}
    opt.loadMode = loadMode;
    opt.isswiper = false;
    if ($(".swiper-js-container").length) {
        opt.isswiper = true;
    }
    opt.issticky = false;
    if ($('[data-toggle="sticky"]').length) {
        opt.issticky = true;
    }
    opt.dropdown = false;
    if ($('[data-toggle="dropdown"]').length) {
        opt.dropdown = true;
    }
    opt.omnisearch = false;
    if ($('#omnisearch-search-input').length) {
        opt.omnisearch = true;
    }
    opt.navbarcollapse = false;
    if ($('.navbar-collapse ').length) {
        opt.navbarcollapse = true;
    }
    opt.oldheader = false;
    if ($('.navbar.navbar-inverse').length || $('.navbar.navbar-expand-lg').length) {
        opt.oldheader = true;
    }
    opt.blogToc = false;
    if ($('#blog-toc').length) {
        opt.blogToc = true;
    }
    opt.blogs = BLOG_COMPONENT.isInitialize();
    opt.slideToggle = false;
    if ($('[data-action="slide-toggle"]').length) {
        opt.slideToggle = true;
    }
    opt.catalogue = CATELOGUE_COMPONENT.isInit();
    opt.banners = BANNER_COMPONENT.isInitialize();
    opt.jarallax = $('.jarallax').length > 0 ? true : false;
    opt.fullPage = $('#fullPage').length > 0 ? true : false;
    ENET_LEAD_SERVICE.initialize(opt, function () {
        if ($('.sform-container').length) {
            $('.sform-container').each(function () {
                var code = $(this).data('code');
                ENET_LEAD_SERVICE.showSform(code);
            });
        }
    });
    CUSTOM_SECTION_COMPONENT.renderLayout();


    $.fn.removeClassByPrefix = function(a) {
        return this.each(function(b, c) {
            var d = c.className.split(" ").filter(function(b) {
                return 0 !== b.lastIndexOf(a, 0)
            });
            c.className = $.trim(d.join(" "))
        }),
            this
    }

    window.inAction = 0;
    window.allowSlide = 1;
    window.blockScroll = 1;
    window.effectOffset = 500;
    window.effectSpeed = 1000;
    window.slideSpeed = 1000;
    window.cleanupDelay = 1400;
    window.horizontalMode = 0;
    window.sidebarShown = 0;
    window.loadingProgress = 0;
    window.smoothScroll = 0;
    window.scrollSpeed = 0.5;
    window.preload = 1;
    window.setHashLink = 1;
    window.hideSidebarOnBodyClick = 1;
    window.collectScrolls = 0;
    window.sliderStatus = 0;
    window.minScrollToSlide = 500;
    window.minSwipeToSlide = 4;
    window.enableMobileZoom = 0;
    window.hideOnScrollSensitivity = 100;
    window.allowParallaxOnMobile = 1;
    window.hidePopupOnBodyClick = 1;
    window.isScroll = false;
    //How many stages?
    window.stage = 1;
    window.stages = $('.slide').length;
    window.slides = $('.slide');
    var $body = $('body');
    function showSlide(requested){

        requested = parseInt(requested);

        if ( window.isMobile && window.isSimplifiedMobile || window.isScroll ){
            return;
        }

        //updateNavigation();

        var newSlide = $('.slide').eq(requested - 1),
            currenSlide = $('.slide.selected'),
            currenSlideIndex = currenSlide.index('.slide') + 1;

        //cleanup
        //hideDropdown();
        //unzoomImage();
        //hideSidebar();
        window.allowSlide = 1;

        //reset
        $body.removeClass('sidebarShown lastSlide firstSlide hidePanel-top hidePanel-bottom');

        //It it first or last stage?
        if (window.setStageClasses != 0) {
            if (window.stage === 1){
                $body.addClass('firstSlide');
            }
            if ((window.stages === window.stage)&&(window.stages !== 1)) {
                $body.addClass('lastSlide');
            }

            //$body.removeClassByPrefix("stage-").addClass('stage-'+window.stage);
        }

        //white slide?
        if ( newSlide.hasClass('whiteSlide') ){
            $body.addClass('whiteSlide');
        } else {
            $body.removeClass('whiteSlide');
        }

        //prepare slides for transporting
        if (currenSlideIndex !== requested && window.setStageClasses != 0){
            currenSlide.removeClass('selected').addClass('active');
            newSlide.removeClass('before after').addClass('selected active');

            //set order
            newSlide.prevAll('.slide').addClass('before').removeClass('after');
            newSlide.nextAll('.slide').addClass('after').removeClass('before');

            //set a trigger
            $(window).trigger("slideChange", [parseInt(requested), newSlide]);
        }

        //set hash
        if (window.setHashLink){
            if (newSlide.attr('data-name') || newSlide.attr('id')) {
                window.location.hash = (newSlide.attr('data-name')) ? newSlide.attr('data-name') : newSlide.attr('id');
            } else if ((window.location.toString().indexOf('#')>0)&&(location.protocol !== "file:")&&(location.href.split('#')[0])){
                if (history.pushState) {
                    window.history.pushState("", "", location.href.split('#')[0]);
                } else {
                    window.location.hash = "";
                }
            }
        }

        //prepare to show slide
        newSlide.find('.content').scrollTop(0);

        if (window.loaded){
            //wait for animation
            window.blockScroll = 1;

            setTimeout(function(){
                if (currenSlideIndex !== requested){
                    currenSlide.removeClass('active animate');
                }

                //avoid accident scrolls
                window.blockScroll = 0;
            },window.effectSpeed);

            if (window.effectOffset > window.slideSpeed) { window.effectOffset = window.slideSpeed; }

            setTimeout(function(){
                newSlide.addClass('animate');
            },window.slideSpeed - window.effectOffset);


            //clear element animation on done
            $('.done').removeClass('done');

            clearTimeout(window.clearElementAnimation);
            window.clearElementAnimation = setTimeout(function(){
                $(".slide.selected [class*='ae-']").addClass('done');
            }, window.slideSpeed + window.effectSpeed + window.cleanupDelay);
        }
        //end showSlide();
    }

/*    $('html,body').on('DOMMouseScroll mousewheel scroll touchmove', function(e){

        var event = e.originalEvent;
        console.log('event.deltaY', event.deltaY);
    });*/

    $('html,body').on('DOMMouseScroll mousewheel scroll touchmove', function(e){
        if (window.inAction == 1) {
            window.scrollTo(0, 0);
        }
        var event = e.originalEvent;
        console.log('event.deltaY', event.deltaY);

        var $currentSection = $('.slide.selected .content'),
            scrollsize = Math.ceil(Math.abs(event.deltaY) * 100),
            browserScrollRate = (window.isFirefox) ? 2 : 1,
            OSScrollRate = (window.isWindows) ? browserScrollRate * 2 : browserScrollRate,
            wheelDelta = (event.wheelDelta) ? event.wheelDelta : event.deltaY * 100,
            energy = wheelDelta * browserScrollRate * OSScrollRate,
            scrollDirection = (event.deltaY < 0) ? "up" : "down",
            curSecScrolltop = $currentSection.scrollTop(),
            currentSectionHeight = $currentSection.outerHeight(),
            deviceZoom = 2,
            minScrollToSlide = (window.isFirefox && window.isWindows) ? 200 : window.minScrollToSlide;

        //skip empty events
        if (!scrollsize) return;


        //slide mode
        if ( !window.isScroll && !(window.isMobile && window.isSimplifiedMobile)){

            // scroll oversized content
            if ((currentSectionHeight > window.windowHeight)){

                if ((( scrollDirection === "up" ) && ( $currentSection.scrollTop() === 0 )) || (( scrollDirection === "down" ) && ( $currentSection.scrollTop() + window.windowHeight >= Math.floor(currentSectionHeight / deviceZoom) ))){
                    window.allowSlide = 1;
                } else {
                    window.allowSlide = 0;
                }

            }

            if (window.allowSlide && scrollsize) {
                if (scrollDirection == "down") {
                    window.collectScrolls = window.collectScrolls + scrollsize;
                } else {
                    window.collectScrolls = window.collectScrolls - scrollsize;
                }

                setTimeout(function(){
                    window.collectScrolls = 0;
                },200);
            }

            //change slide on medium user scroll
            if ((Math.abs(window.collectScrolls) >= minScrollToSlide) && (window.allowSlide) && (!window.sidebarShown) && (!window.popupShown) && (!window.disableOnScroll)){

                window.collectScrolls = 0;

                //should we even..
                if ((scrollDirection === "down" && window.stage !== window.stages)
                    ||(scrollDirection === "up" && window.stage !== 1)){

                    //ok let's go
                    if (window.inAction !== 1){
                        if (scrollDirection === "down"){
                            window.changeSlide('increase');
                        } else {
                            window.changeSlide('decrease');
                        }
                    }
                }
            }
        }
        //end on mousewheel event
    });

    window.changeSlide = function(n){
        if (n === "increase"){
            if ((window.stage + 1) >= window.stages){
                n = window.stages;
            } else {
                n = window.stage + 1;
            }
        } else if (n === "decrease"){
            if ((window.stage - 1) < 1){
                n = 1;
            } else {
                n = window.stage - 1;
            }
        }

        finalPosition = window.slides[n-1].offsetTop;
        window.stage = n;
        if (window.inAction !== 1) {
            window.inAction = 1;
            $('html,body').stop().clearQueue().animate({scrollTop: finalPosition}, 200);
            setTimeout(function(){
                window.inAction = 0;
            },1000);
        }
        /*if ( window.isMobile && window.isSimplifiedMobile || window.isScroll ){
            window.stage = n;
            var requestedElement = $('.slide:eq('+ (window.stage - 1) +')'),
                finalPosition = $(requestedElement).offset().top;

            $('html,body').stop().clearQueue().animate({scrollTop:finalPosition},1000);
        } else {
            if ((n !== window.stage)&&( n <= window.stages)){
                if (window.inAction !== 1){
                    window.inAction = 1;
                    window.stage = n;

                    var delay = 0;

                    setTimeout(function(){
                        showSlide(window.stage);
                        setTimeout(function(){ window.inAction = 0; }, window.slideSpeed);
                    }, delay);
                }
            }
        }*/
    };


});




