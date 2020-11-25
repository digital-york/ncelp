import React from "react"
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';

import downloads_per_status from './json/downloads_per_status.json'

class ReportDownloadSurvey extends React.Component {
  render () {
    return (
      <React.Fragment>
        <TableContainer component={Paper}>
          <Table aria-label="Download per status">
            <TableHead>
              <TableRow>
                <TableCell>Status</TableCell>
                <TableCell align="right">Downloads</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {Object.entries(downloads_per_status).map((row) => (
                  <TableRow key={row[0]}>
                    <TableCell component="th" scope="row">
                      {row[0]}
                    </TableCell>
                    <TableCell align="right">{row[1]}</TableCell>
                  </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </React.Fragment>
    );
  }
}

export default ReportDownloadSurvey
