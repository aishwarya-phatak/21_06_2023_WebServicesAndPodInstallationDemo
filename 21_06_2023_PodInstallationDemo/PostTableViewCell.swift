//
//  PostTableViewCell.swift
//  21_06_2023_PodInstallationDemo
//
//  Created by Vishal Jagtap on 01/08/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postIdLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
