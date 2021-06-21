//
//  AddTableViewCell.swift
//  Associative game
//
//  Created by 大澤清乃 on 2021/06/20.
//

import UIKit

class AddTableViewCell: UITableViewCell {
    
    //セル内を宣言
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var ideaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
