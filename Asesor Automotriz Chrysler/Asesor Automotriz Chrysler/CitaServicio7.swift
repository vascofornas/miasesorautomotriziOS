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

class CitaServicio7: UIViewController,UITextViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var anoLabel: UILabel!
    @IBOutlet weak var vehiculoLabel: UILabel!
    @IBOutlet weak var telefonoLabel: UILabel!
    @IBOutlet weak var celularLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var horaLabel: UILabel!
   
    @IBOutlet weak var comentariosTextField: UITextView!
    var receivedNombre: String = ""
    var receivedEmail: String = ""
    var receivedCelular: String = ""
    var receivedTelefono: String = ""
    var receivedFecha: String = ""
    var receivedHora: String = ""
    var receivedVehiculo: String = ""
    var receivedAno: String = ""
    var receivedTipo: String = ""
    var receivedKm: String = ""
    var celular: String = ""
    var emailConsulta: String = ""
    
    
    
 
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
        print("receivedTipo=",receivedTipo)
        print("receivedKm=",receivedKm)
        
        nombreLabel.text = receivedNombre
        emailLabel.text = receivedEmail
        celularLabel.text = receivedCelular
        telefonoLabel.text = receivedTelefono
        fechaLabel.text = receivedFecha
        horaLabel.text = receivedHora
        vehiculoLabel.text =  receivedVehiculo
        anoLabel.text = receivedAno
        tipoLabel.text =  receivedTipo
        kmLabel.text =  receivedKm
        
        comentariosTextField.delegate = self
        
    
    }
 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            comentariosTextField.resignFirstResponder()
            return false
        }
        return true
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    @IBAction func continuarButton(_ sender: AnyObject) {
        
        
       
        
        
        [self .performSegue(withIdentifier: "cita7a8", sender: self)]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        print (segue.identifier)
        
        if "cita7a8" == segue.identifier {
            let cita8: CitaServicio8 = segue.destination as! CitaServicio8
            
            cita8.receivedNombre = receivedNombre
            cita8.receivedEmail = receivedEmail
            cita8.receivedCelular = receivedCelular
            cita8.receivedTelefono = receivedTelefono
            cita8.receivedFecha = receivedFecha
            cita8.receivedHora = receivedHora
            
            cita8.receivedVehiculo = receivedVehiculo
            cita8.receivedAno = receivedAno
            cita8.receivedTipo = receivedTipo
            cita8.receivedKm = receivedKm
            cita8.receivedComentarios = comentariosTextField.text
            
            
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

