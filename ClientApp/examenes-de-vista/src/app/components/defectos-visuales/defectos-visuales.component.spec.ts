import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DefectosVisualesComponent } from './defectos-visuales.component';

describe('DefectosVisualesComponent', () => {
  let component: DefectosVisualesComponent;
  let fixture: ComponentFixture<DefectosVisualesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DefectosVisualesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DefectosVisualesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
