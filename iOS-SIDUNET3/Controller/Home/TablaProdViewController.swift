//
//  TablaProdViewController.swift
//  iOS-SIDUNET3
//
//  Created by Fanely on 4/29/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

import UIKit
import CoreData

class TablaProdTableViewController: UITableViewController{

    @IBOutlet weak var tabla: UITableView!
    var produtos = [Productos]()
    
    func conexion()-> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
        mostrarDatos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabla.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let produto = produtos[indexPath.row]
        cell.textLabel?.text = produto.descricao
        cell.detailTextLabel?.text = produto.marca
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let contexto = conexion()
        let produto = produtos[indexPath.row]
        if editingStyle == .delete {
            contexto.delete(produto)
            do{
                try contexto.save()
            }catch let error as NSError {
                print("Hubo un error al eliminar datos", error.localizedDescription)
            }
        }
        mostrarDatos()
        tabla.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editar", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            if let id = tabla.indexPathForSelectedRow{
                let fila = produtos[id.row]
                let destino = segue.destination as! EditarProdViewController
                destino.produtosEditar = fila
            }
        }
    }
    
    func mostrarDatos(){
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Productos> = Productos.fetchRequest()
        do {
            produtos = try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("Hubo un error al mostrar datos", error.localizedDescription)
        }
    }
}
