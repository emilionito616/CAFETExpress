//
//  ViewControllerCrear.swift
//  CAFETExpress
//
//  Created by Emilio on 11/15/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit
import SQLite3
class ViewControllerCrear: UIViewController {
    var usuario = [Usuarios]()
    var db : OpaquePointer?
    
    @IBOutlet weak var txtNoControl: UITextField!
    
    @IBOutlet weak var txtNomComple: UITextField!
    
    @IBOutlet weak var txtCarrera: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtPasswordCon: UITextField!
    
    @IBAction func btnRegistrar(_ sender: UIButton) {
        let p1 = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let p2 = txtPasswordCon.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let noC = txtNoControl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let carr = txtCarrera.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let nom = txtNomComple.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (noC?.isEmpty)!{
            showAlert(Titulo: "Error", Mensaje: "Falta numero de control")
            return
        }
        if (carr?.isEmpty)!{
            showAlert(Titulo: "Error", Mensaje: "Falta ingresar la carrera")
            return
        }
        if (nom?.isEmpty)!{
            showAlert(Titulo: "error", Mensaje: "Falta ingresar el nombre")
            return
        }
        
        if (p1?.isEmpty)! || (p2?.isEmpty)!{
            showAlert(Titulo: "Error", Mensaje: "Contraseña Incorrecta")
            return
        }else if (p1 != p2){
            showAlert(Titulo: "Error", Mensaje: "Las contraseñas no coinciden")
            return
        }
        
        let pwd: NSString = p1! as NSString
        let noCtrl: NSString = noC! as NSString
        let carre: NSString = carr! as NSString
        let nomb: NSString = nom! as NSString
        
        var stmt: OpaquePointer?
        let sentenciaMostrar = "SELECT noControl FROM Usuario"
        
        if (sentenciaMostrar != noC) {
            let sentencia = "INSERT INTO Usuario(noControl, nombreUsr, carrera, password) values (?,?,?,?)"
            if sqlite3_prepare(db,sentencia, -1, &stmt, nil) == SQLITE_OK{
                sqlite3_bind_text(stmt, 1, noCtrl.utf8String,-1,nil)
                sqlite3_bind_text(stmt, 2, nomb.utf8String, -1, nil)
                sqlite3_bind_text(stmt, 3, carre.utf8String, -1, nil)
                sqlite3_bind_text(stmt, 4, pwd.utf8String, -1, nil)
                showAlert(Titulo: "Correcto", Mensaje: "Usuario Insertado con exito")
            }
        }
        else {
            showAlert(Titulo: "Error", Mensaje: "Usuario ya registrado")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            //let errmsg = String(cString:sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error insertar", Mensaje: "Error al insertar")
            return
        }
        
        limpiar()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Crear Base de Datos
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
            
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Usuario(noControl TEXT PRIMARY KEY, nombreUsr TEXT, carrera TEXT, password TEXT)", nil,nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo:"Error al crear la tabla", Mensaje: errmsg)
        }
        txtNoControl.becomeFirstResponder()
    }
    
    func limpiar() {
        txtNoControl.text = ""
        txtNomComple.text = ""
        txtCarrera.text = ""
        txtPassword.text = ""
        txtPasswordCon.text = ""
        
    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
