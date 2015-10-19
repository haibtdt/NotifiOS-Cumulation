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
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        editingAccessoryType = .None
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
            
            let bundle = NSBundle(forClass: self.classForCoder)
            thumbnailImage.image = UIImage(named: "no_pic", inBundle: bundle, compatibleWithTraitCollection: nil)

            
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
                
                
                if newValue_.imageURL != nil && newValue_.imageURL!.isEmpty == false {
                    
                    let imageURL = NSURL(string: newValue_.imageURL!)!
                    if let notifImage = UIImage(contentsOfFile: imageURL.path!) {
                        
                        thumbnailImage.image = notifImage
                        
                    }
                    
                }
                
            }
            
        }
        
    }

}
