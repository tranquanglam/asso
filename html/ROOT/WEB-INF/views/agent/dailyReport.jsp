<%@ include file="/common/taglibs.jsp" %>
<div class="row">
    <div class="col-lg-12">
        <ol class="breadcrumb">
            <li><a href="#">Home</a></li>
            <li class="active"><span>Daily Report</span></li>
        </ol>

        <h1>Daily Report</h1>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="main-box clearfix">
            <header class="main-box-header clearfix">
                <h2>Filter By</h2>
            </header>
            <div class="main-box-body clearfix">
                <form id="bookingFilterForm" class="form-inline" role="form" action="/agent/dailyReport" method="post">
                    <div class="form-group col-md-3">
                        <label for="datepickerFromDate">From</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            <input type="text" class="form-control" id="datepickerFromDate" name="fromDate" value="${chartForm.fromDate}" placeholder="mm/dd/yyyy">
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <label for="datepickerToDate">To</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            <input type="text" class="form-control" id="datepickerToDate" name="toDate" value="${chartForm.toDate}" placeholder="mm/dd/yyyy">
                        </div>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="statusSel2">Status</label>
                        <select name="status" id="statusSel2" class="form-control">
                            <option value="">All</option>
                            <option value="REQUEST">REQUEST</option>
                            <option value="AMEND_REQ">AMEND_REQ</option>
                            <option value="AMENDED">AMENDED</option>
                            <option value="CONFIRMED">CONFIRMED</option>
                            <option value="REFUSED">REFUSED</option>
                            <option value="PAID_NOTIFY">PAID_NOTIFY</option>
                            <option value="CANCELLED">CANCELLED</option>
                            <option value="DONE">DONE</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-success">Apply Report</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="main-box clearfix">
            <div class="main-box-body clearfix">
                <div id="dailyReport" style="height: 400px; padding: 0px; position: relative;">
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/themes/cube/js/flot/jquery.flot.min.js"></script>
<script src="/themes/cube/js/flot/jquery.flot.axislabels.js"></script>
<script src="/themes/cube/js/flot/jquery.flot.orderBars.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        var data = [];
        var ticks=[];
        var i=0;
        <c:forEach items="${reportByStatus}" var="bookingperdate">
        data[i]=[i,${bookingperdate.count}];
        ticks[i]=[i,"${bookingperdate.dateStr}"]
        i++;
        </c:forEach>
        var series = [{
            label:"${status}",
            color:"#2895F8",
            data : data
        }];
        $.plot("#dailyReport", series, {
            series: {

                lines: {
                    show: true
                },

                points: {
                    radius: 3,
                    fill: true,
                    show: true
                }
            },
            xaxis: {
                axisLabel: "Date",
                align: 'center',
                ticks: ticks
            },
            yaxis: {
                axisLabel: "Number of Bookings",
                min:0, tickSize: 1
            }
        })
    });
    var selectedStatus = '${chartForm.status}';
</script>
