//
//  ViewControllerAdmin.swift
//  CAFETExpress
//
//  Created by Emilio on 11/20/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerAdmin: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var producto = [Productos]()
    var db: OpaquePointer?
    
    @IBOutlet weak var imgVIew: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var txtBuscar: UITextField!
    
    @IBOutlet weak var txtNomProd: UITextField!
    
    @IBOutlet weak var txtPrecio: UITextField!
    
    @IBOutlet weak var txtCnatidad: UITextField!
    
    @IBOutlet weak var txtTiempo: UITextField!
    
    
    @IBAction func btnBuscar(_ sender: UIButton) {
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
            
        }
        
        producto.removeAll()
        let query = "SELECT idProducto, nomProducto, precio, cantidad, tiempo FROM Productos"
        var stmt: OpaquePointer?
        if (sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK){
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error consultar", Mensaje: errmsg)
            return
        }
        while (sqlite3_step(stmt) == SQLITE_ROW){
            txtNomProd.text = String (cString: sqlite3_column_text(stmt, 1))
            txtPrecio.text = String (sqlite3_column_double(stmt, 2))
            txtCnatidad.text = String (sqlite3_column_int(stmt, 3))
            txtTiempo.text = String (sqlite3_column_int(stmt, 4))
        }
    }
    
    @IBAction func btnCargar(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imgVIew?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAgregar(_ sender: UIButton) {
        let nomP = txtNomProd.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let precio = txtPrecio.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cantidad = txtCnatidad.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let tiempo = txtTiempo.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (nomP?.isEmpty)!{
            showAlert(Titulo: "Nombre producto", Mensaje: "Faltan datos")
            txtNomProd.becomeFirstResponder()
            return
        }
        if (precio?.isEmpty)!{
            showAlert(Titulo: "Precio", Mensaje: "Faltan datos")
            txtPrecio.becomeFirstResponder()
            return
        }
        if (cantidad?.isEmpty)!{
            showAlert(Titulo: "Cantidad", Mensaje: "Faltan datos")
            txtCnatidad.becomeFirstResponder()
            return
        }
        if (tiempo?.isEmpty)!{
            showAlert(Titulo: "Tiempo", Mensaje: "Faltan datos")
            txtTiempo.becomeFirstResponder()
            return
        }
        
        let nombr : NSString = nomP! as NSString
        let pre : Int32 = Int32(precio!) as! Int32
        let canti : Int32 = Int32(cantidad!) as! Int32
        let tiem : Int32 = Int32(tiempo!) as! Int32
        
        var stmt:OpaquePointer?
        let sentencia = "INSERT INTO Productos(nomProducto, precio, cantidad, tiempo) values (?,?,?,?)"
        if sqlite3_prepare(db, sentencia, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 1, nombr.utf8String, -1, nil)
            sqlite3_bind_int(stmt, 2, pre)
            sqlite3_bind_int(stmt, 3, canti)
            sqlite3_bind_int(stmt, 4, tiem)
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
            //let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error Insertar", Mensaje: "Error al agregar un producto")
            return
        }
        limpiar()
    }
    
    @IBAction func btnModificar(_ sender: UIButton) {
        
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {

    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
            
        }
        producto.removeAll()
        let query = "SELECT idProducto, nomProducto, precio, cantidad, tiempo FROM Productos Order By nomProducto"
        var stmt: OpaquePointer?
        if (sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK){
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error consultar", Mensaje: errmsg)
            return
        }
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let idp = String(sqlite3_column_int(stmt, 0))
            let nom = String (cString: sqlite3_column_text(stmt, 1))
            let pre = String (sqlite3_column_double(stmt, 2))
            let can = String (sqlite3_column_int(stmt, 3))
            let tie = String (sqlite3_column_int(stmt, 4))
            
            producto.append(Productos(idProd: idp, nomprod:nom, prec:pre, exist:can, tiem:tie))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
        
    }
    
    func limpiar() {
        txtBuscar.text = ""
        txtPrecio.text = ""
        txtNomProd.text = ""
        txtCnatidad.text = ""
        txtTiempo.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueVerMenu"){
            let tableSegue = segue.destination as! TableViewControllerProd
            tableSegue.producto = producto
        }
    }
}
