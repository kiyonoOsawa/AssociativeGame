//
//  BananaTableViewCell.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/29.
//

import UIKit

class BananaTableViewCell: UITableViewCell {
    
    @IBOutlet var titletextLabel: UILabel!
    @IBOutlet var datetextLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
