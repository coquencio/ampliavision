import { TestBed } from '@angular/core/testing';

import { ArmazonesService } from './armazones.service';

describe('ArmazonesService', () => {
  let service: ArmazonesService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ArmazonesService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
