//
//  TableViewControllerUsr.swift
//  CAFETExpress
//
//  Created by Labdesarrollo.3 on 11/25/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit
import SQLite3

class TableViewControllerUsr: UITableViewController {
    var usuario = [Usuarios]()
    var db : OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
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
            let carr = String (cString: sqlite3_column_text(stmt, 2))
            let pwdU = String (cString: sqlite3_column_text(stmt, 3))
            usuario.append(Usuarios(idUsr: noC, nomUsr: nomU, carr: carr, pwd: pwdU))
        }
    }
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuario.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUsr", for: indexPath) as! TableViewCellUsr
        let Usrs: Usuarios
        Usrs = usuario[indexPath.row]
        cell.lblNoCtrlUsr.text = Usrs.idUsuario
        cell.lblNomUsr.text = Usrs.nomUsuario
        cell.lblCarrUsr.text = Usrs.carrera
        cell.lblPwdUsr.text = Usrs.password
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
