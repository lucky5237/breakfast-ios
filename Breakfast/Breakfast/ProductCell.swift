//
//  ProductCell.swift
//  Breakfast
//
//  Created by 卢键 on 2017/6/8.
//  Copyright © 2017年 卢键. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var saleNum: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
