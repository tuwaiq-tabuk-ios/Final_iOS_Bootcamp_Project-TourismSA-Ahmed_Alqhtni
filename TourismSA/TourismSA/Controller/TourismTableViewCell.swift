//
//  TourismTableViewCell.swift
//  TourismApps
//
//  Created by Ahmed awadh alqhtani on 11/05/1443 AH.
//

import UIKit

class TourismTableViewCell: UITableViewCell {

    @IBOutlet weak var tourismImage: UIImageView!
    @IBOutlet weak var tourismName: UILabel!
    @IBOutlet weak var tourismAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
