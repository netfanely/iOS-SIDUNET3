//
//  ProdutoViewController.swift
//  iOS-SIDUNET3
//
//  Created by Fanely on 4/22/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

import UIKit
import CoreData

class ProdutoViewController: UIViewController {

    @IBOutlet weak var codProdText2: UITextField!
    @IBOutlet weak var descriText: UITextField!
    @IBOutlet weak var colorText: UITextField!
    @IBOutlet weak var marcaText: UITextField!
    @IBOutlet weak var tamanhoText: UITextField!
    @IBOutlet weak var costoText: UITextField!
    @IBOutlet weak var vendaText: UITextField!
    @IBOutlet weak var quantText: UITextField!
    
    func conexion()->NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        let contexto = conexion()
        let entidadProdutos = NSEntityDescription.insertNewObject(forEntityName: "Productos", into: contexto) as! Productos
        
        entidadProdutos.descricao = descriText.text
        guard let codigo = Int16(codProdText2.text!) else {return}
        guard let cantidad = Int16(quantText.text!) else {return}
        guard let costo = Double(costoText.text!) else {return}
        guard let venda = Double(vendaText.text!) else {return}
            
        entidadProdutos.codProd = codigo
        entidadProdutos.color = colorText.text
        entidadProdutos.marca = marcaText.text
        entidadProdutos.tamanho = tamanhoText.text
        entidadProdutos.precCosto = costo
        entidadProdutos.precVenda = venda
        entidadProdutos.quantidade = cantidad
        
        do {
            try contexto.save()
            print("salvo")
            descricaoText.text = ""
            codProdText2.text = ""
            quantText.text = ""
            costoText.text = ""
            vendaText.text = ""
            colorText.text = ""
            marcaText.text = ""
            tamanhoText.text = ""
            costoText.text = ""
            vendaText.text = ""
            quantText.text = ""
        } catch let error as NSError {
            print("Erro al guardar", error.localizedDescription)
        }
    }
    
    @IBAction func regresar(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
}
