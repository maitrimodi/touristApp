//
//  WishTableViewCell.swift
//  TouristApp
//
//  Created by Nevil Sheta on 06/04/21.
//

import UIKit

class WishTableViewCell: UITableViewCell {
    @IBOutlet weak var wishAddress: UILabel!
    @IBOutlet weak var wishPhone: UILabel!
    @IBOutlet weak var wishName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
