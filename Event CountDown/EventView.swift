//
//  EventView.swift
//  Event CountDown
//
//  Created by Abo Rajhi on 26/12/1445 AH.
//

import SwiftUI


struct EventView: View {
    @State var arrEvent :[Event] = []
    var body: some View {
        NavigationStack{
            List{
                ForEach(arrEvent.sorted()){
                        event in
                    NavigationLink(destination: EventForm(arrEvent: $arrEvent, currentMode: .edit(event) ))
                        {
                            EventRow(event: event)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        arrEvent.remove(atOffsets: indexSet)
                    })
                
            }
            .navigationDestination(for: Event.self) {
                event in
                EventForm(arrEvent: $arrEvent, currentMode: .edit(event))
            }
            .navigationTitle("Events")
            .toolbar{
                NavigationLink(destination: EventForm(arrEvent: $arrEvent, currentMode: .add))
                {
                    Image(systemName: "plus")
                        .font(.headline)
                }
                
            }            
        }
    }
}

#Preview {
    EventView()
}
