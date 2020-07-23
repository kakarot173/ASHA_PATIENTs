//
//  DialogCell.swift
//  sample-chat-swift
//
//  Created by Injoit on 9/30/19.
//  Copyright © 2019 Quickblox. All rights reserved.
//

import UIKit

class DialogCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var checkBoxView: UIView!
    @IBOutlet weak var lastMessageDateLabel: UILabel!
    @IBOutlet weak var dialogLastMessage: UILabel!
    @IBOutlet weak var dialogName: UILabel!
    @IBOutlet weak var dialogAvatarLabel: UILabel!
    @IBOutlet weak var unreadMessageCounterLabel: UILabel!
    @IBOutlet weak var unreadMessageCounterHolder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        checkBoxImageView.contentMode = .scaleAspectFit
        unreadMessageCounterHolder.layer.cornerRadius = 12.0
        dialogAvatarLabel.setRoundedLabel(cornerRadius: 20.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        checkBoxView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let markerColor = unreadMessageCounterHolder.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        unreadMessageCounterHolder.backgroundColor = markerColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        let markerColor = unreadMessageCounterHolder.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        unreadMessageCounterHolder.backgroundColor = markerColor
    }
}
