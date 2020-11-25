import React from "react";
import PropTypes from "prop-types";

import Typography from '@material-ui/core/Typography';

import Accordion from '@material-ui/core/Accordion';
import AccordionSummary from '@material-ui/core/AccordionSummary';
import AccordionDetails from '@material-ui/core/AccordionDetails';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';

import ReportGeneral from "./ReportGeneral";
import ReportDownloadSurvey from "./ReportDownloadSurvey";
import ReportByCategory from "./ReportByCategory";
import ReportPerResource from "./ReportPerResource";

class Report extends React.Component {
  render () {
    return (
      <React.Fragment>

          <Accordion>
              <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel1a-content"
                  id="panel1a-header"
              >
                  <Typography>General information</Typography>
              </AccordionSummary>
              <AccordionDetails>
                  <ReportGeneral/>
              </AccordionDetails>
          </Accordion>
          <Accordion>
              <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel2a-content"
                  id="panel2a-header"
              >
                  <Typography>Download survey</Typography>
              </AccordionSummary>
              <AccordionDetails>
                  <ReportDownloadSurvey/>
              </AccordionDetails>
          </Accordion>
          <Accordion>
              <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel2a-content"
                  id="panel2a-header"
              >
                  <Typography>Download per category</Typography>
              </AccordionSummary>
              <AccordionDetails>
                  <ReportByCategory/>
              </AccordionDetails>
          </Accordion>
          <Accordion>
              <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel2a-content"
                  id="panel2a-header"
              >
                  <Typography>Download per resource</Typography>
              </AccordionSummary>
              <AccordionDetails>
                  <ReportPerResource/>
              </AccordionDetails>
          </Accordion>
        </React.Fragment>
    );
  }
}

export default Report
