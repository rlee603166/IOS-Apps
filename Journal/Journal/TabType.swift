//
//  TabType.swift
//  Journal
//
//  Created by Ryan Lee on 8/6/24.
//

import Foundation
import SwiftUI

enum TabType: Int, CaseIterable {
    case workouts, settings, info
    
    func title() -> String {
        switch self {
        case .workouts:
            return "workouts".capitalized
        case .settings:
            return "settings".capitalized
        case .info:
            return "info".capitalized
        }
    }
    
    func image() -> String {
        switch self {
        case .workouts:
            return "figure.martial.arts"
        case .settings:
            return "gearshape.fill"
        case .info:
            return "info"
        }
    }
    
}
