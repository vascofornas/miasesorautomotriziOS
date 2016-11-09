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

class CostoServicio2: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {

   
    var receivedNombre: String = ""
    var receivedEmail: String = ""
    var receivedCelular: String = ""
    var receivedTelefono: String = ""
    var celular: String = ""
    var emailConsulta: String = ""
    
    @IBOutlet weak var vehiculoPickerView: UIPickerView!

    @IBOutlet var vehiculoTextField:UITextField!
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("receivedNombre=",receivedNombre)
        
        print("receivedEmail=",receivedEmail)
        
        print("receivedCelular=",receivedCelular)
        
        print("receivedTelefono=",receivedTelefono)
        
       
        
        let query = PFQuery(className: "autos")
      
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                
                for object in objects! {
                    
                    print (object["modelo"])
                    
                    self.pickerString.add(object["modelo"] as! String)
                    self.vehiculoTextField.text = (object["modelo"] as! String)
                }
                
            }
             self.vehiculoPickerView.reloadAllComponents()
            
            self.vehiculoTextField.text = self.pickerString[0] as? String
        })
    
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
        self.vehiculoTextField.text  = self.pickerString[row] as? String
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func continuarButton(_ sender: AnyObject) {
        
        
        let vehiculoCita = vehiculoTextField.text
        
        if (vehiculoCita!.isEmpty ){
            
            let myAlert = UIAlertController(title: "Faltan datos", message: "Su vehiculo es obligatorio", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAlert = UIAlertAction(title: "Reintentar", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(OKAlert)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        [self .performSegue(withIdentifier: "costo2a3", sender: self)]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
       
        if "costo2a3" == segue.identifier {
            let costo3: CostoServicio3 = segue.destination as! CostoServicio3
            
            costo3.receivedNombre = receivedNombre
            print (receivedNombre)
            costo3.receivedEmail = receivedEmail
            print (receivedEmail)
            costo3.receivedCelular = receivedCelular
            print (receivedCelular)
            costo3.receivedTelefono = receivedTelefono
            print (receivedTelefono)
            costo3.receivedVehiculo = vehiculoTextField.text!
            print (vehiculoTextField.text)
            
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

