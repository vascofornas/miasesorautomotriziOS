//
//  ViewController.swift
//  Pedro Villarejo App Clientes
//
//  Created by MODESTO VASCO FORNAS on 1/8/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import UIKit
import Parse
import Foundation
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate{

    var celular: String = ""
   var emailConsulta: String = ""
    var apple: String = ""
    var id_agencia: String = ""
    var nombre_agencia: String = ""
    var codigo_agencia: String = ""
    var nombre_asesor: String = ""
    var id_asesor: String = ""
    var agencia_asesor: String = ""
    var email_asesor: String = ""
    var codigo_asesor: String = ""
    
    let misDatos:UserDefaults = UserDefaults.standard
 @IBOutlet weak var AsesorTXT: UILabel!
    
    @IBOutlet weak var actionSeminuevosButton: UIButton!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print ("ESTOY EN PORTADA")
        
        id_agencia = misDatos.string(forKey: "ID_AGENCIA")!
        print ("ID AGENCIA:",id_agencia)
        nombre_agencia = misDatos.string(forKey: "NOMBRE_AGENCIA")!
        print ("NOMBRE AGENCIA:",nombre_agencia)
        codigo_agencia = misDatos.string(forKey: "CODIGO_AGENCIA")!
        print ("CODIGO AGENCIA:",codigo_agencia)
        id_asesor = misDatos.string(forKey: "ID_ASESOR")!
        print ("ID ASESOR:",id_asesor)
        nombre_asesor = misDatos.string(forKey: "NOMBRE_ASESOR")!
        print ("NOMBRE ASESOR:",nombre_asesor)
        codigo_asesor = misDatos.string(forKey: "CODIGO_ASESOR")!
        print ("CODIGO ASESOR:",codigo_asesor)
        email_asesor = misDatos.string(forKey: "EMAIL_ASESOR")!
        print ("EMAIL ASESOR:",email_asesor)
        
        self.AsesorTXT.text = self.nombre_asesor;
        
        //buscamos id del iphone
        
        
        
        if let key = misDatos.string(forKey: "ID_IPHONE"){
            
            print ("iphone id existe")
        }
        else {
             print ("iphone id NO existe")
            let mi_movil = randomStringWithLength (8)
            misDatos.set(mi_movil, forKey: "ID_IPHONE")
            print ("IPHONE ID:",mi_movil)
        }
        
        
        
        
        
        
        
     
        
    
    
    
    }
    
    
    
    func randomStringWithLength (_ len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for i in (0 ..< len){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func botonLlamarCFCredit (_ sender: AnyObject) {
        
      
    }
    

    @IBAction func botonLlamarTab(_ sender: AnyObject) {
        
        
    }
    

    

    

  
    
    @IBAction func botonSeminuevos(_ sender: AnyObject) {
        
      
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
       
        mailComposerVC.setToRecipients([self.emailConsulta])
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
    
    //
    
    
    //
    
    
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
        mailComposerVC.setMessageBody("Te recomiendo descargues Pedro Villarejo App Clientes "+self.apple, isHTML: false)
        
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

