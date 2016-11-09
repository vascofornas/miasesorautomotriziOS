//
//  ViewController.swift
//  Pedro Villarejo App Clientes
//
//  Created by MODESTO VASCO FORNAS on 1/8/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import Swift

import MessageUI

class MostrarAgenciaAsesorViewController: UIViewController, UITextFieldDelegate {
    
    var celular: String = ""
    var emailConsulta: String = ""
    var apple: String = ""
    var agenciaSeleccionada: String = ""
    var id_agencia: String = ""
    var nombre_agencia: String = ""
    var codigo_agencia: String = ""
    var agencia_seleccionada: String = ""
    var nombre_asesor: String = ""
    var id_asesor: String = ""
    var agencia_asesor: String = ""
    var email_asesor: String = ""
    var codigo_asesor: String = ""
    var existe: String = ""
  
    
    let misDatos:UserDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var AgenciaTXT: UILabel!
    
    @IBOutlet weak var AsesorTXT: UILabel!
   
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //comprobar conexion a internet
        
       print ("ESTOY EN MOSTRAR AGENCIA-ASESOR")
        
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
       
       
        
       
        
        self.AgenciaTXT.text = self.nombre_agencia;
        
        self.AsesorTXT.text = self.nombre_asesor;
    
                //fin recuperar JSON
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        if "regresar" == segue.identifier {
           
            print ("antes de borrar agenecia y asesor")
            
            
            misDatos.removeObject(forKey: "NOMBRE_AGENCIA")
            misDatos.removeObject(forKey: "NOMBRE_ASESOR")
            
        }
    }
    
    
    
    
    
    
    
    
    
}
