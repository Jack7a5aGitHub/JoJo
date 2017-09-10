//
//  ToDoListCell.swift
//  MyProfolio
//
//  Created by Jack Wong on 2017/09/01.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class ToDoListCell: UITableViewCell {

    @IBOutlet weak var tableViewCell: UIView!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
