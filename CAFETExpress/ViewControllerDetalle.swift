//
//  ViewControllerDetalle.swift
//  CAFETExpress
//
//  Created by Labdesarrollo.3 on 11/28/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit

class ViewControllerDetalle: UIViewController {

    var codCom = ""
    var nomCom = ""
    var precio = ""
    var cantidad = ""
    var noCtrl = ""
    
    @IBOutlet weak var lblCodCom: UILabel!
    
    @IBOutlet weak var lblNomCom: UILabel!
    
    @IBOutlet weak var lblPrecio: UILabel!
    
    @IBOutlet weak var txtCantidad: UITextField!
    
    @IBOutlet weak var txtNoControl: UITextField!
    
    
    @IBAction func btnAgregar(_ sender: UIButton) {
        self .performSegue(withIdentifier: "seguePedidos", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        lblCodCom.text = String(codCom)
        lblNomCom.text = String(nomCom)
        lblPrecio.text = String(precio)
        txtCantidad.text = String(cantidad)
    }
}
