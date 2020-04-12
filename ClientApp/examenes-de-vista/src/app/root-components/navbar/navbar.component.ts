import { Component, OnInit } from '@angular/core';
import { AuthorizationService } from 'src/app/services/authorization/authorization.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  constructor(
    private authorizationService: AuthorizationService,
    private router: Router) { }

  islogged: boolean;
  ngOnInit(): void {
    this.islogged = this.authorizationService.IsLogged();
    if (!this.islogged){
      this.router.navigate(['/Login']);
    }
  }
}
