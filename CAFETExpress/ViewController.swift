//
//  ViewController.swift
//  CAFETExpress
//
//  Created by Emilio on 11/14/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    var db: OpaquePointer?
    
    @IBOutlet weak var txtNoControl: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnSesion(_ sender: UIButton) {
        if (txtNoControl.text?.isEmpty)! || (txtPassword.text?.isEmpty)! {
            showAlert(Titulo: "Error", Mensaje: "Faltan datos")
            txtNoControl.becomeFirstResponder()
        } else if (txtNoControl.text == "admin") && (txtPassword.text == "hola"){
            self .performSegue(withIdentifier: "segueAdmin", sender: self)
        } else {
            
            self .performSegue(withIdentifier: "segueMenu", sender: self)
        }
    }
    
    @IBAction func btnCrear(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
            
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Usuario(noControl TEXT PRIMARY KEY,nombreUsr TEXT, carrera TEXT, password TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo:"Error al crear la tabla", Mensaje: errmsg)
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Productos(idProducto INTEGER PRIMARY KEY AUTOINCREMENT, nomProducto TEXT, precio DOUBLE, cantidad INTEGER, tiempo TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo:"Error al crear la tabla", Mensaje: errmsg)
        }

    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

