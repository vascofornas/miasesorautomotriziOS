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

class CitaServicio1: UIViewController,UITextFieldDelegate, MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {

   
    
    @IBOutlet weak var nombreTextField: UITextField!
   
 
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var celularTextField: UITextField!
    
    @IBOutlet weak var telefonoTextField: UITextField!
    var celular: String = ""
    var emailConsulta: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateEmail(_ candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField == nombreTextField {
            emailTextField.becomeFirstResponder()
        }
        if textField == emailTextField {
            celularTextField.becomeFirstResponder()
        }
        if textField == celularTextField {
            telefonoTextField.becomeFirstResponder()
        }
        else {
            telefonoTextField.resignFirstResponder()
        }
        return true
    }
    
   
    @IBAction func continuarButton(_ sender: AnyObject) {
        
        
        let nombreCliente = nombreTextField.text
        let emailCliente = emailTextField.text
        
        
        if (nombreCliente!.isEmpty || emailCliente!.isEmpty ){
            
            let myAlert = UIAlertController(title: "Faltan datos", message: "Nombre y email son obligatorios", preferredStyle: UIAlertControllerStyle.alert)
 
            let OKAlert = UIAlertAction(title: "Reintentar", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(OKAlert)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if (!validateEmail(emailCliente!)){
            let myAlert = UIAlertController(title: "Email no es correcto", message: "Por favor, compruebe el formato de su email", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAlert = UIAlertAction(title: "Reintentar", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(OKAlert)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
            
        }
         [self .performSegue(withIdentifier: "cita1a2", sender: self)]
        
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
     
        
        if "cita1a2" == segue.identifier {
        let cita2: CitaServicio2 = segue.destination as! CitaServicio2
        
        cita2.receivedNombre = nombreTextField.text!
        cita2.receivedEmail = emailTextField.text!
        cita2.receivedCelular = celularTextField.text!
        cita2.receivedTelefono = telefonoTextField.text!
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
    
    

    
  }

