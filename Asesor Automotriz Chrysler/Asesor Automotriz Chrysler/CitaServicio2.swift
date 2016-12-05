//
//  ViewController.swift
//  Pedro Villarejo App Clientes
//
//  Created by MODESTO VASCO FORNAS on 1/8/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import UIKit
import Parse
import MessageUI

class CitaServicio2: UIViewController,UITextFieldDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {

   
    var receivedNombre: String = ""
    var receivedEmail: String = ""
    var receivedCelular: String = ""
    var receivedTelefono: String = ""
    var receivedFecha: String = ""
    var receivedHora: String = ""
    
    var datePicker:UIDatePicker!
    var datePicker2:UIDatePicker!
    
    var celular: String = ""
    var emailConsulta: String = ""

    @IBOutlet var dateTextField:UITextField!
    
    @IBOutlet weak var timetextField: UITextField!
    @IBAction func compartirButtonTapped(_ sender: AnyObject) {
        let mailComposeViewController2 = configuredMailCompartirViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController2, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailCompartirViewController() -> MFMailComposeViewController {
        
        
       
        
        
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        
        print (emailConsulta)
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject(" Pedro Villarejo App Clientes (iOs)...")
        mailComposerVC.setMessageBody("Te recomiendo descargues Pedro Villarejo App Clientes "+self.emailConsulta, isHTML: false)
        
        return mailComposerVC
    }
    func showSendMailErrorAlert2() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController2(_ controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print("receivedNombre=",receivedNombre)
        
        print("receivedEmail=",receivedEmail)
        
        print("receivedCelular=",receivedCelular)
        
        print("receivedTelefono=",receivedTelefono)
        
        //datePicker
        let customView:UIView = UIView (frame: CGRect(x: 0, y: 100, width: 320, height: 160))
        customView.backgroundColor = UIColor.gray
        
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 320, height: 160))
        datePicker.datePickerMode = UIDatePickerMode.date
        customView .addSubview(datePicker)
        dateTextField.inputView = customView
        let doneButton:UIButton = UIButton (frame: CGRect(x: 100, y: 100, width: 100, height: 44))
        doneButton.setTitle("Seleccione una fecha y pulse aquí", for: UIControlState())
        doneButton.addTarget(self, action: #selector(CitaServicio2.datePickerSelected), for: UIControlEvents.touchUpInside)
        doneButton.backgroundColor = UIColor.green
        
        dateTextField.inputAccessoryView = doneButton
        
        
        //timePicker
        let customView2:UIView = UIView (frame: CGRect(x: 0, y: 100, width: 320, height: 160))
        customView2.backgroundColor = UIColor.gray
        
        datePicker2 = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 320, height: 160))
        datePicker2.datePickerMode = UIDatePickerMode.time
        customView2 .addSubview(datePicker2)
        timetextField.inputView = customView2
        let doneButton2:UIButton = UIButton (frame: CGRect(x: 100, y: 100, width: 100, height: 44))
        doneButton2.setTitle("Seleccione una hora y pulse aquí", for: UIControlState())
        doneButton2.addTarget(self, action: #selector(CitaServicio2.datePickerSelected2), for: UIControlEvents.touchUpInside)
        doneButton2.backgroundColor = UIColor.green
        
        timetextField.inputAccessoryView = doneButton2
    
    
    
    }
    
    
    func datePickerSelected() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        
        dateTextField.text =  strDate
        dateTextField.resignFirstResponder()
        
        
    }
    func datePickerSelected2() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let strDate = dateFormatter.string(from: datePicker2.date)
        
        timetextField.text =  strDate
        
        timetextField.resignFirstResponder()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField == dateTextField {
            timetextField.becomeFirstResponder()
        }
              else {
            timetextField.resignFirstResponder()
        }
        return true
    }
    @IBAction func continuarButton(_ sender: AnyObject) {
        
        
        let fechaCita = dateTextField.text
        let horaCita = timetextField.text
        
        if (fechaCita!.isEmpty || horaCita!.isEmpty){
            
            let myAlert = UIAlertController(title: "Faltan datos", message: "Fecha y hora son obligatorios", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAlert = UIAlertAction(title: "Reintentar", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(OKAlert)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        [self .performSegue(withIdentifier: "cita2a3", sender: self)]

        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        print (segue.identifier)
        print (dateTextField.text)
        if "cita2a3" == segue.identifier {
            let cita3: CitaServicio3 = segue.destination as! CitaServicio3
            
            cita3.receivedNombre = receivedNombre
            cita3.receivedEmail = receivedEmail
            cita3.receivedCelular = receivedCelular
            cita3.receivedTelefono = receivedTelefono
            cita3.receivedFecha = dateTextField.text!
            cita3.receivedHora = timetextField.text!
            
        }
    }
    
    
    @IBAction func sendEmailButtonTapped(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
      
        
        
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        
        print (emailConsulta)
        
        mailComposerVC.setToRecipients([emailConsulta])
        mailComposerVC.setSubject("Enviado desde Pedro Villarejo App Clientes (iOs)...")
        mailComposerVC.setMessageBody("Escriba aqui su texto", isHTML: false)
        
        return mailComposerVC
    }
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func sendSMS(_ sender: AnyObject) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "SMS desde Pedro Villarejo App Clientes (iOs)"
            print (self.celular)
            controller.recipients = [self.celular]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tabBotonLlamar(_ sender: AnyObject) {
        
     
    }
    

   
       
  }

