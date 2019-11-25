//
//  Productos.swift
//  CAFETExpress
//
//  Created by Emilio on 11/20/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import Foundation
class Productos{
    var idProducto : String
    var nomProducto : String
    var precio: String
    var existencia : String
    var tiempo : String
    
    init (idProd: String, nomprod: String, prec: String, exist: String, tiem: String){
        self.idProducto = idProd
        self.nomProducto = nomprod
        self.existencia = exist
        self.precio = prec
        self.tiempo = tiem
    }
}
