import { Component, OnInit} from '@angular/core';
import { LoginService } from 'src/app/services/login/login-service.service';
import { Store } from '@ngrx/store';
import { Router } from '@angular/router';
import { AuthorizationService } from 'src/app/services/authorization/authorization.service';

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styleUrls: ['./login-form.component.css']
})
export class LoginFormComponent implements OnInit {

  constructor(
    private _loginService: LoginService,
     private store:Store<any>,
     private router: Router,
     private authorizationService: AuthorizationService) { }
  
  imagePath: string = 'assets/img/logo.JPG';
  errorMessage : string;
  userName : string ;
  password: string;
  token: string;
  ngOnInit(): void {
    this.authorizationService.authorize()
  }

  private validateFields(): boolean{
    if (this.userName == undefined || this.userName == ''){
      this.errorMessage = "Nombre de usuario requerido"
      return false;
    }
    if (this.userName.length < 5){
      this.errorMessage="Usuario debe de contener más de 5 caracteres"
      return false;
    }
    if(this.password == undefined || this.password == ''){
      this.errorMessage="Contraseña requerida"
      return false;
    }
    return true;
  } 

  private getToken(user: String, password: String) : void{
    this._loginService.Login(user, password).subscribe(
      r => {
        this.token = r.Token;
        this.store.dispatch({
          type:'SET_TOKEN',
          payload: r.Token
        });
        console.log('ok')
        this.router.navigate(['Inicio']);
      },
      err=>{
        this.errorMessage = err.error;
      }
    );
  }

  login(): void{
    if (this.validateFields()){
      this.getToken(this.userName, this.password);
    }
  }
}
