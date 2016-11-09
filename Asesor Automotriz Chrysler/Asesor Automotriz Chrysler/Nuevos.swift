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

class Nuevos: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate{

      var emailConsulta: String = ""
    var celular: String = ""
    @IBOutlet weak var webView: UIWebView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let query = PFQuery(className: "datos_contacto")
        query.getObjectInBackground(withId: "H52ZxGm3U8", block: {
            (questionObject: PFObject?, error: NSError?) -> Void in
            
            let webPrestige: AnyObject! = questionObject!.value(forKey: "dato_contacto")
            
            print(webPrestige)
            let url = URL(string: webPrestige as! String)
            let request = URLRequest(url: url!)
            self.webView.loadRequest(request)
            
              })
            
            let query2 = PFQuery(className: "datos_contacto")
            query2.getObjectInBackground(withId: "RYEODVo2Ao", block: {
                (questionObject: PFObject?, error: NSError?) -> Void in
                
                let celularSMS: AnyObject! = questionObject!.value(forKey: "dato_contacto")
                
                self.celular = celularSMS as! String
                
                print(self.celular)
                
          

            
            
            
            
            
            
        })

        
    }
    
    @IBAction func tabBotonCompartir(_ sender: AnyObject) {
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
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
      
       
  }

