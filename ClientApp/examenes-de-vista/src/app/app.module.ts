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
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DefectosVisualesComponent } from './components/defectos-visuales/defectos-visuales.component';
import { ExamenesComponent } from './components/examenes/examenes.component';
import { ExamenUpdateComponent } from './components/examen-update/examen-update.component';
import { ProductsComponent } from './components/products/products.component';
import { SalesComponent } from './components/sales/sales.component';
import { ChartsComponent } from './components/charts/charts.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgxChartsModule } from '@swimlane/ngx-charts';
import { LoadingComponent } from './root-components/loading/loading.component';
import { MailComponent } from './components/mail/mail.component';
import { ServiceWorkerModule } from '@angular/service-worker';
import { environment } from '../environments/environment';
import { UpdateSaleComponent } from './components/update-sale/update-sale.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    LoginFormComponent,
    ListaEmpresasComponent,
    DefectosVisualesComponent,
    ExamenesComponent,
    ExamenUpdateComponent,
    ProductsComponent,
    SalesComponent,
    ChartsComponent,
    LoadingComponent,
    MailComponent,
    UpdateSaleComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    ReactiveFormsModule,
    AppRoutingModule,
    HttpClientModule,
    StoreModule.forRoot({}),
    StoreModule.forFeature('login',reducer),
    StoreModule.forFeature('empresa', reducerEmpresa),
    RouterModule.forRoot([
      {path: 'Login', component: LoginFormComponent},
      {path: 'Empresas', component: ListaEmpresasComponent},
      {path: 'Defectos', component: DefectosVisualesComponent},
      {path: 'Examenes', component: ExamenesComponent},
      {path: 'Examenes/Actualiza', component: ExamenUpdateComponent},
      {path: 'Productos', component: ProductsComponent},
      {path: 'Ventas', component: SalesComponent},
      {path: 'Resumen', component: ChartsComponent},
      {path: 'Mail', component: MailComponent},
      {path: '**', redirectTo: '/Empresas'},
      {path: '', redirectTo: '/Empresas', pathMatch: 'full'}
    ]),
    BrowserAnimationsModule,
    NgxChartsModule,
    ServiceWorkerModule.register('ngsw-worker.js', { enabled: environment.production })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
