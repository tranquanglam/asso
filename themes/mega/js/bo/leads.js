function gotoPage(page) {
    $("#formPage").val(page);
    $("#myForm").submit();
}

$(document).ready(function () {
    function htmlRowLeadInfoContainer(name, value) {
        return `<div class="row mb-2">
                            <label class="col-sm-2 col-form-label">${name}</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" readonly value="${value}"/>
                            </div>
                        </div>`
    }

    function renderLeadInfoComment(lead) {
        let $leadInfoContainer=$('#leadInfoCommentContainer');
        $leadInfoContainer.empty();
        if (lead.leadInfo.commentList) {
            let commentList = lead.leadInfo.commentList;
            let html = '';
            commentList.forEach(function (item) {
                let date = new Date(item.createddate);
                //let formatted = ` ${date.getDate()}/${date.getMonth()}/${date.getFullYear()} `;
                let dateStr = date.toISOString().split('T').join(' ');
                html += `<div class="row ">                                                                         
                            <div class="col-sm-12">
                                <div class="card border-0 border-top">
                                    <div class="card-body py-2">
                                        <span class="text-sm text-muted">${dateStr} ${item.email || ''}</span></br>
                                        ${item.comment}
                                    </div>
                                </div>                                                
                            </div>
                        </div>`;
            });

            $leadInfoContainer.append(`<div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Comments</label>
                            <div class="col-sm-10">
                                ${html}
                            </div>
                        </div>`);
        }
    }
    $('.js-view-commentList').on('click', function (e) {
        let $ele = $(e.currentTarget);
        let leadid = $ele.data('leadid');
        $('#leadInfoModal').find('input[name="leadid"]').val(leadid);
        $.ajax({
            url: '/ajax/getLead.json?leadid=' + leadid,
            type: 'GET',
            contentType: "application/json",
            dataType: "json",
            success: function(result) {
                console.log(result);
                if (result.leadid != null) {
                    let $leadInfoContainer=$('#leadInfoContainer');
                    $leadInfoContainer.empty();
                    $leadInfoContainer.append(htmlRowLeadInfoContainer('Email', result.email));
                    $leadInfoContainer.append(htmlRowLeadInfoContainer('Created date', (new Date(result.createddate)).toISOString().split('T').join(' ')));
                    $leadInfoContainer.append(htmlRowLeadInfoContainer('Phone', result.leadInfo.phone || ''));
                    $leadInfoContainer.append(htmlRowLeadInfoContainer('Country', result.leadInfo.country || ''));
                    $leadInfoContainer.append(htmlRowLeadInfoContainer('Language', result.leadInfo.language || ''));

                    renderLeadInfoComment(result);
                    $('#leadInfoModal').modal('show');
                }
            }
        });
    });

    $('.js-lead-newComment').on('click', function (e) {
        let data = {
            comment: $('#newComment').val()
        }
        let leadid =$('#leadInfoModal').find('input[name="leadid"]').val();
        $.ajax({
            url: `/ajax/lead/${leadid}/addLeadComment.json`,
            type: 'POST',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: function(result) {
                console.log(result);
                $('#newComment').val('');
                renderLeadInfoComment(result);
            }
        });
    });
});
