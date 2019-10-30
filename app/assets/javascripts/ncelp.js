//= require jquery-ui/widgets/accordion

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

    // --------------------------------------------------------
    // Activate/deactivate download survey save button
    // By default, disable submit button on survey form
    // $('#survey_form_submit').attr('disabled','true');

    // Toggle submit button, depending on if the checkboxes are ticked
    // $("[name='survey[status][]']").on("click", function() {
    //     if( $("input[name='survey[status][]']:checked").length > 0 &&
    //         $("#summary_participants_country :selected").text().length > 0 ) {
    //     // ) {
    //         $('#survey_form_submit').removeAttr('disabled');
    //     }else{
    //         $('#survey_form_submit').attr('disabled','true');
    //     }
    // });
    // Toggle submit button, depending on if the country is selected
    // $("#summary_participants_country").on("click", function() {
    //     if( $("#summary_participants_country :selected").text().length > 0 &&
    //         $("input[name='survey[status][]']:checked").length > 0  ) {
    //         $('#survey_form_submit').removeAttr('disabled');
    //     }else{
    //         $('#survey_form_submit').attr('disabled','true');
    //     }
    // });


    $('#surveyform').on('submit',function(e){
        if( $('div.checkbox-group.required :checkbox:checked').length == 0 )
        {
            // Stop the form from being send
            e.preventDefault();

            // Add an alert
            $('#aboutyou').addClass('alert-danger');

            // First find the iframe by class name - sinds the ID is nog unique :(
            var iframe = parent.window.document.getElementsByClassName("fancybox-iframe");

            // If no checkbox is selected scroll up and show error message.
            $(iframe).contents().find("html, body").animate({ scrollTop: 0 }, { duration: 'medium', easing: 'swing' });

            // Remove the alert message when checkbox is checked
            $('div.checkbox-group.required :checkbox').on('click', function(e){
                $('#aboutyou').removeClass('alert-danger');
            });
        }
    });

    /* Enable tab buttons and changing button status */
    var tab_buttons = $('.tab-buttons > .btn');
    $.each(tab_buttons, function(i,btn){
        $(btn).on('click',function(){
            tab_buttons.removeClass('btn-primary');
            tab_buttons.addClass('btn-default');
            $(this).addClass('btn-primary');
        })
    });


    /**
     * Use the accordion effect on the resource details page to hide the details.
     */
    $("#accordion").accordion({
        active: false,
        collapsible: true
    });

});
