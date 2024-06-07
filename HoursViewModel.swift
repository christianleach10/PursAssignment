//
//  HoursViewModel.swift
//  BeastroApp
//
//  Created by Christian Leach on 6/5/24.
//

import Foundation
import Combine
import SwiftUI

class HoursViewModel: ObservableObject {
    @Published var hours: [BusinessHours] = []
    @Published var locationName: String = ""
    private var cancellable: AnyCancellable?

    func fetchHours() {
        guard let url = URL(string: "https://purs-demo-bucket-test.s3.us-west-2.amazonaws.com/location.json") else {
            print("Invalid URL")
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Location.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] location in
                self?.hours = location.hours
                self?.locationName = location.locationName
                print("Fetched hours: \(location.hours)")  // Debugging
            })
    }
    
    func formattedHours() -> [String] {
        let groupedHours = Dictionary(grouping: hours) { $0.dayOfWeek }
        print("Grouped Hours: \(groupedHours)") // Debugging

        let sortedDays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        var formattedHours: [String] = []

        for day in sortedDays {
            if let dayHours = groupedHours[day] {
                let formattedDayHours = dayHours.map { formatHourRange(start: $0.startLocalTime, end: $0.endLocalTime) }
                let dayString = formattedDayHours.joined(separator: ", ")
                print("\(day): \(dayString)") // Debugging
                formattedHours.append("\(day): " + dayString)
            } else {
                formattedHours.append("\(day): Closed")
            }
        }

        print("Formatted Hours: \(formattedHours)") // Debugging
        return formattedHours
    }

    private func formatHourRange(start: String, end: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        // Handle "24:00:00" by converting it to "23:59:59"
        let adjustedEnd = end == "24:00:00" ? "23:59:59" : end

        if start == "00:00:00" && adjustedEnd == "23:59:59" {
            print("Formatting Open 24hrs for start=\(start), end=\(adjustedEnd)")
            return "Open 24hrs"
        }

        guard let startDate = dateFormatter.date(from: start),
              let endDate = dateFormatter.date(from: adjustedEnd) else {
            print("Failed to parse time: start=\(start), end=\(adjustedEnd)")
            return ""
        }

        dateFormatter.dateFormat = "h a"
        let startStr = dateFormatter.string(from: startDate)
        let endStr = adjustedEnd == "23:59:59" ? "12 AM" : dateFormatter.string(from: endDate)

        return "\(startStr)-\(endStr)"
    }

    func currentStatus() -> String {
        // Implement logic to determine the current status text based on business hours
        return "Open until 7pm"
    }

    func statusColor() -> Color {
        // Implement logic to return appropriate color (Green, Red, Yellow)
        return .green
    }
}







