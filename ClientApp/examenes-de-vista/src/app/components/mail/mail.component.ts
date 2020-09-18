import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { IMailResponse, MailService } from 'src/app/services/mail/mail.service';

@Component({
  selector: 'app-mail',
  templateUrl: './mail.component.html',
  styleUrls: ['./mail.component.css'],
})
export class MailComponent implements OnInit {

  constructor(
    private formBuilder: FormBuilder,
    private mailService: MailService
    ) { }
  
    mailForm: FormGroup;
    mailResponse: IMailResponse;
    isLoading: boolean = false;
  
    ngOnInit(): void {
      this.mailService.GetMails().subscribe(
        r=> {
          this.mailResponse = r;
        }
      );
      
      this.mailForm = this.formBuilder.group({
        sender: ['', Validators.required],
        receiver: ['', Validators.compose([Validators.required, Validators.email])],
        subject: ['', Validators.compose([Validators.required, Validators.minLength(5)])],
        message: ['', Validators.required],
      });
  }

  onSubmit(): void{
    this.isLoading = true;
    let message = '';
    this.mailService.SendMail(this.mailForm.value).subscribe(
      r=>{
        this.mailForm.reset();
        this.isLoading = false;
        window.alert(r)
      },
      error=>{
        this.isLoading = false;
        window.alert(error.error)
      },
      ()=> {
      }
    );
  }

}
