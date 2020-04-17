import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor(){}

  empresa;
  reloading(event){
      this.empresa = event;
  }
  ngOnInit(): void {
  }
}



