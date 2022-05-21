//
//  BookingCancelViewController.swift
//  assignment3
//
//  Created by aolong wang on 17/5/22.
//

import UIKit

class BookingCancelViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var bookingInfoLabel: UILabel!
    var bookingInfo: [BookingInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBooking()
    }
    
    // Function for showing booking info to user
    func showBooking () {
        self.bookingInfo = readBooking()
        if bookingInfo.isEmpty {
            bookingInfoLabel.numberOfLines = 2
            bookingInfoLabel.text = "No current booking, \nplease make a booking first."
        } else {
            bookingInfoLabel.textAlignment = .left
            bookingInfoLabel.numberOfLines = 2 + 4 * bookingInfo.count
            for singleBooking in bookingInfo {
                if let movieName = singleBooking.movieTitle, let bookingDate = singleBooking.date, let roomNo = singleBooking.roomName {
                    bookingInfoLabel.text = bookingInfoLabel.text! + "\n\nMovie Name: \(movieName) \nDate: \(bookingDate) \nBooking room: \(roomNo)"
                }
            }
        }
    }
    
    // Function for reading booking info from user defaults
    func readBooking() -> [BookingInformation] {
        let defaults = UserDefaults.standard
        if let savedArrayData = defaults.value(forKey: KEY_BOOKING) as? Data {
            if let array = try? PropertyListDecoder().decode(Array<BookingInformation>.self, from: savedArrayData) {
                return array
            } else {
                return []
            }
        } else {
            return []
        }
    }
    
    // Function for cancel booking
    @IBAction func cancelAction(_ sender: UIButton) {
        // If no booking exists, show an alert message
        if bookingInfo.isEmpty {
            let alert = UIAlertController(title: "Alert!", message: "No current booking.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Otherwise delete booking info
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: KEY_BOOKING)
            defaults.synchronize()
        }
    }
}
