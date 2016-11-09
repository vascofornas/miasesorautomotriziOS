//
//  MiAutoModel.swift
//  Asesor Automotriz Chrysler
//
//  Created by MODESTO VASCO FORNAS on 6/1/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import Foundation

class MiAutoModel: NSObject {
    
    //properties
    
    var id_mis_autos: String?
    var modelo: String?
    var ano: String?
    var id_movil: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id_mis_autos: String, modelo: String, ano: String, id_movil: String) {
        
        self.id_mis_autos = id_mis_autos
        self.modelo = modelo
        self.ano = ano
        self.id_movil = id_movil
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "id_mis_autos: \(id_mis_autos), Modelo: \(modelo), Año: \(ano), id_movil: \(id_movil)"
        
    }
    
    
}