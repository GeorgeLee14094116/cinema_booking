//
//  BookingDetailViewController.swift
//  assignment3
//
//  Created by aolong wang on 17/5/22.
//

import UIKit

class BookingDetailViewController: UIViewController {
    
    @IBOutlet weak var bookingDetailLabel: UILabel!
    var bookingInfo: [BookingInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBooking()
    }
        
    @IBAction func goToHomePage(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // Function for showing booking detail to user
    func showBooking() {
        self.bookingInfo = readBooking()
        if bookingInfo.isEmpty {
            bookingDetailLabel.numberOfLines = 2
            bookingDetailLabel.text = "No current booking, \nplease make a booking first."
        } else {
            bookingDetailLabel.textAlignment = .left
            bookingDetailLabel.numberOfLines = 2 + 4 * bookingInfo.count
            for singleBooking in bookingInfo {
                if let movieName = singleBooking.movieTitle, let bookingDate = singleBooking.date, let roomNo = singleBooking.roomName {
                    bookingDetailLabel.text = bookingDetailLabel.text! + "\n\nMovie Name: \(movieName) \nDate: \(bookingDate) \nBooking room: \(roomNo)"
                }
            }
        }
    }
    
    // Function for read booking info from user defaults
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
}
