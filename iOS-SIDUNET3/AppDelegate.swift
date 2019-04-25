//
//  AppDelegate.swift
//  iOS-SIDUNET3
//
//  Created by Fanely on 4/21/19.
//  Copyright © 2019 Net Fanely. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // FOREGROUND Y BACKGROUND
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //LA APLICACION YA CARGO
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        //PASAR DE MODO FOREGROUND A MODO BACKGROUND
        //ENTRA LLAMADA, MENSAJES SMS, JUEGOS
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        //ENTRO YA A BACKGROUND
        //QUE SE ACTUALIZE
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        //VA A ENTRAR A FOREGROUND
        
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        //LA APLICACION ESTA ACTIVA DE NUEVO
    }
    func applicationWillTerminate(_ application: UIApplication) {
        //CUANDO CERRAMOS LA APP
        //self.saveContext()
    }

    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PersistenciaCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
       return container
     }()

//MARK: - Core Data Saving support

func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        }catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
        }
    }
}

