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

    // ---------------------------------------------------
    // show/hide other Pedagogical focus fields
    function check_pedagogical_other_fields() {
        var t = $('#resource_area_of_research option').filter(':selected').text();
        if(t.endsWith('Other')) {
            $("#area_of_research_other_div").css("display","block");
        }else{
            $("#area_of_research_other_div").css("display","none");
        }
    }
    <!-- Show hiden 'other' Pedagogical focus field -->
    $("#resource_area_of_research").click(function(){
        check_pedagogical_other_fields();
    });
    <!-- check if needs to show Pedagogical focus other field on load of the page -->
    check_pedagogical_other_fields();

    // ---------------------------------------------------
    // show/hide other material_for_teachers fields
    function check_material_for_teachers_other_fields() {
        if($('[id^=resource_material_for_teachers_]').eq(-2).is(':checked')) {
            $("#material_for_teachers_other_div").css("display","block");
        }else{
            $("#material_for_teachers_other_div").css("display","none");
        }
    }
    <!-- Show hiden 'other' material_for_teachers field -->
    var material_for_teachers_last = $("[id^=resource_material_for_teachers_]").eq(-2);
    material_for_teachers_last.click(function(){
        check_material_for_teachers_other_fields();
    });
    <!-- check if needs to show Pedagogical focus other field on load of the page -->
    check_material_for_teachers_other_fields();
});
