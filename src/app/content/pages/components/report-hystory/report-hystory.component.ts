import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { DomSanitizer } from '@angular/platform-browser';
import { Report } from '../../../../core/models/Report';
import { ReportService } from '../../../../core/services/report.service';
import { User } from '../../../../core/models/User';

@Component({
  selector: 'app-report-hystory',
  templateUrl: './report-hystory.component.html',
  styleUrls: ['./report-hystory.component.scss']
})
export class ReportHystoryComponent implements OnInit {

  map: Map<string, string> = new Map<string, string>();

  reports: Array<Report>;

  userType: number;

  constructor(private reportService: ReportService, private router: Router, private sanitizer: DomSanitizer) { }

  ngOnInit() {

    var user: User = JSON.parse(sessionStorage.getItem("user"));
    this.userType = user.type;
    
    this.map.set('0', "Avviso del gestore");
    this.map.set('1', "Abuso spazio dedicato a persone con disabilità");
    this.map.set('2', "Disservizio stradale");
    this.map.set('3', "Problema riscontrato nell'usufruire del servizio");

    this.onOpenReportHystory();
  }

  //; let mapEntry of mapEntries
  //get mapEntries() { return Array.from(this.map.entries()); }

  onOpenReportHystory(): void{
    this.reportService.onOpenHystory().subscribe((response) => {
        console.log(response);
        this.reports = response;

        this.reports.forEach(report => {
          report.media = <string>this.sanitizer.bypassSecurityTrustUrl(report.media);
        });

    });}

  back(): void
  {
    var user: User = JSON.parse(sessionStorage.getItem("user"));
    if(user.type == 0) this.router.navigateByUrl("/homeOwner");
    if(user.type == 1) this.router.navigateByUrl("/homeDriver");
  }
}
