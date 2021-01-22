// Callbacks for tracking events using Google Analytics

// Note: there is absence of testing here.  I'm not sure how or to what extent we can test what's getting
// sent to Google Analytics.

$(document).on('click', '#file_download', function(e) {
  _gaq.push(['_trackEvent', 'Files', 'Downloaded', $(this).data('label')]);
  //console.log(`Hey onclick Files _trackEvent() push ${$(this).data('label')}`)

  // send languages info to GA
  let languages = $('#resource_languages').val();
  if(languages) {
    languages.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Languages', 'Downloaded', item]);
      console.log("Languages -> " + item);
    });
  }

  // resource_type_of_materials
  let type_of_materials = $('#resource_type_of_materials').val();
  if(type_of_materials) {
    type_of_materials.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Type_of_materials', 'Downloaded', item]);
      console.log("Type_of_materials -> " + item);
    });
  }

  // resource_ages
  let resource_ages = $('#resource_ages').val();
  if(resource_ages) {
    resource_ages.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Ages', 'Downloaded', item]);
      console.log("Ages -> " + item);
    });
  }

  // resource_pedagogical_focus
  let pedagogical_focus = $('#resource_pedagogical_focus').val();
  if(pedagogical_focus) {
    pedagogical_focus.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Pedagogical_focus', 'Downloaded', item]);
      console.log("Pedagogical_focus -> " + item);
    });
  }

  // resource_material_for_teacher
  let material_for_teacher = $('#resource_material_for_teacher').val();
  if(material_for_teacher) {
    material_for_teacher.split("|").forEach(function (item, index) {
      _gaq.push(['_trackEvent', 'Material_for_teacher', 'Downloaded', item]);
      console.log("Material_for_teacher -> " + item);
    });
  }

});

$(document).on('click', '#collection_download_all', function(e) {
  //data-label - collection resource id
  //data-value - number of file resources zipped in the collection bundle
  _gaq.push(['_trackEvent', 'Collections', 'Downloaded', $(this).data('label'), $(this).data('value')]);
  //console.log(`Hey onclick Collections _trackEvent() push ${$(this).data('label')} including ${$(this).data('int')}`)
    
});
