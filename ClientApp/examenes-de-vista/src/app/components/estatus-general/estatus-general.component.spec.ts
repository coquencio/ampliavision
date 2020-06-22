import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EstatusGeneralComponent } from './estatus-general.component';

describe('EstatusGeneralComponent', () => {
  let component: EstatusGeneralComponent;
  let fixture: ComponentFixture<EstatusGeneralComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EstatusGeneralComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EstatusGeneralComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
