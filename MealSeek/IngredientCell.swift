//
//  IngredientCell.swift
//  MealSeek
//
//  Created by Zhanat on 08.11.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
   
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
