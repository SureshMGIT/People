//
//  LoaderTableViewCell.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import UIKit

final class LoaderTableViewCell: UITableViewCell {

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
