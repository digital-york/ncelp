// Callbacks for tracking events using Google Analytics

// Note: there is absence of testing here.  I'm not sure how or to what extent we can test what's getting
// sent to Google Analytics.

$(document).on('click', '#file_download', function(e) {
  _gaq.push(['_trackEvent', 'Files', 'Downloaded', $(this).data('label')]);
  //console.log(`Hey onclick Files _trackEvent() push ${$(this).data('label')}`)
    
});

$(document).on('click', '#collection_download_all', function(e) {
  //data-label - collection resource id
  //data-value - number of file resources zipped in the collection bundle
  _gaq.push(['_trackEvent', 'Collections', 'Downloaded', $(this).data('label'), $(this).data('value')]);
  //console.log(`Hey onclick Collections _trackEvent() push ${$(this).data('label')} including ${$(this).data('int')}`)
    
});
