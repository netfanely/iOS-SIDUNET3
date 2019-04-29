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
            descriText.text = ""
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
    
    @IBAction func mostrar(_ sender: UIButton) {
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Productos> = Productos.fetchRequest()
        do {
            let resultados = try contexto.fetch(fetchRequest)
            print("Numero de registros: \(resultados.count)")
            for res in resultados as [NSManagedObject] {
                let codigo = res.value(forKey: "codProd")
                let descripcion = res.value(forKey: "descricao")
                let color = res.value(forKey: "color")
                let marca = res.value(forKey: "marca")
                let tamano = res.value(forKey: "tamanho")
                let precioC = res.value(forKey: "precCosto")
                let precioV = res.value(forKey: "precVenda")
                let cantidad = res.value(forKey: "quantidade")
                print("codigo: \(codigo!) descripcion: \(descripcion!) color: \(color!) marca: \(marca!) tamano: \(tamano!) costo: \(precioC!) venta: \(precioV!) stock: \(cantidad!)")
            }
        } catch let error as NSError{
            print("Erro ao mostrar", error.localizedDescription)
        }
    }
    
    @IBAction func regresar(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func borrar(_ sender: UIButton) {
        let contexto = conexion()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Productos")
        let borrar = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try contexto.execute(borrar)
            print("Registros borrados")
        } catch let error as NSError {
            print("Error al borrar", error.localizedDescription)
        }
    }
}
