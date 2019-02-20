$(function() {
    // ---------------------------------------------------
    // show/hide other language fields
    function check_language_other_fields() {
        if($('[id^=resource_language_]').eq(-2).is(':checked')) {
            $("#language_other_div").css("display","block");
        }else{
            $("#language_other_div").css("display","none");
        }
    }
    <!-- Show hiden 'other' language field -->
    var language_last = $("[id^=resource_language_]").eq(-2);
    language_last.click(function(){
        check_language_other_fields();
    });
    <!-- check if needs to show language other field on load of the page -->
    check_language_other_fields();
});
