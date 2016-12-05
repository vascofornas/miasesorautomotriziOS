//
//  ViewController.swift
//  Pedro Villarejo App Clientes
//
//  Created by MODESTO VASCO FORNAS on 1/8/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import UIKit
import Parse

import Swift
import Alamofire
import MessageUI

class SeleccionarAsesorViewController: UIViewController, UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate  {

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
     @IBOutlet weak var asesoresPickerView: UIPickerView!
    @IBOutlet weak var fecha: UILabel!
    
     let misDatos:UserDefaults = UserDefaults.standard
 
    
    @IBOutlet weak var AgenciaTXT: UILabel!
    var pickerString:NSMutableArray = []
    
    
       
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //comprobar conexion a internet
        
        self.asesoresPickerView.dataSource = self;
        self.asesoresPickerView.delegate = self;
        
        print ("ESTOY EN VIEWDIDLOAD DE SELECCIONAR ASESOR")
        id_agencia = misDatos.string(forKey: "ID_AGENCIA")!
        print ("ID AGENCIA:",id_agencia)
        nombre_agencia = misDatos.string(forKey: "NOMBRE_AGENCIA")!
        print ("NOMBRE AGENCIA:",nombre_agencia)
        codigo_agencia = misDatos.string(forKey: "CODIGO_AGENCIA")!
        print ("CODIGO AGENCIA:",codigo_agencia)
        existe = misDatos.string(forKey: "AGENCIA_SELECCIONADA")!
        print ("AGENCIA EXISTE:",existe)
        
        self.AgenciaTXT.text = self.agenciaSeleccionada;
        
        //recuperar JSON
      

    
        
        //fin recuperar JSON
        
    }
   
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        return (pickerString[row] as AnyObject).value(forKey: "nombre_asesor")as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //self.vehiculoTextField.text  = self.pickerString[row] as? String
        self.id_asesor = ((pickerString[row] as AnyObject).value(forKey: "id_asesor")as? String)!
        print (self.id_asesor)
        self.nombre_asesor = ((pickerString[row] as AnyObject).value(forKey: "nombre_asesor")as? String)!
        print (self.nombre_asesor)
        self.codigo_asesor = ((pickerString[row] as AnyObject).value(forKey: "codigo_asesor")as? String)!
        print (self.codigo_asesor)
        self.email_asesor = ((pickerString[row] as AnyObject).value(forKey: "email_asesor")as? String)!
        print (self.email_asesor)
        
        misDatos.set(self.id_asesor, forKey: "ID_ASESOR")
        misDatos.set(self.nombre_asesor, forKey: "NOMBRE_ASESOR")
        misDatos.set(self.codigo_asesor, forKey: "CODIGO_ASESOR")
        misDatos.set(self.email_asesor, forKey: "EMAIL_ASESOR")
       
        misDatos.synchronize()
        
        
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = (pickerString[row] as AnyObject).value(forKey: "nombre_asesor")as? String
        let myTitle = NSAttributedString(string: titleData!, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        return myTitle
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = (pickerString[row] as AnyObject).value(forKey: "nombre_asesor")as? String
        let myTitle = NSAttributedString(string: titleData!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 26),NSForegroundColorAttributeName:UIColor.darkText])
        pickerLabel.textAlignment = .center
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        if "regresar_agencia" == segue.identifier {
            
            
            
            misDatos.removeObject(forKey: "NOMBRE_AGENCIA")
            misDatos.removeObject(forKey: "NOMBRE_ASESOR")
            
            
        }
    }
  
    
   
    
  



    
}

