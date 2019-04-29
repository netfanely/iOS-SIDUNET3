//
//  ClienteViewController.swift
//  iOS-SIDUNET3 com Persistencia de Dados - COREDATA
//
//  Created by Fanely on 4/22/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

import UIKit
import CoreData
class ClienteViewController: UIViewController {
    
    @IBOutlet weak var codText: UITextField!
    @IBOutlet weak var nomeText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var enderecoText: UITextField!
    @IBOutlet weak var barrioText: UITextField!
    @IBOutlet weak var telefText: UITextField!
    @IBOutlet weak var mphoneText: UITextField!
    @IBOutlet weak var obsText: UITextField!
    
    // MARK - Conexión con la base de datos (COREDATA)
    func conexion()->NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func guardar(_ sender: UIButton) {
        //CARGAR LA BASE DE DATOS
        let contexto = conexion()
        //ENTIDAD CLIENTE o CLASE
        let entidadClientes = NSEntityDescription.insertNewObject(forEntityName: "Clientes", into: contexto) as! Clientes
        //Para tipo Enteros
        guard let codigo = Int16(codText.text!) else { return }
        guard let telefono1 = Int32(telefText.text!) else { return }
        guard let telefono2 = Int32(mphoneText.text!) else { return }
        
        entidadClientes.nomeCli=nomeText.text
        entidadClientes.email=emailText.text
        entidadClientes.endereco=enderecoText.text
        entidadClientes.barrio=barrioText.text
        entidadClientes.obs=obsText.text
        entidadClientes.codCli = codigo
        entidadClientes.telefone = telefono1
        entidadClientes.mobilePhone = telefono2
        //DO-CATCH Para ver errores
        do {
            try contexto.save()
            print("salvó")
        }catch let error as NSError {
            print("Erro ao salvar", error.localizedDescription)
        }
    }

    @IBAction func mostrar(_ sender: UIButton) {
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Clientes> = Clientes.fetchRequest()
        do{
            let resultados = try contexto.fetch(fetchRequest)
            print("numero de registros: \(resultados.count)")
            for res in resultados as [NSManagedObject]{
                let nome = res.value(forKey:"nomeCli")
                let email = res.value(forKey: "email")
                let endereco = res.value(forKey: "endereco")
                let barrio = res.value(forKey: "barrio")
                let obs = res.value(forKey: "obs")
                let codigo = res.value(forKey: "codCli")
                let telefono1 = res.value(forKey: "telefone")
                let telefono2 = res.value(forKey: "mobilePhone")
                
                print("Nombre: \(nome!) E-mail: \(email!) Direccion: \(endereco!) Bairro: \(barrio!) Observacao: \(obs!) Codigo: \(codigo!) Celular: \(telefono1!) Celular2: \(telefono2!)")
            }
        }catch let error as NSError{
            print("Erro al mostrar",error.localizedDescription)
        }
    }

    @IBAction func regresar(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func borrar(_ sender: UIButton){
        let contexto = conexion()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Clientes")
        let borrar = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try contexto.execute(borrar)
            print("Todos los registros borrados")
        } catch let error as NSError {
            print("Error al borrar", error.localizedDescription)
        }
    }

}
