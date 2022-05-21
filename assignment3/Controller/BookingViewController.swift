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
        bookingInformation = readBooking()
    }

    // function to get date
    @IBAction func getDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        // prevent user to select earlier dates
        DatePicker.minimumDate = Date()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        date = dateFormatter.string(from: DatePicker.date)
    }
    
    // function to load the rooms
    @IBAction func roomSelection(_ sender: UIButton) {
        RoomButtons.forEach({ $0.tintColor = UIColor.gray })
        // sets the colour to be blue for the selected button
        sender.tintColor = UIColor.systemBlue
    }
    
    // function to select correct room
    func getRoomType() -> RoomType {
        for (index, button) in RoomButtons.enumerated() {
            
            // checks if room button is blue
            if button.tintColor == UIColor.gray {
                return RoomType.allCases[index]
            }
        }
        // sets roomA as a default for now
        return .RoomA
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
        // gets correct room value from the function
        let roomName: RoomType = getRoomType()
        movieTitle = MovieTitleLabel.text
        
        let defaults = UserDefaults.standard
        
        if bookingInformation.count < 1 {
            if date == nil {
                let alertDate = UIAlertController(title: "Alert!", message: "Please select a date.", preferredStyle: UIAlertController.Style.alert)
                alertDate.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertDate, animated: true, completion: nil)
            } else {
                // appends information into the array
                bookingInformation.append(BookingInformation(movieTitle: movieTitle, date: date, roomName: roomName.rawValue))
                
                defaults.set(try? PropertyListEncoder().encode(bookingInformation), forKey: KEY_BOOKING)
                let viewController = storyboard?.instantiateViewController(identifier: "BookingDetailViewController") as! BookingDetailViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                viewController.navigationItem.setHidesBackButton(true, animated: true)
            }
        } else{
            // alerts when there is a booking
            let alert = UIAlertController(title: "Alert!", message: "You already have a booking.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
