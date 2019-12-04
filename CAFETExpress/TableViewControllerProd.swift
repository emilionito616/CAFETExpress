//
//  TableViewControllerProd.swift
//  CAFETExpress
//
//  Created by Emilio on 11/20/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit
import SQLite3

class TableViewControllerProd: UITableViewController {

    var producto = [Productos]()
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let idp = String (sqlite3_column_int(stmt, 0))
            let nom = String (cString: sqlite3_column_text(stmt, 1))
            let pre = String (sqlite3_column_double(stmt, 2))
            let can = String (sqlite3_column_int(stmt, 3))
            let tie = String (sqlite3_column_int(stmt, 4))
            
            producto.append(Productos(idProd: idp, nomprod:nom, prec:pre, exist:can, tiem:tie))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return producto.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellProd
        let Prod: Productos
        Prod = producto[indexPath.row]
        cell.lblCod.text = Prod.idProducto
        cell.lblCom.text = Prod.nomProducto
        cell.lblExist.text = Prod.existencia
        cell.lblPrec.text = Prod.precio
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "segueDetalle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetalle"{
            let indexPaths = self.tableView.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! ViewControllerDetalle
            vc.codCom = producto[indexPath.row].idProducto
            vc.nomCom = producto[indexPath.row].nomProducto
            vc.precio = producto[indexPath.row].precio
        }
 
        
    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

