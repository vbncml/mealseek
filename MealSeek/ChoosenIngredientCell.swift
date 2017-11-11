//
//  ChoosenIngredientCell.swift
//  MealSeek
//
//  Created by Zhanat on 11.11.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit

class ChoosenIngredientCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func congigureCell(text: String) {
        
        label.text = text
    }
}
