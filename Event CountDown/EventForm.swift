//
//  EventForm.swift
//  Event CountDown
//
//  Created by Abo Rajhi on 26/12/1445 AH.
//

import SwiftUI

struct Event: Identifiable, Comparable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var color: Color
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.date < rhs.date
    }
}

enum Mode { case add, edit(Event) }

struct EventForm: View {
    
    @Binding var arrEvent: [Event]
    @State var currentMode: Mode
    
    @State private var title : String = ""
    @State private var date : Date = Date()
    @State private var color: Color = Color.black
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            switch currentMode {
            case .add:
                Form {
                        Section("Event Info") {
                            TextField("Enter Event's title ", text: $title)
                                .foregroundStyle(color)
                                .bold()
                            DatePicker("Enter a date", selection: $date)
                                .foregroundStyle(color)
                            ColorPicker("Choose a color", selection: $color)
                                .foregroundStyle(color)
                        }
                }
                .tint(color)
                .navigationTitle("Add Event")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                        Button(action: {
                            let event = Event(title: title, date: date, color: color)
                            onSave(event: event)
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .fontWeight(.bold)
                                .foregroundStyle(title.isEmpty ? Color.gray : Color.blue)
                        })
                        .disabled(title.isEmpty ? true : false)
                }

            case .edit(let eventFromRootView):
               Form {
                       Section("Event Info") {
                           TextField("Edit Event's title ", text: $title)
                               .foregroundStyle(color)
                               .bold()
                           DatePicker("Enter a new date", selection: $date)
                               .foregroundStyle(color)
                           ColorPicker("Choose a new color", selection: $color)
                               .foregroundStyle(color)
                       }
               }
               .tint(eventFromRootView.color)
               .navigationTitle("Edit \(eventFromRootView.title)")
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                       Button(action: {
                           onSave(event: eventFromRootView)
                       }, label: {
                           Image(systemName: "arrow.down.square")
                               .fontWeight(.bold)
                               .foregroundStyle(eventFromRootView.title.isEmpty ? Color.gray : Color.blue)
                       })
                       .disabled(eventFromRootView.title.isEmpty ? true : false)
               }
            }
        }
    }
    func onSave(event : Event){
            let editiedEvent: Event = Event(title: title, date: date, color: color)
            if case .add = currentMode
            {
                arrEvent.append(event)
            }
            else if case .edit = currentMode
            {
                if let index = arrEvent.firstIndex(of: event)
                {
                    print("i have arrived 3")
                    arrEvent[index] = editiedEvent
                }
            }
        self.presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    EventForm(arrEvent: .constant([
                    Event(title: "", date: Date.now, color: Color.red),
                    Event(title: "", date: Date.now, color: Color.red)
    ]), currentMode: .add)
}

