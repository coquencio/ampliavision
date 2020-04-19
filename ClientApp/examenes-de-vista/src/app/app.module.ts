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
import { EstatusGeneralComponent } from './components/estatus-general/estatus-general.component';
import { DefectosVisualesComponent } from './components/defectos-visuales/defectos-visuales.component';
import { ExamenesComponent } from './components/examenes/examenes.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    LoginFormComponent,
    ListaEmpresasComponent,
    EstatusGeneralComponent,
    DefectosVisualesComponent,
    ExamenesComponent
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
      {path: 'Defectos', component: DefectosVisualesComponent},
      {path: 'General', component: EstatusGeneralComponent},
      {path: 'Examenes', component: ExamenesComponent},
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
