import React from "react";
import { makeStyles } from '@material-ui/core/styles';
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

const classes = makeStyles((theme) => ({
    root: {
        width: '100%',
    },
    heading: {
        fontSize: theme.typography.pxToRem(15),
        fontWeight: theme.typography.fontWeightMedium,
    },
}));

class Report extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div className={classes.root}>
          <Accordion>
              <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel1a-content"
                  id="panel1a-header"
              >
                  <Typography className={classes.heading}>General information</Typography>
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
                  <Typography className={classes.heading}>Download survey</Typography>
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
                  <Typography className={classes.heading}>Download per category</Typography>
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
                  <Typography className={classes.heading}>Download per resource</Typography>
              </AccordionSummary>
              <AccordionDetails>
                  <ReportPerResource/>
              </AccordionDetails>
          </Accordion>
        </div>
        </React.Fragment>
    );
  }
}

export default Report
