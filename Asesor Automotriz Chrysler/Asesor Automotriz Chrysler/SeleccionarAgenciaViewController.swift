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
import MediaPlayer

class SeleccionarAgenciaViewController: UIViewController, UITextFieldDelegate  {

    var celular: String = ""
   var emailConsulta: String = ""
    var apple: String = ""
    var agenciaSeleccionada: String = ""
    var nombre_agencia: String = ""
    var existe: String = ""
    var existe_asesor: String = ""
  
    var moviePlayer : MPMoviePlayerController!
     let misDatos:UserDefaults = UserDefaults.standard
 
    
    @IBOutlet weak var codigoTxt: UITextField!
    
       
 

    override func viewDidLoad() {
        super.viewDidLoad()
      print ("ESTOY EN VIEWDIDLOAD")
        self.codigoTxt.delegate = self;
        
        let loadedSettingTest = UserDefaults.standard.string(forKey: "NOMBRE_AGENCIA") ?? ""
        print (loadedSettingTest)
        if loadedSettingTest.isEmpty {
            print(true)
            let path = Bundle.main.path(forResource: "video", ofType:"mp4")
            let url = URL(fileURLWithPath: path!)
            self.moviePlayer = MPMoviePlayerController(contentURL: url)
            if let player = self.moviePlayer {
                player.view.frame = CGRect(x: 0, y: 25, width: (self.view.frame.size.width), height: ((self.view.frame.size.height)/2)-65)
                player.view.sizeToFit()
                player.scalingMode = MPMovieScalingMode.fill
                player.isFullscreen = true
                player.controlStyle = MPMovieControlStyle.embedded
                player.movieSourceType = MPMovieSourceType.file
                player.repeatMode = MPMovieRepeatMode.one
                player.play()
                self.view.addSubview(player.view)
            }
            
        } else {
            print(false)  // false
            self.performSegue(withIdentifier: "saltar", sender: self)
        }
      
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
      
        let loadedSettingTest = UserDefaults.standard.string(forKey: "NOMBRE_AGENCIA") ?? ""
        print (loadedSettingTest)
        if loadedSettingTest.isEmpty {
            print(true)
            let path = Bundle.main.path(forResource: "video", ofType:"mp4")
            let url = URL(fileURLWithPath: path!)
            self.moviePlayer = MPMoviePlayerController(contentURL: url)
            if let player = self.moviePlayer {
                player.view.frame = CGRect(x: 0, y: 25, width: (self.view.frame.size.width), height: ((self.view.frame.size.height)/2)-65)
                player.view.sizeToFit()
                player.scalingMode = MPMovieScalingMode.fill
                player.isFullscreen = true
                player.controlStyle = MPMovieControlStyle.embedded
                player.movieSourceType = MPMovieSourceType.file
                player.repeatMode = MPMovieRepeatMode.one
                player.play()
                self.view.addSubview(player.view)
            }
            
        } else {
            print(false)  // false
            self.performSegue(withIdentifier: "saltar", sender: self)
        }
     
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    
    @IBAction func botonAceptarAction(_ sender: UIButton) {
        
        let codigo:NSString = codigoTxt.text! as NSString
        
        
        if( codigo.isEqual(to: "")){
            //si les champs sont vides
            let alert:UIAlertView = UIAlertView()
            alert.title = "Error"
            alert.message = "Introduzca el código de su Agencia"
            alert.delegate = self
            alert.addButton(withTitle: "OK")
           
            alert.show()
        }else{
            
            let post:NSString = "codigo=\(codigo)" as NSString
            
            NSLog("PostData: %@",post);
            
            let url:URL = URL(string:"http://www.miasesorautomotriz.com/php_mobile/check_agencia.php")!
            
            let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            
            let postLength:NSString = String( postData.count ) as NSString
            
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            let reponseError: NSError?
            var response: URLResponse?
            
            var urlData: Data?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
            } catch _ as NSError {
                urlData = nil
            } catch {
                fatalError()
            }
            
            
            
            if ( urlData != nil ) {
                let res = response as! HTTPURLResponse!;
                
               
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                    NSLog("Response ==> %@", responseData);
                   
                    
                    var error: NSError?
                    
                    
                    var jsonData:NSDictionary = NSDictionary()
                    do {
                        jsonData = try JSONSerialization.jsonObject(with: urlData!,options:JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    }catch {  // handle error
                    }
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "error") as! NSInteger
                    
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        NSLog("Login OK");
                        
                        let id_agencia:NSString = jsonData.value(forKey: "id_agencia") as! NSString
                        let nombre_agencia:NSString = jsonData.value(forKey: "nombre_agencia") as! NSString
                        let codigo_agencia:NSString = jsonData.value(forKey: "codigo_agencia") as! NSString
                        
                        misDatos.set(id_agencia, forKey: "ID_AGENCIA")
                        misDatos.set(nombre_agencia, forKey: "NOMBRE_AGENCIA")
                        misDatos.set(codigo_agencia, forKey: "CODIGO_AGENCIA")
                        misDatos.set("SI", forKey: "AGENCIA_SELECCIONADA")
                         misDatos.set("NO", forKey: "ASESOR_SELECCIONADO")
                        
                        misDatos.synchronize()
                        
                        NSLog("Id agencia: %@", id_agencia);
                        
                        NSLog("Nombre agencia: %@", nombre_agencia);
                        
                        NSLog("Codigo agencia: %@", codigo_agencia);
                        
                        agenciaSeleccionada = nombre_agencia as String;
                       self.performSegue(withIdentifier: "r", sender: self)
                        
                    }else{
                        NSLog("Login échoué");
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Código no válido"
                        alertView.message = "El código introducido no corresponde a ninguna Agencia"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                    }
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Error"
                    alertView.message = "Error de acceso al servidor"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                }
            } else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error"
                alertView.message = "Error de acceso al servidor"
              
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
            
        }//fin du SI champs vides
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        if "r" == segue.identifier {
            let AsesorVC: SeleccionarAsesorViewController = segue.destination as! SeleccionarAsesorViewController
            
            AsesorVC.agenciaSeleccionada = agenciaSeleccionada
            
            
            
        }
        if "saltar" == segue.identifier {
           
         
            
        }
    }


    

  
    
 
    

   

    
   
    
  



    
}

