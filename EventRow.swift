//
//  EventRow.swift
//  Event CountDown
//
//  Created by Abo Rajhi on 26/12/1445 AH.
//

import SwiftUI

struct EventRow: View {
    var event : Event
    
    var body: some View {
        
        let format = RelativeDateTimeFormatter()
        let relative = format.localizedString(for: event.date, relativeTo: Date.now)
        
        VStack(alignment: .leading){
            Text(event.title)
                .font(.headline)
                .bold()
                .foregroundStyle(event.color)
            Text(relative)
        }
    }
}

#Preview {
    EventRow(event: Event(title: "h", date: Date(), color: Color.blue))
}
