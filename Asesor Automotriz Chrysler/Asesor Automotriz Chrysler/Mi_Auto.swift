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
import Alamofire



class Mi_Auto: UIViewController,UITextFieldDelegate, MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, HomeModelProtocal {

   
   
    var celular: String = ""
    var emailConsulta: String = ""
    var apple: String = ""
    
    var modeloAuto: String = ""
    var anoAuto: String = ""
    var idAuto: String = ""
  
    
    @IBOutlet weak var listTableView: UITableView!
  
    var feedItems: NSArray = NSArray()
    var selectedLocation : MiAutoModel = MiAutoModel()
    
   
   
    
    let misDatos:UserDefaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        
       self.cargarAutos()
       print ("estoy en mi_auto")
        
  
    }
    func viewDidAppear() {
     
       
        print ("ESTOY EN VIEW DID APPEAR")
        
        self.cargarAutos()
    
        
        
        
    }


    func cargarAutos(){
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
         self.listTableView.reloadData()
    }
    
    func itemsDownloaded(_ items: NSArray) {
        
        feedItems = items
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve cell
      
        let cellIdentifier: String = "BasicCell"
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AutosTableViewCell
        // Get the location to be shown
        let item: MiAutoModel = feedItems[indexPath.row] as! MiAutoModel
        // Get references to labels of cell
        myCell.modeloLabel.text = item.modelo
        myCell.anoLabel.text = item.ano
        
        return myCell
    }
    
    
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle(), title: "Eliminar auto") { (action, indexPath) in
            // delete item at indexPath
            
            let item: MiAutoModel = self.feedItems[indexPath.row] as! MiAutoModel
            print ("boton borrar pulsado-->",item.modelo)
            
            
            
            // Create the alert controller
            var alertController = UIAlertController(title: "Eliminar Auto?", message: item.modelo!+" - "+item.ano!, preferredStyle: .alert)
            
            // Create the actions
            var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
               
                
                Alamofire.request(.POST, "http://www.miasesorautomotriz.com/php_mobile/borrar_mi_auto.php", parameters: ["id": item.id_mis_autos!]).responseJSON { response in
                    
                }
              
                self.cargarAutos()
                
                
            }
            var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
          
            
            self.present(alertController, animated: true, completion: nil)
             self.cargarAutos()
            
        }
        
    
        
        return [delete]
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let item: MiAutoModel = self.feedItems[indexPath.row] as! MiAutoModel
        
        
        modeloAuto = item.modelo!
        anoAuto = item.ano!
        idAuto = item.id_mis_autos!
        
        print ("boton  pulsado-->",item.modelo)
        print ("boton  pulsado-->",item.id_mis_autos)
        print ("boton  pulsado-->",item.ano)
        [self .performSegue(withIdentifier: "ir_auto", sender: self)]
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }

    func buttonAction(_ sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            //do anything here
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        if "ir_auto" == segue.identifier {
            let portada: Mi_Auto_Portada = segue.destination as! Mi_Auto_Portada
            
            portada.modeloAuto = modeloAuto
            portada.anoAuto = anoAuto
            portada.idAuto = idAuto
          
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateEmail(_ candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
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
    
    

    
  }

