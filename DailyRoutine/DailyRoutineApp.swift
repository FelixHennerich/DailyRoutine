//
//  DailyRoutineApp.swift
//  DailyRoutine
//
//  Created by Felix Hennerich on 02.09.23.
//

import SwiftUI

@main
struct DailyRoutineApp: App {
    var body: some Scene {
        WindowGroup {
            let weekday = getCurrentWeekday()
            switch weekday{
            case "Montag":
                MontagView()
            case "Dienstag":
                DienstagView()
            case "Mittwoch":
                MittwochView()
            case "Donnerstag":
                DonnerstagView()
            case "Samstag":
                SamstagView()
            case "Freitag":
                FreitagView()
            case "Sonntag":
                SonntagView()
            default:
                MontagView()
            }
        }
    }
    
    func getCurrentWeekday() -> String {
            let calendar = Calendar.current
            let today = Date()
            let weekday = calendar.component(.weekday, from: today)
            
            switch weekday {
            case 1:
                return "Sonntag"
            case 2:
                return "Montag"
            case 3:
                return "Dienstag"
            case 4:
                return "Mittwoch"
            case 5:
                return "Donnerstag"
            case 6:
                return "Freitag"
            case 7:
                return "Samstag"
            default:
                return "Unbekannter Wochentag"
            }
        }
}
