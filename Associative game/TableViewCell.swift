//
//  TableViewCell.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/30.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var tabletextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
