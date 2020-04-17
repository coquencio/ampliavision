import { Component, OnInit} from '@angular/core';
import { Store, select } from '@ngrx/store';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  constructor(
    private store: Store<any>,
    private router: Router
    ) { }
  
  nombreEmpresa: string;
  empresaId: number;
  
  ngOnInit(): void {
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
