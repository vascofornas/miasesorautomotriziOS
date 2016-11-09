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

class CitaServicioConFoto: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate{

   
    
   
    @IBOutlet weak var botonContinuar: UIButton!
    @IBOutlet weak var botonEnviar: UIButton!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    
    let picker = UIImagePickerController()
   
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
    var codigo: String = ""
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
        
       picker.delegate = self
        
        botonEnviar.isHidden=true
        botonContinuar.isHidden=true
        
        codigo = self.randomStringWithLength(8) as String
    
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
    
    

    @IBAction func selectPhotoButtonTapped(_ sender: AnyObject) {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.botonEnviar.isHidden=false
        present(picker, animated: true, completion: nil)
    

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
 
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .scaleAspectFit //3
        myImageView.image = resizeImage(chosenImage, newWidth: 1000)
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
 
    @IBAction func subirFoto(_ sender: AnyObject) {
        
            
            if myImageView.image == nil {
                //image is not included alert user
                print("Image not uploaded")
            }else {
                myActivityIndicator.startAnimating();
                let posts = PFObject(className: "citas_servicio")
                //create an image data
                let imageData = UIImagePNGRepresentation(self.myImageView.image!)
                //create a parse file to store in cloud
                let parseImageFile = PFFile(name: "uploaded_image.png", data: imageData!)
                parseImageFile?.saveInBackground(block: { (success, error) -> Void in
                    if success{
                        posts["Nombre_cliente"] = self.receivedNombre
                        posts["email_cliente"] = self.receivedEmail
                        posts["celular_cliente"] = self.receivedCelular
                        posts["tel_cliente"] = self.receivedTelefono
                        posts["vehiculo_cliente"] = self.receivedVehiculo
                        posts["tipo_cita"] = self.receivedTipo
                        posts["comentarios"] = self.receivedComentarios
                        posts["fecha_cita"] = self.receivedFecha
                        posts["ano_vehiculo"] = self.receivedAno
                        posts["hora_cita"] = self.receivedHora
                        posts["kilometros"] = self.receivedKm
                        posts["codigo_cita"] = self.codigo
                        posts["foto"] = parseImageFile
                        posts.saveInBackground(block: { (success: Bool, error: NSError?) -> Void in
                            if error == nil {
                                //take user home
                                print("data uploaded")
                                self.myActivityIndicator.stopAnimating()
                                self.botonContinuar.isHidden=false
                                
                                //ENVIO DE POST REQUEST
                                
                                let url: URL = URL(string: "http://www.solinpromex.com/cita_recibida.php")!
                                let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
                                
                                
                                let bodyData = "data=Cita Servicio solicitada CON FOTO: \(self.codigo) "+"&nombre="+self.receivedNombre+"&email="+self.receivedEmail+"&celular="+self.receivedCelular+"&telefono="+self.receivedTelefono+"&vehiculo="+self.receivedVehiculo+"&ano="+self.receivedAno+"&km="+self.receivedKm+"&comentarios="+self.receivedComentarios+"&fecha="+self.receivedFecha+"&hora="+self.receivedHora
                                request.httpMethod = "POST"
                                request.httpBody = bodyData.data(using: String.Encoding.utf8);
                                NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main)
                                    {
                                        (response, data, error) in
                                        print(response)
                                        
                                }
                                
                            }else {
                                print(error)
                            }
                        })
                    }
                })
            
            
            
        }
    }

    func randomStringWithLength (_ len : Int) -> NSString {
        
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
    func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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

