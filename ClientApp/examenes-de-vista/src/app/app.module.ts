import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { StoreModule } from '@ngrx/store';
import { RouterModule } from '@angular/router';
import { NavbarComponent } from './root-components/navbar/navbar.component';
import { LoginFormComponent } from './components/login-form/login-form.component';
import { reducer } from './core/state/login.reducer';
import { ListaEmpresasComponent } from './components/lista-empresas/lista-empresas.component';
import { reducerEmpresa } from './core/state/empresa.reducer';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    LoginFormComponent,
    ListaEmpresasComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpClientModule,
    StoreModule.forRoot({}),
    StoreModule.forFeature('login',reducer),
    StoreModule.forFeature('empresa', reducerEmpresa),
    RouterModule.forRoot([
      {path: 'Login', component: LoginFormComponent},
      {path: 'Empresas', component: ListaEmpresasComponent},
      {path: '', redirectTo:'Empresas', pathMatch:'full'},
      {path: '**', redirectTo:'Empresas', pathMatch:'full'}
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
