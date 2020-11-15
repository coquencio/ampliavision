import { Component, OnInit} from '@angular/core';
import { Store, select } from '@ngrx/store';
import { Router } from '@angular/router';
import { AuthorizationService } from 'src/app/services/authorization/authorization.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {

  constructor(
    private store: Store<any>,
    private router: Router,
    private authorizationService: AuthorizationService
    ) {
    }
  
  nombreEmpresa: string;
  empresaId: number;
  islogged: boolean;
  navButton: HTMLElement;

  ngOnInit(): void {
    this.islogged = this.authorizationService.IsLogged();
    if (!this.islogged){
      this.router.navigate(['/Login']);
    }
    else {
      this.store.pipe(select('empresa')).subscribe(
        e => {
          if (e){
            this.nombreEmpresa = e.nombreEmpresa;
          }
        }
      );
      if (!this.nombreEmpresa){
        this.router.navigate(['Empresas']);
      }
    }
  }
  ngAfterViewInit(){
    this.navButton = document.getElementById('navbar-toggle-button');
  }
  LogOut(){
    localStorage.setItem('token', '');
    window.location.href = "/";
  } 
  BrowseNavbar(){
    window.scroll(0,0);
    if (this.navButton && this.navButton.getAttribute('aria-expanded')){
      this.navButton.click();
    } 
  }
}
