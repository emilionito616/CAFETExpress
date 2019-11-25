//
//  Usuarios.swift
//  CAFETExpress
//
//  Created by Emilio on 11/15/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import Foundation
class Usuarios{
    var idUsuario: String
    var nomUsuario: String
    var carrera: String
    var password: String
    
    init(idUsr: String, nomUsr: String, carr: String, pwd: String) {
        self.idUsuario = idUsr
        self.nomUsuario = nomUsr
        self.carrera = carr
        self.password = pwd
    }
}
