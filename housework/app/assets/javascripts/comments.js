function removeComment(btns) {
    $.each(btns, function(index, value) {
        $(value).on('click', function() {
            var comment = $(this).parent().parent().parent().parent();
            $.ajax({
                method: "DELETE",
                url: '/comments/' + comment.data('comment'),
                dataType: 'json'
            }).success(function(){
                comment.remove();
            });
        })
    });
}

$( document ).ready(function() {
    removeComment($('.delete-btn'));
});