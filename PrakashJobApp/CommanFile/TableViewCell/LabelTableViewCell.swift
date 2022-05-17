//
//  LabelTableViewCell.swift
//  ProjectSetUp
//
//  Created by PSSPL on 03/05/22.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.selectionStyle = .none
    }

}
