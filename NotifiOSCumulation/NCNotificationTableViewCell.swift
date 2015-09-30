//
//  NCNotificationTableViewCell.swift
//  NotifiOSCumulation
//
//  Created by SB 8 on 9/30/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//

import UIKit

class NCNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var unreadIndicatorImageView: UIImageView!
    @IBOutlet weak var notificationDateLabel: UILabel!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var notif_ : NCNotification!
    var notif : NCNotification? {
        
        get {
            
            return notif_
            
        }
        
        set {
            
            notif_ = newValue
            if let newValue_ = newValue {
                
                notificationTitleLabel?.text = newValue_.title
                summaryLabel?.text = newValue_.summary
                let isRead = newValue_.read!.boolValue
                unreadIndicatorImageView.hidden = isRead
                
                let datetimeFormatter = NSDateFormatter()
                datetimeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
                datetimeFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                datetimeFormatter.doesRelativeDateFormatting = true
                notificationDateLabel?.text = datetimeFormatter.stringFromDate(newValue_.dateAdded!)
                
            }
            
        }
        
    }

}
