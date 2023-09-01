//
//  PersonTableViewCell.swift
//  21_06_2023_SqliteDemoJuneBatch
//
//  Created by Vishal Jagtap on 01/09/23.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personIdLabel: UILabel!
    @IBOutlet weak var personAgeLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
