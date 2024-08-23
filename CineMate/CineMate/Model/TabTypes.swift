//
//  TabTypes.swift
//  CineMate
//
//  Created by Ryan Lee on 8/7/24.
//

import SwiftUI
import Foundation

enum TabType: Int, CaseIterable {
    case movies, profile, settings, info
    
    func title() -> String {
        switch self {
        case .movies:
            return "movies".capitalized
        case .profile:
            return "profile".capitalized
        case .settings:
            return "settings".capitalized
        case .info:
            return "info".capitalized
        }
    }
    
    func image() -> String {
        switch self {
        case .movies:
            return "play.square.stack.fill"
        case .profile:
            return "person.fill"
        case .settings:
            return "gearshape.fill"
        case .info:
            return "info.circle"
        }
    }
    
}

enum SwipeType {
    case dislike
    case like
}

enum RatingType: Int, CaseIterable {
    case weak, fair, medium, great, fantastic
    
    func colors() -> [Color] {
        return [.red, .orange, .yellow, .blue, .green]
    }
    
    func description() -> String {
        return String(describing: self)
    }
    
    func color() -> Color {
        return colors()[self.rawValue]
    }
    
    func position() -> CGFloat {
        switch self {
        case .weak: return 0.0
        case .fair: return 0.25
        case .medium: return 0.5
        case .great: return 0.75
        case .fantastic: return 1.0
        }
    }
    
    init(rawValue: Int){
        switch rawValue {
        case 1: self = .fair
        case 2: self = .medium
        case 3: self = .great
        case 4: self = .fantastic
        default: self = .weak
        }
    }
}

enum PopularityType: Int, CaseIterable {
    case cool, neutral, hot
    
    func colors() -> [Color] {
        return [.red, .yellow, .green]
    }
    
    func color() -> Color {
        return colors()[self.rawValue]
    }
    
    func description() -> String {
        switch self {
        case .cool: return "😴"
        case .neutral: return "🙂"
        case .hot: return "🤯"
        }
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 1: self = .neutral
        case 2: self = .hot
        default: self = .cool
        }
    }
}
