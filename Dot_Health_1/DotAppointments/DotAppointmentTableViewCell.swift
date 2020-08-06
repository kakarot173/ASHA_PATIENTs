//
//  DotAppointmentTableViewCell.swift
//  Dot_Health_1
//
//  Created by MUKESH BARIK on 11/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit

class DotAppointmentTableViewCell: UITableViewCell {


    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var hospitalNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //to have full length cell separator
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        dateLabel.font = UIFont(name: Theme.mainFontName, size: 17)
        dateLabel.textColor = Theme.accentColor
        issueLabel.font = UIFont(name: Theme.mainFontName, size: 17)
        doctorNameLabel.font = UIFont(name: Theme.mainFontName, size: 17)
        hospitalNameLabel.font = UIFont(name: Theme.mainFontName, size: 17)
        timeLabel.font = UIFont(name: Theme.mainFontName, size: 17)
        statusLabel.font = UIFont(name: Theme.mainFontName, size: 17)
        
        dateLabel.contentMode = .center
        dateLabel.lineBreakMode = .byWordWrapping
        timeLabel.contentMode = .center
        timeLabel.lineBreakMode = .byWordWrapping
        
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(appointmentModel: DotAppointmentModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        self.issueLabel.text = appointmentModel.purpose
        self.hospitalNameLabel.text = appointmentModel.provider_name
        self.doctorNameLabel.text = appointmentModel.provider_name
        self.dateLabel.text = appointmentModel.slot_date//dateFormatter.string(from: appointmentModel.date)
        self.timeLabel.text = appointmentModel.start_time//timeFormatter.string(from: appointmentModel.date)
//        self.statusLabel.text = appointmentModel.status
//        self.setStatusColor(status: appointmentModel.status)
        self.statusLabel = UtilityFunctions.setStatusColor(status: appointmentModel.status, label: self.statusLabel)
       }
   /* func setStatusColor(status: String){
        switch status {
        case "Attended":
            self.statusLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.timeLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case "Scheduled":
            self.statusLabel.textColor = #colorLiteral(red: 1, green: 0.462533474, blue: 0, alpha: 1)
            self.timeLabel.textColor = #colorLiteral(red: 1, green: 0.462533474, blue: 0, alpha: 1)
        case "Missed":
            self.statusLabel.textColor = #colorLiteral(red: 0.9034865499, green: 0, blue: 0.2168298364, alpha: 1)
            self.timeLabel.textColor = #colorLiteral(red: 0.9034865499, green: 0, blue: 0.2168298364, alpha: 1)
        default:
            self.timeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }*/
}
