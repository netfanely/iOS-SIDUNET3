//
//  EditarViewController.swift
//  iOS-SIDUNET3
//
//  Created by Fanely on 4/29/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

import UIKit
import CoreData
class EditarViewController: UIViewController {

    var clientesEditar : Clientes!
    
    func conexion()->NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    @IBOutlet weak var codigoText: UITextField!
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var direccionText: UITextField!
    @IBOutlet weak var barrioText: UITextField!
    @IBOutlet weak var telefonoText: UITextField!
    @IBOutlet weak var celularText: UITextField!
    @IBOutlet weak var observacionText: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(clientesEditar.nomeCli!)
        nombreText.text = clientesEditar.nomeCli
        codigoText.text = "\(clientesEditar.codCli)"
        emailText.text = clientesEditar.email
        direccionText.text = clientesEditar.endereco
        barrioText.text = clientesEditar.barrio
        telefonoText.text = "\(clientesEditar.telefone)"
        celularText.text = "\(clientesEditar.mobilePhone)"
        observacionText.text = clientesEditar.obs
        
        
        
    }
    
    @IBAction func editar(_ sender: UIButton) {
       let contexto = conexion()
        guard let codigoint = Int16(codigoText.text!)  else { return }
        guard let telef1int = Int32 (telefonoText.text!) else { return }
        guard let telef2int = Int32(celularText.text!)  else { return }
        
        clientesEditar.setValue(nombreText.text, forKey: "nomeCli")
        clientesEditar.setValue(codigoint, forKey: "codCli")
        clientesEditar.setValue(emailText.text, forKey: "email")
        clientesEditar.setValue(direccionText.text, forKey: "endereco")
        clientesEditar.setValue(barrioText.text, forKey: "barrio")
        clientesEditar.setValue(telef1int, forKey: "telefone")
        clientesEditar.setValue(telef2int, forKey: "mobilePhone")
        clientesEditar.setValue(observacionText.text, forKey: "obs")
        
        do {
            try contexto.save()
            navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("error al guardar",error.localizedDescription)
        }
    }
    
}
