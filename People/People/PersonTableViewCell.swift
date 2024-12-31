//
//  PersonTableViewCell.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import UIKit

final class PersonTableViewCell: UITableViewCell {

    @IBOutlet var professionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var personImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
