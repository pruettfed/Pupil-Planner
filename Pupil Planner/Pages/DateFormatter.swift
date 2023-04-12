//
//  DateFormatter.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import Foundation

func getCurrentFullDate() -> String {
    let date = Date()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let dateString = formatter.string(from: date)
    
    return dateString
}

struct Week : Identifiable {
    var id = UUID()
    
    var dayOfWeek : String
    var date : String
    
    var fullDate : String
}


func getCurrentDayAndDate() -> Week {
    let date = Date()
    let formatter = DateFormatter()
    
    //formats Day of Week
    formatter.dateFormat = "EEEEEE"
    let day = formatter.string(from: date)
    
    //formats Date
    formatter.dateFormat = "dd"
    let dateString = formatter.string(from: date)
    
    formatter.dateFormat = "MM/dd/yyyy"
    let fullDateString = formatter.string(from: date)
    
    let dayAndDate = Week(dayOfWeek: day, date: dateString, fullDate: fullDateString)
    
    return dayAndDate
}
//returns a week object with ex: dayOfWeek: Mo, date: 12, fullDate: 03/12/2021
func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let dateString = formatter.string(from: date)
    
    return dateString
}

func stringToDate(dateString : String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"

    // Convert String to Date
    let date = formatter.date(from: dateString)
    
    return date ?? Date()
}
//returns a date from a string and when combined with dateStyle: date in text -> March 12, 2021
func stringToNiceDate(dateString : String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, yyyy"
    
    let date = stringToDate(dateString: dateString)
    let niceString = formatter.string(from: date)
    
    return niceString
}

func dateToDayOfWeek(dateString : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    
    let dayOfWeekString = formatter.string(from: dateString)
    
    return dayOfWeekString
}
//returns a day of week -> Monday

func toStartOfDay(date : Date) -> Date {
    let toString = dateToString(date: date)
    
    return stringToDate(dateString: toString)
}

func numberOfDaysBetween(startDate: Date, toDate: Date) -> Int {
    let numberOfDays = Calendar.current.dateComponents([.day], from: toStartOfDay(date: startDate), to: toStartOfDay(date: toDate))
            
        return numberOfDays.day!
}

func setBetweenString(daysBetween : Int) -> String {
    var daysBetweenString = ""
    
    if daysBetween == 0 {
        daysBetweenString = "Due today"
    }
    else if daysBetween == 1 {
        daysBetweenString = "Due tommorow"
    }
    else if daysBetween > 1 {
        daysBetweenString = "Due in \(daysBetween) days"
    }
    else if daysBetween == -1 {
        daysBetweenString = "Due yesterday"
    }
    else {
        daysBetweenString = "Due \(daysBetween * -1) days ago"
    }
    
    return daysBetweenString
}

func setBetweenColor(daysBetween : Int) -> String {
    var daysBetweenColor = ""
    
    if daysBetween <= 1 {
        daysBetweenColor = "Red"
    }
    else if daysBetween > 1 && daysBetween < 4 {
        daysBetweenColor = "Yellow"
    }
    else {
        daysBetweenColor = "Green"
    }
    
    return daysBetweenColor
}