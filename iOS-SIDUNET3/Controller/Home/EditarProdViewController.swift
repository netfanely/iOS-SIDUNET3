//
//  EditarProdViewController.swift
//  iOS-SIDUNET3
//
//  Created by Fanely on 4/29/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

import UIKit
import CoreData
class EditarProdViewController: UIViewController {

    var produtosEditar: Productos!
    
    func conexion()->NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    @IBOutlet weak var codigo: UITextField!
    @IBOutlet weak var descri: UITextField!
    @IBOutlet weak var colores: UITextField!
    @IBOutlet weak var marcas: UITextField!
    @IBOutlet weak var tamanos: UITextField!
    @IBOutlet weak var costos: UITextField!
    @IBOutlet weak var vendas: UITextField!
    @IBOutlet weak var cantidad: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(produtosEditar.descricao!)
        codigo.text = "\(produtosEditar.codProd)"
        descri.text = produtosEditar.descricao
        colores.text = produtosEditar.color
        marcas.text = produtosEditar.marca
        tamanos.text = produtosEditar.tamanho
        costos.text = "\(produtosEditar.precCosto)"
        vendas.text = "\(produtosEditar.precVenda)"
        cantidad.text = "\(produtosEditar.quantidade)"
    }
    
    @IBAction func editar(_ sender: UIButton) {
        let contexto = conexion()
        guard let codi = Int16(codigo.text!) else { return }
        guard let precven = Double(vendas.text!) else { return }
        guard let preccos = Double(costos.text!) else { return }
        guard let canti = Int16(cantidad.text!) else { return }
        produtosEditar.setValue(codi, forKey: "codProd")
        produtosEditar.setValue(descri.text, forKey: "descricao")
        produtosEditar.setValue(colores.text, forKey: "color")
        produtosEditar.setValue(marcas.text, forKey: "marca")
        produtosEditar.setValue(tamanos.text, forKey: "tamanho")
        produtosEditar.setValue(preccos, forKey: "precCosto")
        produtosEditar.setValue(precven, forKey: "precVenda")
        produtosEditar.setValue(canti, forKey: "quantidade")
        
        do {
            try contexto.save()
            navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("Error al guardar", error.localizedDescription)
        }
    }
    
}
