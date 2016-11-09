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

class CitaServicio8: UIViewController,UITextViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate{

    
   
   
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
    var receivedComentarios: String = ""
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
        print("Received comentarios=",receivedComentarios)
        
       
        
    
    }
 
  
    @IBAction func sinfotoBoton(_ sender: AnyObject) {
    }

    
    @IBAction func confotoBoton(_ sender: AnyObject) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
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
        
        
        let query = PFQuery(className: "datos_contacto")
        query.getObjectInBackground(withId: "07qMtYtPZy", block: {
            (questionObject: PFObject?, error: NSError?) -> Void in
            
            let webNuevos: AnyObject! = questionObject!.object(forKey: "dato_contacto")
            
            self.emailConsulta  = webNuevos as! String
            
            print(webNuevos)
            
            
        })
        
        
        
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
    
    

 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        print (segue.identifier)
        
        if "cita8aConFoto" == segue.identifier {
            let cita8: CitaServicioConFoto = segue.destination as! CitaServicioConFoto
            
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
            cita8.receivedComentarios = receivedComentarios
            
        }
        if "cita8aSinFoto" == segue.identifier {
            let cita9: CitaServicioSinFoto = segue.destination as! CitaServicioSinFoto
            
            cita9.receivedNombre = receivedNombre
            cita9.receivedEmail = receivedEmail
            cita9.receivedCelular = receivedCelular
            cita9.receivedTelefono = receivedTelefono
            cita9.receivedFecha = receivedFecha
            cita9.receivedHora = receivedHora
            
            cita9.receivedVehiculo = receivedVehiculo
            cita9.receivedAno = receivedAno
            cita9.receivedTipo = receivedTipo
            cita9.receivedKm = receivedKm
            cita9.receivedComentarios = receivedComentarios
            
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
        
        
        let query = PFQuery(className: "datos_contacto")
        query.getObjectInBackground(withId: "TtzeRzvZC5", block: {
            (questionObject: PFObject?, error: NSError?) -> Void in
            
            let webNuevos: AnyObject! = questionObject!.object(forKey: "dato_contacto")
            
            self.emailConsulta  = webNuevos as! String
            
            print(webNuevos)
            
            
        })
        
        
        
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
        
        let query = PFQuery(className: "datos_contacto")
        query.getObjectInBackground(withId: "W7dTN5iDoz", block: {
            (questionObject: PFObject?, error: NSError?) -> Void in
            
            let webNuevos: AnyObject! = questionObject!.value(forKey: "dato_contacto")
            
            print(webNuevos)
            
            
            
            if let phoneCallURL = URL(string: "tel:\(webNuevos)") {
                let application = UIApplication.shared
                if application.canOpenURL(phoneCallURL) {
                    application.openURL(phoneCallURL)
                }
                else{
                    print("failed")
                }
            }
            
            
            
            
            
            
        })
    }
    
    
    
    
       
  }

