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

class SeleccionarAsesorViewController: UIViewController, UITextFieldDelegate  {

    var celular: String = ""
   var emailConsulta: String = ""
    var apple: String = ""
    
     let misDatos:NSUserDefaults = NSUserDefaults.standardUserDefaults()
 
    
    @IBOutlet weak var codigoTxt: UITextField!
    
       
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //comprobar conexion a internet
        if Reachability.isConnectedToNetwork() == true {
           
        } else {
          
            let alert = UIAlertView(title: "No dispone de conexión a Internet", message: "Esta aplicación usa servicios de Internet para su funcionamiento.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        
        self.codigoTxt.delegate = self;
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    
    @IBAction func botonAceptarAction(sender: UIButton) {
        
        let codigo:NSString = codigoTxt.text!
        
        
        if( codigo.isEqualToString("")){
            //si les champs sont vides
            let alert:UIAlertView = UIAlertView()
            alert.title = "Error"
            alert.message = "Introduzca el código de su Agencia"
            alert.delegate = self
            alert.addButtonWithTitle("OK")
           
            alert.show()
        }else{
            
            let post:NSString = "codigo=\(codigo)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"http://www.appautomotriz.com/php_mobile/check_agencia.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch _ as NSError {
                urlData = nil
            } catch {
                fatalError()
            }
            
            
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                   
                    
                    var error: NSError?
                    
                    
                    var jsonData:NSDictionary = NSDictionary()
                    do {
                        jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!,options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    }catch {  // handle error
                    }
                    
                    
                    let success:NSInteger = jsonData.valueForKey("error") as! NSInteger
                    
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        NSLog("Login OK");
                        
                        let id_agencia:NSString = jsonData.valueForKey("id_agencia") as! NSString
                        let nombre_agencia:NSString = jsonData.valueForKey("nombre_agencia") as! NSString
                        let codigo_agencia:NSString = jsonData.valueForKey("codigo_agencia") as! NSString
                        
                        misDatos.setObject(id_agencia, forKey: "ID_AGENCIA")
                        misDatos.setObject(nombre_agencia, forKey: "NOMBRE_AGENCIA")
                        misDatos.setObject(codigo_agencia, forKey: "CODIGO_AGENCIA")
                        misDatos.setInteger(1, forKey: "AGENCIA_SELECCIONADA")
                        misDatos.synchronize()
                        
                        NSLog("Id agencia: %@", id_agencia);
                        
                        NSLog("Nombre agencia: %@", nombre_agencia);
                        
                        NSLog("Codigo agencia: %@", codigo_agencia);
                     //   self.performSegueWithIdentifier("r", sender: self)
                        
                    }else{
                        NSLog("Login échoué");
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Código no válido"
                        alertView.message = "El código introducido no corresponde a ninguna Agencia"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        
                    }
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Error"
                    alertView.message = "No dispone de conexión a Internet"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error"
                alertView.message = "No dispone de conexión a Internet"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
            
        }//fin du SI champs vides
    }
    

    

    

  
    
 
    

   

    
   
    
  



    
}

