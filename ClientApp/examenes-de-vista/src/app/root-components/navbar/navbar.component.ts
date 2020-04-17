import { Component, OnInit, Input } from '@angular/core';
import { AuthorizationService } from 'src/app/services/authorization/authorization.service';
import { Router } from '@angular/router';
import { Store, select } from '@ngrx/store';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  constructor(
    private authorizationService: AuthorizationService,
    private router: Router,
    private store: Store<any>) { }
  
  islogged: boolean;
  @Input() nombreEmpresa: string;
  @Input() empresaId: number;
  
  ngOnInit(): void {
    this.islogged = this.authorizationService.IsLogged();
    if (!this.islogged){
      this.router.navigate(['/Login']);
    }

    this.store.pipe(select('empresas')).subscribe(
      e => {
        if (e){
          this.nombreEmpresa = e.nombreEmpresa;
        }
      }
    );
  }
}
