//
//  PrincipalViewController.swift
//  iOS-SIDUNET3
//
//  Created by Fanely on 4/22/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

//import Foundation
import UIKit

 
class PrincipalViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
        
        @IBAction func regresar(_ sender: UIButton) {
            //self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
        
        
    
}
