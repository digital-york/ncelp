// Callbacks for tracking events using Google Analytics

// Note: there is absence of testing here.  I'm not sure how or to what extent we can test what's getting
// sent to Google Analytics.

$(document).on('click', '#file_download', function(e) {
  let ga4PropertyId = $("#ga4_property_id").val();
  gtag("event", "Downloaded", {
    send_to: ga4PropertyId,
    event_category: "Files",
    event_label: $(this).data("label")
  }); 
  
//
  // send languages info to GA
  let languages = $('#resource_languages').val();
  if(languages) {
    languages.split("|").forEach(function (item, index) {      
      gtag("event", "Metadata", {
        send_to: ga4PropertyId,
        event_category: "Languages",
        event_label: item,
        non_interaction: true
      });
    });
  }

  // resource_type_of_materials
  let type_of_materials = $('#resource_type_of_materials').val();
  if(type_of_materials) {
    type_of_materials.split("|").forEach(function (item, index) {
      gtag("event", "Metadata", {
        send_to: ga4PropertyId,
        event_category: "Type_of_materials",
        event_label: item,
        non_interaction: true
      });
    });
  }

  // resource_ages
  let resource_ages = $('#resource_ages').val();
  if(resource_ages) {
    resource_ages.split("|").forEach(function (item, index) {
      gtag("event", "Metadata", {
        send_to: ga4PropertyId,
        event_category: "Ages",
        event_label: item,
        non_interaction: true
      });
    });
  }

  // resource_pedagogical_focus
  let pedagogical_focus = $('#resource_pedagogical_focus').val();
  if(pedagogical_focus) {
    pedagogical_focus.split("|").forEach(function (item, index) {
      gtag("event", "Metadata", {
        send_to: ga4PropertyId,
        event_category: "Pedagogical_focus",
        event_label: item,
        non_interaction: true
      });
    });
  }

  // resource_material_for_teacher
  let material_for_teacher = $('#resource_material_for_teacher').val();
  if(material_for_teacher) {
    material_for_teacher.split("|").forEach(function (item, index) {
      gtag("event", "Metadata", {
        send_to: ga4PropertyId,
        event_category: "Material_for_teacher",
        event_label: item,
        non_interaction: true
      });
    });
  }

});

$(document).on('click', '#collection_download_all', function(e) {
  //data-label - collection resource id
  //data-value - number of file resources zipped in the collection bundle
  let data_label = $(this).data('label');
  let ga4PropertyId = $("#ga4_property_id").val();
  if(typeof data_label !== 'undefined') {
    gtag("event", "Downloaded", {
      send_to: ga4PropertyId,
      event_category: "Collections",
      event_label: $(this).data('label'),
      value: $(this).data('value'),
      non_interaction: true
    });
  }
});
