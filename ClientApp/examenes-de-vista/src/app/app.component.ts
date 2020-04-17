import { Component } from '@angular/core';
import { AuthorizationService } from './services/authorization/authorization.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor(
    private authorizationService: AuthorizationService,
    private router: Router 
  ){}
  
  islogged: boolean;
  ngOnInit(): void {
    this.islogged = this.authorizationService.IsLogged();
    if (!this.islogged){
      this.router.navigate(['/Login']);
    }
  }
}



