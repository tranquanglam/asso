<%@ include file="/common/taglibs.jsp"%>


<div class="row">
    <div class="col-lg-12">
        <ol class="breadcrumb">
            <li><a href="#">Home</a></li>
            <li class="active"><span>Sites</span></li>
        </ol>

        <h1>Sites</h1>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="main-box clearfix">
            <header class="main-box-header clearfix">
                <h2>Agent Sites</h2>
            </header>

            <div class="main-box-body clearfix">
                <div class="table-responsive">
                    <table id="sites_table" class="display table table-hover"  width="100%">
                        <thead>
                        <tr>
                            <th></th>
                            <th>Name</th>
                            <th>Domain</th>
                            <th>Type</th>
                            <th>Pages</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>


        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="agentTourFormModal" tabindex="-1" role="dialog"
     aria-labelledby="agentTourFormModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="agentTourFormModalLabel">Edit Tour</h4>
            </div>
            <div class="modal-body">
                <form id="agentTourForm">
                    <input type="hidden" name="agentid">
                    <input type="hidden" name="teventid">

                    <div class="form-group">
                        <label for="name" class="control-label">Name:</label>
                        <input type="text" class="form-control" id="name" name="name"/>
                    </div>
                    <div class="form-group">
                        <label for="urlname" class="control-label">Name:</label>
                        <input type="text" class="form-control" id="urlname" name="urlname"/>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="visible" name="visible"> Visible
                        </label>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveButton">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!--end Modal -->