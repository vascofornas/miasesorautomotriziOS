//
//  HomeModel.swift
//  Asesor Automotriz Chrysler
//
//  Created by MODESTO VASCO FORNAS on 6/1/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import Foundation

protocol HomeModelProtocal: class {
    func itemsDownloaded(_ items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    var mi_movil: String = ""
    
    
     let misDatos:UserDefaults = UserDefaults.standard
    
    
   
    var urlPath: String = "http://miasesorautomotriz.com/php_mobile/check_mis_autos.php"
    let parametros = "?id="
    
    func downloadItems() {
        
        mi_movil = misDatos.string(forKey: "ID_IPHONE")!
        print ("mi_movil en HOMEMODEL:",mi_movil)
         urlPath = urlPath + parametros + mi_movil
        
        let url: URL = URL(string: urlPath)!
        var session: Foundation.URLSession!
        let configuration = URLSessionConfiguration.default
        
        print ("LA URL ES: ",url)
        session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: url)
        
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data);
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            self.parseJSON()
            
        }
        
    }
    
    
    func parseJSON() {
        
        
        var jsonResult: NSArray = NSArray()
       
        do{
            
            
            
            
            jsonResult = try JSONSerialization.jsonObject(with: self.data as Data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            print ("HASTA AQUI SIN ERROR")
            
        } catch let error as NSError {
            print("ERROR+",error)
            
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let locations: NSMutableArray = NSMutableArray()
        
        
        for i in (0 ..< jsonResult.count)
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            print (jsonElement)
            let location = MiAutoModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let id_mis_autos = jsonElement["id_mis_autos"] as? String,
                let modelo = jsonElement["modelo"] as? String,
                let ano = jsonElement["ano"] as? String,
                let id_movil = jsonElement["id_movil"] as? String
            {
                
                location.id_mis_autos = id_mis_autos
                location.modelo = modelo
                location.ano = ano
                location.id_movil = id_movil
                
            }
            
            locations.add(location)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(locations)
            
        })
    }
}
