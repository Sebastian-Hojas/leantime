//
//  Time.swift
//  Leantime
//
//  Created by Sebastian Hojas on 04/03/2017.
//  Copyright © 2017 Sebastian Hojas. All rights reserved.
//

import Foundation

protocol TimeRepresentable: Equatable {
    var timeInterval: TimeInterval { get }
}
extension TimeRepresentable {
    public static func == (left: Self, right: Self) -> Bool {
        return left.timeInterval.isEqual(to: right.timeInterval)
    }
}
protocol DateRepresentable {
    func fromNow() -> Date
}


struct Timespan {
    
    fileprivate var time = CompoundTime.plain(.seconds(0))
    
    static func years(_ years: Int) -> Timespan {
        return Timespan(time: .plain(.years(years)))
    }
    static func weeks(_ weeks: Int) -> Timespan {
        return Timespan(time: .plain(.weeks(weeks)))
    }
    static func days(_ days: Int) -> Timespan {
        return Timespan(time: .plain(.days(days)))
    }
    static func hours(_ hours: Int) -> Timespan {
        return Timespan(time: .plain(.hours(hours)))
    }
    static func minutes(_ minutes: Int) -> Timespan {
        return Timespan(time: .plain(.minutes(minutes)))
    }
    static func seconds(_ seconds: TimeInterval) -> Timespan {
        return Timespan(time: .plain(.seconds(seconds)))
    }
}

extension Timespan {
    public static func + (left: Timespan, right: Timespan) -> Timespan {
        return Timespan(time: CompoundTime.added(left.time, right.time))
    }
    
    public static func - (left: Timespan, right: Timespan) -> Timespan {
        return Timespan(time: CompoundTime.subtracted(left.time, right.time))
    }
    
 }

extension Timespan: TimeRepresentable {
    var timeInterval: TimeInterval {
        return time.timeInterval
    }
}

extension Timespan: DateRepresentable {
    func fromNow() -> Date {
        return time.fromNow()
    }
}


fileprivate enum TimeUnit {
    case years(Int)
    case weeks(Int)
    case days(Int)
    case hours(Int)
    case minutes(Int)
    case seconds(TimeInterval)
}

extension TimeUnit: TimeRepresentable {
    
    var timeInterval: TimeInterval {
        switch self {
        case .years(let years):
            return TimeUnit.days(365).timeInterval * TimeInterval(years)
        case .weeks(let weeks):
            return TimeUnit.days(7).timeInterval * TimeInterval(weeks)
        case .days(let days):
            return TimeUnit.hours(24).timeInterval * TimeInterval(days)
        case .hours(let hours):
            return TimeUnit.minutes(60).timeInterval * TimeInterval(hours)
        case .minutes(let minutes):
            return TimeUnit.seconds(60).timeInterval * TimeInterval(minutes)
        case .seconds(let seconds):
            return seconds
        }
    }
}

extension TimeUnit {
    var dateComponents: Calendar.Component {
        
        var dateComponents = Calendar.Component
        
        switch self {
        case .years(let years):
            return Calendar.Component.day
            dateComponents.year = years
        case .weeks(let weeks):
            dateComponents.day = weeks * 7
        case .days(let days):
            dateComponents.day = days
        case .hours(let hours):
            dateComponents.hour = hours
        case .minutes(let minutes):
            dateComponents.minute = minutes
        case .seconds(let seconds):
            dateComponents.nanosecond = Int(seconds*1000)
        }
        
        return dateComponents
    }
    
    fileprivate func from(date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.component(dateComponents, from: date)
    }
}

fileprivate indirect enum CompoundTime {
    case added(CompoundTime, CompoundTime)
    case subtracted(CompoundTime, CompoundTime)
    case plain(TimeUnit)
}

extension CompoundTime: TimeRepresentable{
    fileprivate var timeInterval: TimeInterval {
        switch self {
        case .added(let a, let b):
            return a.timeInterval + b.timeInterval
        case .subtracted(let a, let b):
            return a.timeInterval - b.timeInterval
        case .plain(let a):
            return a.timeInterval
            
        }
    }
}

extension CompoundTime: DateRepresentable {
    
    fileprivate func from(date: Date) -> Date {
        let calendar = Calendar.current
        
        switch self {
        case .added(let a, let b):
            let aDate =
        case .subtracted(let a, let b):
            return a.timeInterval - b.timeInterval
        case .plain(let a):
            return a.timeInterval
            
        }
    }

}



