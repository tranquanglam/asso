var lang = 'en';
var bmenu = null;
//
// Navbar
//

'use strict';

var NavbarCollapse = (function() {

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
            'show.bs.collapse': function() {
                showNavbarCollapse($collapse);
            }
        })

        $collapse.on({
            'hide.bs.collapse': function() {
                hideNavbarCollapse($collapse);
            }
        })

        $collapse.on({
            'hidden.bs.collapse': function() {
                hiddenNavbarCollapse($collapse);
            }
        })
    }

})();

//
// Dropdown
//

'use strict';

var Dropdown = (function() {

    // Variables

    var $dropdown = $('.dropdown-animate'),
        $dropdownSubmenu = $('.dropdown-submenu [data-toggle="dropdown"]');


    // Methods

    function hideDropdown($this) {

        // Add additional .hide class for animated dropdown menus in order to apply some css behind

        // var $dropdownMenu = $this.find('.dropdown-menu');
        //
        // $dropdownMenu.addClass('hide');
        //
        // setTimeout(function(){
        //     $dropdownMenu.removeClass('hide');
        // }, 300);

    }

    function initSubmenu($this) {
        if (!$this.next().hasClass('show')) {
            $this.parents('.dropdown-menu').first().find('.show').removeClass("show");
        }

        var $submenu = $this.next(".dropdown-menu");

        $submenu.toggleClass('show');
        $submenu.parent().toggleClass('show');

        $this.parents('.nav-item.dropdown.show').on('hidden.bs.dropdown', function(e) {
            $('.dropdown-submenu .show').removeClass("show");
        });
    }

    // Events

    if ($dropdown.length) {
        $dropdown.on({
            'hide.bs.dropdown': function() {
                hideDropdown($dropdown);
            }
        })
    }

    if ($dropdownSubmenu.length) {
        $dropdownSubmenu.on('click', function(e) {

            initSubmenu($(this))

            return false;
        });
    }
})();

'use strict';

var Layout = (function() {

    function pinSidenav($this) {
        $('.sidenav-toggler').addClass('active');
        $('.sidenav-toggler').data('action', 'sidenav-unpin');
        $('body').removeClass('g-sidenav-hidden').addClass('g-sidenav-show g-sidenav-pinned');
        $('body').append('<div class="mask-body mask-body-light d-xl-none" data-action="sidenav-unpin" data-target='+$('#sidenav-main').data('target')+' />');

        // Store the sidenav state in a cookie session
        localStorage.setItem('sidenav-state', 'pinned');
    }

    function unpinSidenav($this) {
        $('.sidenav-toggler').removeClass('active');
        $('.sidenav-toggler').data('action', 'sidenav-pin');
        $('body').removeClass('g-sidenav-pinned').addClass('g-sidenav-hidden');
        $('body').find('.mask-body').remove();

        // Store the sidenav state in a cookie session
        localStorage.setItem('sidenav-state', 'unpinned');
    }

    // Set sidenav state from cookie

    var $sidenavState = localStorage.getItem('sidenav-state') ? localStorage.getItem('sidenav-state') : 'pinned';

    if($(window).width() > 1200) {
        if($sidenavState == 'pinned') {
            pinSidenav($('#sidenav-toggler'));
        }

        if(localStorage.getItem('sidenav-state') == 'unpinned') {
            unpinSidenav($('#sidenav-main'));
        }
    }

    $("body").on("click", "[data-action]", function(e) {

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
                target = $this.data('target');
                $this.addClass('active');
                $(target).addClass('show');
                $('body').append('<div class="mask-body mask-body-light" data-action="aside-close" data-target='+target+' />');
                break;

            case 'aside-close':
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
                $('body').addClass('omnisearch-open').append('<div class="mask-body mask-body-dark" data-action="omnisearch-close" data-target="'+target+'" />');
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
                $('body').addClass('popup-cart-items-open').append('<div class="mask-body mask-body-dark" data-action="popup-cart-items-close" data-target="'+target+'" />');
                break;

            case 'popup-cart-items-close':
                target = $this.data('target');
                $(target).removeClass('show');
                $('body').removeClass('popup-cart-items-open').find('.mask-body').remove();
                break;
        }
    })

    // Add sidenav modifier classes on mouse events

    $('.sidenav').on('mouseenter', function() {
        if(! $('body').hasClass('g-sidenav-pinned')) {
            $('body').removeClass('g-sidenav-hide').removeClass('g-sidenav-hidden').addClass('g-sidenav-show');
        }
    })

    $('.sidenav').on('mouseleave', function() {
        if(! $('body').hasClass('g-sidenav-pinned')) {
            $('body').removeClass('g-sidenav-show').addClass('g-sidenav-hide');

            setTimeout(function() {
                $('body').removeClass('g-sidenav-hide').addClass('g-sidenav-hidden');
            }, 300);
        }
    })

    // Offset an element by giving an existing element's class or id from the same page

    if($('[data-offset-top]').length) {
        var $el = $('[data-offset-top]'),
            $offsetEl = $($el.data('offset-top')),
            offset = $offsetEl.height();


        $el.css({'padding-top':offset+'px'})
    }
})();

//
// Popover
//

'use strict';

var Popover = (function() {

    // Variables

    var $popover = $('[data-toggle="popover"]');


    // Methods

    function init($this) {
        var popoverClass = '';

        if ($this.data('color')) {
            popoverClass = ' popover-' + $this.data('color');
        }

        var options = {
            trigger: 'focus',
            template: '<div class="popover' + popoverClass + '" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
        };

        $this.popover(options);
    }


    // Events

    if ($popover.length) {
        $popover.each(function() {
            init($(this));
        });
    }

})();


function getBmenu(callback) {
    $.ajax({
        url: '/agent/design/header/get-menu.json',
        type: 'GET',
        contentType: "application/json",
        success: function(result) {
            bmenu = result;
            callback();
        }
    });
}
function saveBmenu() {
    $.ajax({
        url: '/agent/design/header/save-menu.json',
        type: 'POST',
        data: JSON.stringify(bmenu),
        contentType: "application/json",
        success: function(result) {
            window.location.reload();
        }
    });
}
function getBitem(path) {
    var result = null;
    var arraypath = path.split('/');
    var len = arraypath.length;
    if (len > 2) {
        if (arraypath[0] == 'bmenuMain') {
            if (arraypath[1] == 'rightItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    result = bmenu.bmenuMain.rightItems[index];
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    result = bmenu.bmenuMain.rightItems[index].items[index2];
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    result = bmenu.bmenuMain.rightItems[index].items[index2].items[index3];
                }
            } else if (arraypath[1] == 'leftItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    result = bmenu.bmenuMain.leftItems[index];
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    result = bmenu.bmenuMain.leftItems[index].items[index2];
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    result = bmenu.bmenuMain.leftItems[index].items[index2].items[index3];
                }
            }
        } else if (arraypath[0] == 'bmenuTop') {
            if (arraypath[1] == 'rightItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    result = bmenu.bmenuTop.rightItems[index];
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    result = bmenu.bmenuTop.rightItems[index].items[index2];
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    result = bmenu.bmenuTop.rightItems[index].items[index2].items[index3];
                }
            } else if (arraypath[1] == 'leftItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    result = bmenu.bmenuTop.leftItems[index];
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    result = bmenu.bmenuTop.leftItems[index].items[index2];
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    result = bmenu.bmenuTop.leftItems[index].items[index2].items[index3];
                }
            }
        }
    }
    return result;
}
$('.cat-item').on('click',function(){
    var isnew = $(this).data('isnew');
    var path =  $(this).data('path');
    var dropdownlink = $(this).data('dropdownlink');
    var type = 'link';
    if (dropdownlink == 'dropdownlink') {
        $('#dropdownmenulink-col').removeClass('d-none');
        $('#link-col').removeClass('d-none');
    } else if (dropdownlink == 'link') {
        $('#dropdownmenulink-col').addClass('d-none');
        $('#link-col').removeClass('d-none');
    } else if (dropdownlink == 'dropdown') {
        $('#dropdownmenulink-col').removeClass('d-none');
        $('#link-col').addClass('d-none');
        type = 'dropdown';
    } else if (dropdownlink == 'text') {
        $('#dropdownmenulink-col').addClass('d-none');
        $('#link-col').addClass('d-none');
        type = 'text';
    } else if (dropdownlink == 'login') {
        $('#dropdownmenulink-col').removeClass('d-none');
        $('#link-col').removeClass('d-none');
        type = 'login';
    }
    //console.log("click cat-item isnew=" + isnew + ' | type = ' + type + ' | path = ' + path);
    if (isnew) {
        $('#menuItemForm').find('input[name="isnew"]').val('true');
        $('#menuItemForm').find('input[name="label"]').val('');
        $('#menuItemForm').find('input[name="cssClass"]').val('');
        $('#menuItemForm').find('input[name="path"]').val(path);
        $('#menuItemForm').find('input[name="href"]').val("#");
        $('#menuItemForm').find('select[name="type"]').val(type);
        $('#menuItemForm').find('input[name="iconCss"]').val('');
        $('#menuItemForm').find('input[name="description"]').val('');
        $('.btn-delete').addClass('d-none');
        $('#menuItemFormModal').modal('show');
    } else {
        var result = getBitem(path);
        if (result != null) {
            $('#menuItemForm').find('input[name="isnew"]').val('false');
            $('#menuItemForm').find('input[name="path"]').val(result.path);
            $('#menuItemForm').find('input[name="cssClass"]').val(result.cssClass);
            $('#menuItemForm').find('input[name="label"]').val(result.label);
            $('#menuItemForm').find('input[name="href"]').val(result.href);
            $('#menuItemForm').find('select[name="type"]').val(result.type);
            $('#menuItemForm').find('input[name="iconCss"]').val(result.iconCss);
            $('#menuItemForm').find('input[name="description"]').val(result.description);
            $('.btn-delete').removeClass('d-none');
            $('#menuItemFormModal').modal('show');
        } else {
            console.log("NOT FOUD BITEM:" + path);
        }
    }
});
function addBitem(bitem) {
    var arraypath = bitem.path.split('/');
    var len = arraypath.length;
    if (len > 2) {
        if (arraypath[0] == 'bmenuMain') {
            if (arraypath[1] == 'rightItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    bmenu.bmenuMain.rightItems[index] = bitem;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    if (bmenu.bmenuMain.rightItems[index].items == null) {
                        bmenu.bmenuMain.rightItems[index].items = [];
                    }
                    bmenu.bmenuMain.rightItems[index].items[index2] = bitem;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    if (bmenu.bmenuMain.rightItems[index].items[index2].items == null) {
                        bmenu.bmenuMain.rightItems[index].items[index2].items = [];
                    }
                    bmenu.bmenuMain.rightItems[index].items[index2].items[index3] = bitem;
                }
            } else if (arraypath[1] == 'leftItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    bmenu.bmenuMain.leftItems[index] = bitem;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    if (bmenu.bmenuMain.leftItems[index].items == null) {
                        bmenu.bmenuMain.leftItems[index].items = [];
                    }
                    bmenu.bmenuMain.leftItems[index].items[index2] = bitem;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    if (bmenu.bmenuMain.leftItems[index].items[index2].items == null) {
                        bmenu.bmenuMain.leftItems[index].items[index2].items = [];
                    }
                    bmenu.bmenuMain.leftItems[index].items[index2].items[index3] = bitem;
                }
            }
        } else if (arraypath[0] == 'bmenuTop') {
            if (arraypath[1] == 'rightItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    bmenu.bmenuTop.rightItems[index] = bitem;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    if (bmenu.bmenuTop.rightItems[index].items == null) {
                        bmenu.bmenuTop.rightItems[index].items = [];
                    }
                    bmenu.bmenuTop.rightItems[index].items[index2] = bitem;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    if (bmenu.bmenuTop.rightItems[index].items[index2].items == null) {
                        bmenu.bmenuTop.rightItems[index].items[index2].items = [];
                    }
                    bmenu.bmenuTop.rightItems[index].items[index2].items[index3] = bitem;
                }
            } else if (arraypath[1] == 'leftItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    bmenu.bmenuTop.leftItems[index] = bitem;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    if (bmenu.bmenuTop.leftItems[index].items == null) {
                        bmenu.bmenuTop.leftItems[index].items = [];
                    }
                    bmenu.bmenuTop.leftItems[index].items[index2] = bitem;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    if (bmenu.bmenuTop.leftItems[index].items[index2].items == null) {
                        bmenu.bmenuTop.leftItems[index].items[index2].items = [];
                    }
                    bmenu.bmenuTop.leftItems[index].items[index2].items[index3] = bitem;
                }
            }
        }
    }
}
function menuItemFormSave() {
    var isnew = $('#menuItemForm').find('input[name="isnew"]').val();
    var path = $('#menuItemForm').find('input[name="path"]').val();
    var cssClass = $('#menuItemForm').find('input[name="cssClass"]').val();
    var iconCss = $('#menuItemForm').find('input[name="iconCss"]').val();
    var label = $('#menuItemForm').find('input[name="label"]').val();
    if (label == '' || label.length < 3) {
        $('#menuItemForm').find('input[name="label"]').focus();
        return;
    }
    var description = $('#menuItemForm').find('input[name="description"]').val();
    var href = $('#menuItemForm').find('input[name="href"]').val();
    var type = $('#menuItemForm').find('select[name="type"]').val();
    if (isnew == 'true') {
        var bitem = {};
        bitem.path = path;
        bitem.type = type;
        bitem.href = href;
        bitem.label = label;
        bitem.cssClass = cssClass;
        bitem.iconCss =iconCss;
        bitem.description =description;
        addBitem(bitem);
    } else {
        var bitem = getBitem(path);
        if (bitem != null) {
            bitem.type = type;
            bitem.href = href;
            bitem.label = label;
            bitem.cssClass = cssClass;
            bitem.iconCss =iconCss;
            bitem.description =description;
        } else {
            console.log("ERROR: update bitem fail:" + path);
        }
    }
    saveBmenu();
}
function removeOutOfArray(arr,index,parentpath) {
    var newArray = [];
    var count = 0;
    for (var i=0;i<arr.length;i++) {
        if (i < index) {
            newArray[count] = arr[i];
            count++;
        } else if (i > index) {
            var item = arr[i];
            item.path = parentpath + "/" + count;
            newArray[count] = item;
            count++;
            if (item.items != null && item.items.length > 0) {
                item.items = removeOutOfArray(item.items,-1,item.path);
            }
        }
    }
    return newArray;
}
function menuItemFormDelete() {
    var path = $('#menuItemForm').find('input[name="path"]').val();
    var arraypath = path.split('/');
    var len = arraypath.length;
    if (len > 2) {
        if (arraypath[0] == 'bmenuMain') {
            if (arraypath[1] == 'rightItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    var arr = removeOutOfArray(bmenu.bmenuMain.rightItems,index,'bmenuMain/rightItems');
                    bmenu.bmenuMain.rightItems = arr;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var arr = removeOutOfArray(bmenu.bmenuMain.rightItems[index].items,index2,'bmenuMain/rightItems/'+index);
                    bmenu.bmenuMain.rightItems[index].items = arr;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    var arr = removeOutOfArray(bmenu.bmenuMain.rightItems[index].items[index2].items,index3,'bmenuMain/rightItems/'+index+'/'+index2);
                    bmenu.bmenuMain.rightItems[index].items[index2].items = arr;
                }
            } else if (arraypath[1] == 'leftItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    var arr = removeOutOfArray(bmenu.bmenuMain.leftItems,index,'bmenuMain/leftItems');
                    bmenu.bmenuMain.leftItems = arr;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var arr = removeOutOfArray(bmenu.bmenuMain.leftItems[index].items,index2,'bmenuMain/leftItems/'+index);
                    bmenu.bmenuMain.leftItems[index].items = arr;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    var arr = removeOutOfArray(bmenu.bmenuMain.leftItems[index].items[index2].items,index3,'bmenuMain/leftItems/'+index+'/'+index2);
                    bmenu.bmenuMain.leftItems[index].items[index2].items = arr;
                }
            }
        } else if (arraypath[0] == 'bmenuTop') {
            if (arraypath[1] == 'rightItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    var arr = removeOutOfArray(bmenu.bmenuTop.rightItems,index,'bmenuTop/rightItems');
                    bmenu.bmenuTop.rightItems = arr;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var arr = removeOutOfArray(bmenu.bmenuTop.rightItems[index].items,index2,'bmenuTop/rightItems/'+index);
                    bmenu.bmenuTop.rightItems[index].items = arr;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    var arr = removeOutOfArray(bmenu.bmenuTop.rightItems[index].items[index2].items,index3,'bmenuTop/rightItems/'+index+'/'+index2);
                    bmenu.bmenuTop.rightItems[index].items[index2].items = arr;
                }
            } else if (arraypath[1] == 'leftItems') {
                if (len == 3) {
                    var index = parseInt(arraypath[2]);
                    var arr = removeOutOfArray(bmenu.bmenuTop.leftItems,index,'bmenuTop/leftItems');
                    bmenu.bmenuTop.leftItems = arr;
                } else if (len == 4) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var arr = removeOutOfArray(bmenu.bmenuTop.leftItems[index].items,index2,'bmenuTop/leftItems/'+index);
                    bmenu.bmenuTop.leftItems[index].items = arr;
                } else if (len == 5) {
                    var index = parseInt(arraypath[2]);
                    var index2 = parseInt(arraypath[3]);
                    var index3 = parseInt(arraypath[4]);
                    var arr = removeOutOfArray(bmenu.bmenuTop.leftItems[index].items[index2].items,index3,'bmenuTop/leftItems/'+index+'/'+index2);
                    bmenu.bmenuTop.leftItems[index].items[index2].items = arr;
                }
            }
        }
    }
    saveBmenu();
}
function uploadLogoSubmit() {
    $('#uploadLogoForm').submit();
}
function saveHeaderConfigForm() {
    bmenu.headerType = $('#headerConfigFormModal').find('select[name="headerType"]').val();
    bmenu.cssClass = $('#headerConfigFormModal').find('input[name="cssClass"]').val();
    bmenu.bmenuTop.cssClass = $('#headerConfigFormModal').find('input[name="bmenuTop.cssClass"]').val();
    bmenu.bmenuTop.show = $('#headerConfigFormModal').find('input[name="bmenuTop.show"]').is(":checked");
    bmenu.bmenuMain.cssClass = $('#headerConfigFormModal').find('input[name="bmenuMain.cssClass"]').val();
    if (bmenu.bmenuMain.logo == null) {
        bmenu.bmenuMain.logo = {};
    }
    bmenu.bmenuMain.logo.align = $('#headerConfigFormModal').find('select[name="bmenuMain.logo.align"]').val();
    bmenu.fontFamily = $('#headerConfigFormModal').find('input[name="fontFamily"]').val();
    bmenu.bgColor = $('#headerConfigFormModal').find('input[name="bgColor"]').val();
    bmenu.bgColorTop = $('#headerConfigFormModal').find('input[name="bgColorTop"]').val();
    bmenu.bgGradientColor = $('#headerConfigFormModal').find('input[name="bgGradientColor"]').val();
    bmenu.txtColor = $('#headerConfigFormModal').find('input[name="txtColor"]').val();
    bmenu.txtColorTop = $('#headerConfigFormModal').find('input[name="txtColorTop"]').val();
    saveBmenu();
}
$(document).ready(function() {
    lang = $('#lang').html();
    var base64_encoded_path = $('#base64_encoded_path').html();
    $('.header-config-change').on('click',function(){
        $('#headerConfigFormModal').modal('show');
    });
    $("#header-bg-color").spectrum({
        preferredFormat: "hex",
        color: $('#headerLayoutForm').find('input[name="bgcolor"]').val(),
        showInitial: true,
        showInput: true,
        appendTo: "#headerLayoutsModal"
    });
    $('.change-logo').on('click',function(event){
        event.preventDefault();
        $('#uploadLogoModal').modal('show');
        return false;
    });
    $('.set-color').on('click',function(){
        var inputtarget = $(this).data('inputtarget');
        var t = $("#header-bg-color").spectrum("get");
        $('#headerConfigFormModal').find('input[name="'+inputtarget+'"]').val(t.toHexString());
    });
    getBmenu(function(result){

    });
    $('.btn-toggle-header').on('click',function(){
        if ($('.header-live-content.show').length) {
            $('.header-live-content').removeClass('show');
        } else {
            $('.header-live-content').addClass('show');
        }
    });
});
