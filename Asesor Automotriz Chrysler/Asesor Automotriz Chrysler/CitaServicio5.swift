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

class CitaServicio5: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {

   
    var receivedNombre: String = ""
    var receivedEmail: String = ""
    var receivedCelular: String = ""
    var receivedTelefono: String = ""
    var receivedFecha: String = ""
    var receivedHora: String = ""
    var receivedVehiculo: String = ""
    var receivedAno: String = ""
    var celular: String = ""
    var emailConsulta: String = ""
    
    @IBOutlet weak var motivoPickerView: UIPickerView!

    @IBOutlet var motivoTextField:UITextField!
    
    var pickerString:NSMutableArray = []
    
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
        
        print("receivedFecha=",receivedFecha)
        
        print("receivedHora=",receivedHora)
        
        print("receivedVehiculo=",receivedVehiculo)
        
         print("receivedAno=",receivedAno)
        
       
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.pickerString.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        return self.pickerString[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.motivoTextField.text  = (self.pickerString[row] as! String)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    //@available(iOS 8.0, *)
    @IBAction func continuarButton(_ sender: AnyObject) {
        
        
        let motivoCita = motivoTextField.text
      
        
        if (motivoCita!.isEmpty ){
            
            let myAlert = UIAlertController(title: "Faltan datos", message: "El tipo de la cita es obligatorio", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAlert = UIAlertAction(title: "Reintentar", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(OKAlert)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        [self .performSegue(withIdentifier: "cita5a6", sender: self)]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        print (segue.identifier)
        print (motivoTextField.text)
        if "cita5a6" == segue.identifier {
            let cita6: CitaServicio6 = segue.destination as! CitaServicio6
            
            cita6.receivedNombre = receivedNombre
            cita6.receivedEmail = receivedEmail
            cita6.receivedCelular = receivedCelular
            cita6.receivedTelefono = receivedTelefono
            cita6.receivedFecha = receivedFecha
            cita6.receivedHora = receivedHora
            cita6.receivedVehiculo = receivedVehiculo
            cita6.receivedAno = receivedAno
            cita6.receivedTipo = motivoTextField.text!
            
            
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

