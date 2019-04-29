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
