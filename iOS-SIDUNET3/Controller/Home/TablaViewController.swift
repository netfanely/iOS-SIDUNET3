//
//  TablaViewController.swift
//  iOS-SIDUNET3
//
//  Created by Fanely on 4/26/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

import UIKit
import CoreData
class TablaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // o 2 o 3 secciones, 1 por defecto
    }*/
    
    @IBOutlet weak var tabla: UITableView!
    var clientes = [Clientes]()
    
    func conexion()->NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
        mostrarDatos()
    }
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabla.reloadData()
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabla.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cliente = clientes[indexPath.row]
        cell.textLabel?.text = cliente.nomeCli
        cell.detailTextLabel?.text = cliente.endereco
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let contexto = conexion()
        let cliente = clientes[indexPath.row] //trae la fila o registro a eliminar o editar
        if editingStyle == .delete {
            contexto.delete(cliente)
            do{
                try contexto.save()
            } catch let error as NSError {
                print("Hubo un error al mostrar datos", error.localizedDescription)
            }
        }
        
        mostrarDatos()
        tabla.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editar", sender: self)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
            if segue.identifier == "editar"{
                if let id = tabla.indexPathForSelectedRow{
                    let fila = clientes[id.row]
                    let destino = segue.destination as! EditarViewController
                    destino.clientesEditar = fila
                }
                
            }
        
    }
    
    func mostrarDatos(){
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Clientes> = Clientes.fetchRequest()
        do {
            clientes = try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("Hubo un error al mostrar datos", error.localizedDescription)
        }
    }

}
