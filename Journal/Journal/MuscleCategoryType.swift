//
//  MuscleCategoryType.swift
//  Journal
//
//  Created by Ryan Lee on 7/30/24.
//

import SwiftUI

enum MuscleCategoryType: Int, CaseIterable {
    case chest, biceps, quads, back, shoulders, glutes, abs
    
    func description() -> String {
        return String(describing: self)
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .chest
        case 1: self = .biceps
        case 2: self = .quads
        case 3: self = .back
        case 4: self = .shoulders
        case 5: self = .glutes
        default: self = .abs
        }
    }
}

enum QualityCategoryType: Int, CaseIterable {
    case terrible, bad, worse, no_opinion, good, best, perfect
    
    func description() -> String {
        switch self {
        case .terrible: return "😡"
        case .bad: return "🫠"
        case .worse: return "😪"
        case .no_opinion: return "🤷‍♂️"
        case .good: return "🙂"
        case .best: return "🤩"
        case .perfect: return "🤯"
        }
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .terrible
        case 1: self = .bad
        case 2: self = .worse
        case 3: self = .good
        case 4: self = .best
        case 5: self = .perfect
        default: self = .no_opinion
        }
    }
    
}
