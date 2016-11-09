//
//  ViewController.swift
//  Pedro Villarejo App Clientes
//
//  Created by MODESTO VASCO FORNAS on 1/8/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import UIKit



class ShowSplashScreen: UIViewController {

          override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
          perform(#selector(ShowSplashScreen.muestraSplash), with: nil, afterDelay: 2)
    }

    func muestraSplash(){
    
        
        
        performSegue(withIdentifier: "show", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    

    
   
  
    
   
    
    
    
      }

