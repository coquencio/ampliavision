import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginFormComponent } from './login-form/login-form.component';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { StoreModule } from '@ngrx/store';
import { reducer } from './state/login.reducer';



@NgModule({
  declarations: [LoginFormComponent],
  imports: [
    CommonModule,
    FormsModule,
    RouterModule.forRoot([
      {path: 'Login', component: LoginFormComponent}
    ]),
    StoreModule.forFeature('login', reducer)
  ]
})
export class LoginModule { }
