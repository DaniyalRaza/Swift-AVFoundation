//
//  YouCell.swift
//  AVFoundationChapter1
//
//  Created by PanaCloud on 03/03/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class YouCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
