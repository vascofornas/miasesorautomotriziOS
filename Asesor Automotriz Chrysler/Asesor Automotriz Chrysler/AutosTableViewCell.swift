//
//  AutosTableViewCell.swift
//  Asesor Automotriz Chrysler
//
//  Created by MODESTO VASCO FORNAS on 6/1/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import UIKit

class AutosTableViewCell: UITableViewCell {

    @IBOutlet weak var modeloLabel: UILabel!
    @IBOutlet weak var anoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
