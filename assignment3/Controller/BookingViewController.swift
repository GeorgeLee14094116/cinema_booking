//
//  BookingViewController.swift
//  assignment3
//
//  Created by Matthew Yeung on 17/5/2022.
//

import Foundation
import UIKit

class BookingViewController: UIViewController {

    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet var RoomButtons: [UIButton]!
    @IBOutlet weak var MovieTitleLabel: UILabel!
    
    var bookingInformation: [BookingInformation] = [] //array to store the booking information
    var movieTitle: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bookingInformation = readBooking()
    }

    // function to get date
    @IBAction func getDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        DatePicker.minimumDate = Date() // cannot select earlier dates

            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short

            date = dateFormatter.string(from: DatePicker.date)
    }
    
    // function to load the rooms
    @IBAction func roomSelection(_ sender: UIButton) {
        RoomButtons.forEach({ $0.tintColor = UIColor.gray })
        sender.tintColor = UIColor.systemBlue // sets blue for the selected button
    }
    
    // function to select correct room
    func getRoomType() -> RoomType {
        for (index, button) in RoomButtons.enumerated() {
            
            if button.tintColor == UIColor.gray { // checks if room button is blue
                return RoomType.allCases[index]
            }
        }
        return .RoomA // sets roomA as a default
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
    
    // function to make booking
    @IBAction func makeBooking(_ sender: UIButton) {
        let roomName: RoomType = getRoomType() // gets correct room value from the function
        movieTitle = MovieTitleLabel.text
        
        let defaults = UserDefaults.standard
        
        if bookingInformation.count < 1 {
        // appends information into the array
            bookingInformation.append(BookingInformation(movieTitle: movieTitle, date: date, roomName: roomName.rawValue))
            
            defaults.set(try? PropertyListEncoder().encode(bookingInformation), forKey: KEY_BOOKING)
        }
        else{
            // alerts when there is a booking
            let alert = UIAlertController(title: "Alert!", message: "You already have a booking.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
