//
//  BookMarkTableViewCell.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/08/01.
//

import UIKit

class BookMarkTableViewCell: UITableViewCell {
    
    @IBOutlet var datatextLabel: UILabel!
    @IBOutlet var ideatextLabel: UILabel!
    @IBOutlet var starImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
