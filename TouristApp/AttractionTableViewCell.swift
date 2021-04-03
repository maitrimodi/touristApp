//
//  AttractionTableViewCell.swift
//  TouristApp
//
//  Created by maitri Modi on 2021-04-02.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {

    //---------------
    // MARK:- Outlets
    //---------------
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var attractionNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
