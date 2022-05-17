//
//  EnumRoom.swift
//  assignment3
//
//  Created by Matthew Yeung on 17/5/2022.
//

import Foundation

enum RoomType: String, CaseIterable {
    case RoomA = "RoomA"
    case RoomB = "RoomB"
}

struct BookingInformation: Codable {
    var movieTitle: String?
    var date: String?
    var roomName: String?
}

let KEY_BOOKING = "booking"

