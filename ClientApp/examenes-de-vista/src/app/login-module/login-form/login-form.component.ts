import { Component, OnInit} from '@angular/core';
import { LoginService } from 'src/app/services/login-service.service';
import { Observable } from 'rxjs';
import { IToken } from 'src/app/Interfaces/FolioInterface';

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styleUrls: ['./login-form.component.css']
})
export class LoginFormComponent implements OnInit {

  constructor(private _loginService: LoginService) { }

  imagePath: string = 'assets/img/logo.JPG';
  errorMessage : string;
  userName : string ;
  password: string;
  token: string;

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
        this.token = r.Token
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

  ngOnInit(): void {
  }

}
