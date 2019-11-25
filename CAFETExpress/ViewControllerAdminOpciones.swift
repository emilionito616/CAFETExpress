//
//  ViewControllerAdminOpciones.swift
//  CAFETExpress
//
//  Created by Emilio on 11/17/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerAdminOpciones: UIViewController {
    var usuario = [Usuarios]()
    var db : OpaquePointer?

    @IBAction func btnPedidos(_ sender: UIButton) {
    }
    
    @IBAction func btnAdmin(_ sender: UIButton) {
        self .performSegue(withIdentifier: "segueAdmin", sender: self)
    }
    
    @IBAction func btnUsuarios(_ sender: UIButton) {
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
        }
        //noControl, nombreUsr, carrera, password
        usuario.removeAll()
        let query = "SELECT noControl, nombreUsr, carrera, password FROM Usuario Order By nombreUsr"
        var stmt: OpaquePointer?
        if (sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK){
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error consultar", Mensaje: errmsg)
            return
        }
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let noC = String(sqlite3_column_int(stmt, 0))
            let nomU = String (cString: sqlite3_column_text(stmt, 1))
            let carr = String (sqlite3_column_double(stmt, 2))
            let pwdU = String (sqlite3_column_int(stmt, 3))
            usuario.append(Usuarios(idUsr: noC, nomUsr: nomU, carr: carr, pwd: pwdU))
            
        }
        self .performSegue(withIdentifier: "segueUsr", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    

}
