//
//  CategoryImageTableViewCell.swift
//  ResturentAppTest
//
//  Created by mac on 05/02/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CategoryImageTableViewCell: UITableViewCell {
    
   
    @IBOutlet var imageCategories: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
