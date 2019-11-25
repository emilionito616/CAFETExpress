//
//  TableViewCellUsr.swift
//  CAFETExpress
//
//  Created by Labdesarrollo.3 on 11/25/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit

class TableViewCellUsr: UITableViewCell {
    
    
    @IBOutlet weak var lblNoCtrlUsr: UILabel!
    
    @IBOutlet weak var lblNomUsr: UILabel!
    
    @IBOutlet weak var lblCarrUsr: UILabel!
    
    @IBOutlet weak var lblPwdUsr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
