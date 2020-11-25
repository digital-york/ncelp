import React from "react"
import resource_titles from './json/resource_titles.json'
import download_total from './json/downloads_total.json'
import downloads_per_day from './json/downloads_per_day.json'

class ReportGeneral extends React.Component {

  render () {
    return (
      <React.Fragment>
        Total resources: {Object.keys(resource_titles).length}<br/>
        Total downloads: {download_total.total}<br/>
        Downloads over time charts
      </React.Fragment>
    );
  }
}

export default ReportGeneral
