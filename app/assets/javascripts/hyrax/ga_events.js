// Callbacks for tracking events using Google Analytics

// Note: there is absence of testing here.  I'm not sure how or to what extent we can test what's getting
// sent to Google Analytics.

$(document).on('click', '#file_download', function(e) {
  _gaq.push(['_trackEvent', 'Files', 'Downloaded', $(this).data('label'), 1]);

  // send languages info to GA
  let languages = $('#resource_languages').val();
  if(languages) {
    languages.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Languages', 'Metadata', item, ,true]);
    });
  }

  // resource_type_of_materials
  let type_of_materials = $('#resource_type_of_materials').val();
  if(type_of_materials) {
    type_of_materials.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Type_of_materials', 'Metadata', item, , true]);
    });
  }

  // resource_ages
  let resource_ages = $('#resource_ages').val();
  if(resource_ages) {
    resource_ages.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Ages', 'Metadata', item, ,true]);
    });
  }

  // resource_pedagogical_focus
  let pedagogical_focus = $('#resource_pedagogical_focus').val();
  if(pedagogical_focus) {
    pedagogical_focus.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Pedagogical_focus', 'Metadata', item, ,true]);
    });
  }

  // resource_material_for_teacher
  let material_for_teacher = $('#resource_material_for_teacher').val();
  if(material_for_teacher) {
    material_for_teacher.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Material_for_teacher', 'Metadata', item, ,true]);
    });
  }

});

$(document).on('click', '#collection_download_all', function(e) {
  //data-label - collection resource id
  //data-value - number of file resources zipped in the collection bundle
  let data_label = $(this).data('label');
  if(typeof data_label !== 'undefined') {
    _gaq.push(['_trackEvent', 'Collections', 'Downloaded', $(this).data('label'), $(this).data('value')]);
  }
});
