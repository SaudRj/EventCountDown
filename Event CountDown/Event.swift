//
//  Event.swift
//  Event CountDown
//
//  Created by Abo Rajhi on 30/12/1445 AH.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Comparable, Hashable {
    var id: UUID = UUID()
    var title: String = ""
    var date: Date = Date()
    var color: Color = Color.black
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.date < rhs.date
    }
}
