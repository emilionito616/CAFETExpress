//
//  TableViewCellProd.swift
//  CAFETExpress
//
//  Created by Emilio on 11/20/19.
//  Copyright © 2019 Emilio. All rights reserved.
//

import UIKit

class TableViewCellProd: UITableViewCell {

    @IBOutlet weak var lblCod: UILabel!
    
    @IBOutlet weak var lblCom: UILabel!
    
    @IBOutlet weak var lblExist: UILabel!
    
    @IBOutlet weak var lblPrec: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
