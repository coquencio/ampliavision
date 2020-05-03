import { TestBed } from '@angular/core/testing';

import { OjosService } from './ojos.service';

describe('OjosService', () => {
  let service: OjosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(OjosService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
