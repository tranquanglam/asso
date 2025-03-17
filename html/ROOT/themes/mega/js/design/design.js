function ProductCompoments(){
    var me = this;


    this.getTemplateAjaxProducts = function () {
        return `<section class="">
                    <div class="container ajax-products-for-view py-5" col="2" colmd="4" colsm="2" maxn="8" query="" bgcolor="#e91212" colxs="2">Products here</div>
                </section>`
    };

    this.loadAjaxProducts = function () {
        if ($('.ajax-products-for-view').length) {
            $('.ajax-products-for-view').on('click', function (element) {
                let layout = $(element.currentTarget).attr('layout');
                let layoutitem = $(element.currentTarget).attr('layoutitem');
                let maxn = $(element.currentTarget).attr('maxn');
                let col = $(element.currentTarget).attr('col');
                let row = $(element.currentTarget).attr('row');
                let colmd = $(element.currentTarget).attr('colmd');
                let bgcolor = $(element.currentTarget).attr('bgcolor');
                let sitepageid = $($(element.currentTarget).closest(".content-to-be-editable")).data('sitepageid');
                let nameurl = $($(element.currentTarget).closest(".content-to-be-editable")).data('nameurl');
                let showprice = $(element.currentTarget).attr('showprice');
                let showcart = $(element.currentTarget).attr('showcart');
                let catIds = $(element.currentTarget).attr('catids');
                let title = $(element.currentTarget).attr('title');
                let titleCssClass = $(element.currentTarget).attr('titleCssClass');
                let showfeature = $(element.currentTarget).attr('showfeature');
                let showrate = $(element.currentTarget).attr('showrate');
                let query = $(element.currentTarget).attr('query');
                let swiper = $(element.currentTarget).attr('swiper') || false;
                if (swiper == 'true') {
                    swiper = true;
                } else if (swiper == 'false') {
                    swiper = false;
                }
                $('#ajaxProductsLayoutModal input[name="sitepageid"]').val(sitepageid);
                $('#ajaxProductsLayoutModal input[name="maxn"]').val(maxn);
                $('#ajaxProductsLayoutModal input[name="col"]').val(col);
                $('#ajaxProductsLayoutModal input[name="row"]').val(row);
                $('#ajaxProductsLayoutModal input[name="colmd"]').val(colmd);
                $('#ajaxProductsLayoutModal input[name="bgcolor"]').val(bgcolor);
                $('#ajaxProductsLayoutModal input[name="layout"]').val(layout);
                $('#ajaxProductsLayoutModal input[name="layoutitem"]').val(layoutitem);
                $('#ajaxProductsLayoutModal input[name="nameurl"]').val(nameurl);
                $('#ajaxProductsLayoutModal input[name="showprice"]').val(showprice);
                $('#ajaxProductsLayoutModal input[name="showcart"]').val(showcart);
                $('#ajaxProductsLayoutModal input[name="showfeature"]').val(showfeature);
                $('#ajaxProductsLayoutModal input[name="showrate"]').val(showrate);
                $('#ajaxProductsLayoutModal input[name="title"]').val(title);
                $('#ajaxProductsLayoutModal input[name="titleCssClass"]').val(titleCssClass);
                $('#ajaxProductsLayoutModal input[name="query"]').val(query);
                $('#ajaxProductsLayoutModal input[name="swiper"]').prop('checked', swiper);

                if (catIds) {
                    $('.select2-catIdList').val(catIds.split(','));
                    $('.select2-catIdList').trigger('change');
                }
                //$("#ajax-products-bg-color").spectrum("set",bgcolor);
                $('#ajaxProductsLayoutModal').modal('show');
            });
        }
    };
    this.loadCategoryByIds = function (catids, cattype, callback) {
        $.ajax({
            url: '/agent/categories.json',
            type: 'POST',
            data: JSON.stringify({
                start: 0,
                length: 999,
                filterMap: {
                    type: cattype || '',
                }
            }),
            contentType: "application/json",
            dataType: 'json',
            success: function(result) {
                console.log(result.data);
                if (result.recordsTotal > 0) {
                    callback(result.data);
                }
            }
        })
    };

    this.loadDynamicEnetLayout = function (THIS, element) {
        var $listAttrBox = $($('#ajaxEnetDynamicLayoutModal').find('.enet-list-attributes')[0]);
        $listAttrBox.empty();
        var catObj = {};
        $(THIS).each(function() {
            $.each(this.attributes, function() {
                if(this.specified) {
                    if (this.name == 'data-enet-catids') {
                        $listAttrBox.append(`
                                                <div class="row mb-1">
                                                <div class="col-4">
                                                    <label>${this.name}</label>
                                                </div>
                                                <div class="col-8">
                                                    <select class="js-data-category-ajax" name="${this.name.trim()}" multiple="multiple"></select>
                                                </div>
                                            </div>                               
                            `);
                        catObj.catids = this.value.trim();
                    } else {
                        $listAttrBox.append(`
                                                <div class="row mb-1">
                                                <div class="col-4">
                                                    <label>${this.name}</label>
                                                </div>
                                                <div class="col-8">
                                                    <input type="text" class="form-control " name="${this.name.trim()}" value="${this.value.trim()}"/>
                                                </div>
                                            </div>                               
                            `);
                    }

                }
            });
        });
        if (catObj.catids) {
            let cattype = $('#ajaxEnetDynamicLayoutModal input[name="data-enet-cattype"]').val() || '';
            me.loadCategoryByIds(catObj.catids, cattype, function (dataList) {
                var data = [];
                dataList.forEach(function (item) {
                    data.push({
                        id: item.categoryid,
                        text: item.name
                    })
                });
                $('.js-data-category-ajax').select2({
                    data: data,
                    dropdownParent: $('#ajaxEnetDynamicLayoutModal'),
                    theme: "bootstrap-5",
                    allowClear: false,
                    placeholder: "Category IDs",
                    minimumResultsForSearch: Infinity,
                });

                var arr = catObj.catids.split(',');
                $('.js-data-category-ajax').val(arr).trigger('change');
            });
        }
        let sitepageid = $($(element.currentTarget).closest(".content-to-be-editable")).data('sitepageid');
        let nameurl = $($(element.currentTarget).closest(".content-to-be-editable")).data('nameurl');
        let layout = $(element.currentTarget).attr('layout');
        $('#ajaxEnetDynamicLayoutModal input[name="layout"]').val(layout);
        $('#ajaxEnetDynamicLayoutModal input[name="sitepageid"]').val(sitepageid);
        $('#ajaxEnetDynamicLayoutModal input[name="nameurl"]').val(nameurl);
        $('#ajaxEnetDynamicLayoutModal').modal('show');
    };
    this.loadAjaxBanners = function () {
        if ($('.enet-ajax-load-banners').length) {
            $('.enet-ajax-load-banners').on('click', function (element) {
                me.loadDynamicEnetLayout(this, element);
            });
        }
        if ($('.enet-ajax-load-blogs').length) {
            $('.enet-ajax-load-blogs').on('click', function (element) {
                me.loadDynamicEnetLayout(this, element);
            });

        }
        if ($('.enet-ajax-load-sitepages').length) {
            $('.enet-ajax-load-sitepages').on('click', function (element) {
                me.loadDynamicEnetLayout(this, element);
            });
        }
    };

    this.loadCategories = function () {
        $.ajax({
            url: '/agent/categories.json',
            type: 'POST',
            data: JSON.stringify({
                start: 0,
                length: 999,
                filterMap: {
                    type: '8'
                }
            }),
            contentType: "application/json",
            dataType: 'json',
            success: function(result) {
                console.log(result.data);
                if (result.recordsTotal > 0) {
                    me.loadSelect2Category(result.data);
                }
            }
        })
    };
    this.loadSelect2Category = function (dataList) {
        var data = [];
        dataList.forEach(function (item) {
            data.push({
                id: item.categoryid,
                text: item.name
            })
        });
        $('.select2-catIdList').select2({
            dropdownParent: $('#ajaxProductsLayoutForm'),
            theme: "bootstrap-5",
            data: data
        });
    };
    this.init = function () {
        me.loadAjaxProducts();
        me.loadCategories();
        me.loadAjaxBanners();
    };
}
var PRODUCTS_COMPOMENT = new ProductCompoments();

function SectionComponents() {
    var me = this;
    var tempElement = null;
    me.currentTarget = null;
    me.sitePageId = null;
    var metaClass = {};
    metaClass.fontSize = ['', 'h1','h2','h3','h4','h5','display-1','display-2','display-3','display-4']
    metaClass.animationType = ['',  'animate__bounce',
                                'animate__bounceIn',
                                'animate__bounceInDown',
                                'animate__bounceInUp',
                                'animate__bounceInLeft',
                                'animate__bounceInRight',
                                'animate__bounceOut',
                                'animate__bounceOutDown',
                                'animate__bounceOutUp',
                                'animate__bounceOutLeft',
                                'animate__bounceOutRight',
                                'animate__fadeIn',
                                'animate__fadeInLeft',
                                'animate__fadeInRight',
                                'animate__fadeInDown',
                                'animate__fadeInUp',
                            ]
    function editBgCover() {

    }

    this.genUID = function(p){var c = 0,i;p = (typeof p==="string")?p:"";do{i=p+c++;}while(document.getElementById(i)!==null);return i;}

    this.initToolDesign = function () {
        $('#js-enet-element-class-fontSize').empty();
        metaClass.fontSize.forEach(function (value, index, array) {
            $('#js-enet-element-class-fontSize').append(`<option value="${value}">${value}</option>`)
        });

        $('#js-enet-element-animationtype').empty();
        metaClass.animationType.forEach(function (value, index, array) {
            $('#js-enet-element-animationtype').append(`<option value="${value}">${value}</option>`)
        });
    }

    this.applyElement = function () {

    }

    function clickElement(event){
        var $element = $(event.target);
        me.currentTarget = $element;

        var tagName = $element.get(0).nodeName.toLowerCase();
        if ($element.length > 0) {
            $('#js-enet-element-tagname').val($element.get(0).nodeName);
        }
        if (['img'].includes(tagName)) {
            $('.js-enet-design-src').removeClass('d-none');
            let src = $element.attr('src');
            $('#js-enet-element-src').val(src);
        } else {
            $('.js-enet-design-src').removeClass('d-none').addClass('d-none');
        }
        var classStr = $element.attr('class');

        $('#js-enet-element-class-other').val(classStr);
        $('#js-enet-element-paragraph').val($element.html());

        var classArray = (classStr && classStr.length > 0) ? classStr.split(" ") : [];
        classArray.forEach(function (value, index, array) {
            if (metaClass.fontSize.includes(value)) {
                $('#js-enet-element-class-fontSize').val(value);
            }
            if (metaClass.animationType.includes(value)) {
                $('#js-enet-element-animationtype').data('preVal', value);
                $('#js-enet-element-animationtype').val(value);
            }
        });
    }

    function replaceElementTag(targetSelector, newTagString) {
        $(targetSelector).each(function(){
            var newElem = $(newTagString, {html: $(this).html()});
            $.each(this.attributes, function() {
                newElem.attr(this.name, this.value);
            });
            $(this).replaceWith(newElem);
        });
    }

    this.registryElementEvent = function () {
        if ($('section.bg-cover').length > 0) {
            /*$('section.bg-cover').on('mouseover', function (e) {
                console.log("onmouseover bg-cover");
            });

            $('p').on('mouseover', function (e) {
                console.log("onmouseover p");
            });*/
        }

        $('.body-content-left div, p, small, i, h1, h2, h3, h4, h5').on('click', function (event) {
            clickElement(event);
        });


        $('#js-enet-element-class-other').on('change', function (event) {
            if (me.currentTarget) {
                me.currentTarget.attr('class', $('#js-enet-element-class-other').val());
            }
        });

        $('#js-enet-element-paragraph').on('change', function (event) {
            if (me.currentTarget) {
                me.currentTarget.html($('#js-enet-element-paragraph').val());
            }
        });

        $('#js-enet-element-src').on('change', function (event) {
            if (me.currentTarget) {
                me.currentTarget.attr('src', $('#js-enet-element-src').val());
            }
        });

        $('#js-enet-element-animationtype').on('change', function (event) {
            if (me.currentTarget) {
                let animationTypeSelected = $(event.target).val();
                let $currentTarget = $(me.currentTarget);
                let currentClass = $currentTarget.attr('class');
                let arrayClass = currentClass.split(" ");
                metaClass.animationType.forEach(function (value, index, array) {
                    if (arrayClass.includes(value)) {
                        currentClass = currentClass.replace(value, '');
                        currentClass = currentClass.replace('animate__animated', '');
                    }
                });
                $currentTarget.attr('class',  `${currentClass} animate__animated ${animationTypeSelected}`);
                $('#js-enet-element-class-other').val($currentTarget.attr('class'));
            }
        });

        if ($('.enet-element').length) {

        }

        if ($('.js-enet-btn-removeElement').length) {
            $('.js-enet-btn-removeElement').on('click', function (e) {
                me.currentTarget.remove();
            });
        }

        $('.js-enet-btn-duplicateElement').on('click', function (e) {
            me.currentTarget.clone().insertAfter(me.currentTarget);
        });

        /*$('a').on('click', function (e) {
            e.preventDefault();
        });*/
    }
    this.init = function () {
        me.initToolDesign();
        me.registryElementEvent();
    }
}
var SECTION_COMPONENT = new SectionComponents();

function EnetDesignService(){
    var me  = this;
    function loadScript(url, callback) {
        $.ajax({
            url: url,
            dataType: 'script',
            success: callback,
            async: true
        });
    }
    function loadCss(css) {
        var styles = document.createElement('link');
        styles.rel = 'stylesheet';
        styles.type = 'text/css';
        styles.media = 'screen';
        styles.href = css;
        document.getElementsByTagName('head')[0].appendChild(styles);
    }
    this.initialize = function(opt, callback) {
        if (opt.productsComponent) {
            _initProductsCompoment();
        }
        if (opt.sectionsComponent) {
            _initSectionsComponent();
        }
        callback();
    };

    function _initProductsCompoment() {
        PRODUCTS_COMPOMENT.init();
    }

    function _initSectionsComponent(){
        SECTION_COMPONENT.init();
    }
}

var ENET_DESIGN_SERVICE = new EnetDesignService();
var opt = {};
$(document).ready(function() {
    opt.productsComponent = false;
    if($(".ajax-products-for-view").length) {
        opt.productsComponent = true;
    }
    opt.sectionsComponent = true;
    ENET_DESIGN_SERVICE.initialize(opt,function(){

    });
});
