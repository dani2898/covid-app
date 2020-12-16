//
//  UsuarioTableViewCell.swift
//  Agenda
//
//  Created by Mac13 on 16/11/20.
//  Copyright © 2020 daniela_villa. All rights reserved.
//

import UIKit

class UsuarioTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUsuario: UIImageView!
    @IBOutlet weak var nombreContactoLabel: UILabel!
    @IBOutlet weak var telefonoContactoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
