//
//  ContentView.swift
//  DatePicker
//
//  Created by Samir on 04.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var selectedLocale = Locale.current
    @State private var localeFlag = "🇺🇸"
    
    let flags = ["🇺🇸", "🇫🇷", "🇩🇪", "🇪🇸", "🇮🇹"]
    let locales: [Locale] = [Locale(identifier: "en_US"), Locale(identifier: "fr_FR"), Locale(identifier: "de_DE"), Locale(identifier: "es_ES"), Locale(identifier: "it_IT")]
    
    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            Picker(selection: $localeFlag, label: Text("Select Locale")) {
                ForEach(flags, id: \.self) { flag in
                    Text(flag)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: localeFlag) { newFlag in
                if let index = flags.firstIndex(of: newFlag) {
                    selectedLocale = locales[index]
                }
            }
            
            ForEach(getFormattedDates(), id: \.self) { dateStr in
                Text(dateStr)
                    .padding()
            }
            
            Spacer()
        }
    }
    
    func getFormattedDates() -> [String] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = selectedLocale
        formatter.dateStyle = .full
        
        let dates = [
            calendar.date(byAdding: .day, value: -2, to: selectedDate)!,
            calendar.date(byAdding: .day, value: -1, to: selectedDate)!,
            selectedDate,
            calendar.date(byAdding: .day, value: 1, to: selectedDate)!,
            calendar.date(byAdding: .day, value: 2, to: selectedDate)!
        ]
        
        let dateStrings = dates.map { date in
            let isToday = calendar.isDateInToday(date)
            return isToday ? "Сегодня: \(formatter.string(from: date))" : formatter.string(from: date)
        }
        
        return dateStrings
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
