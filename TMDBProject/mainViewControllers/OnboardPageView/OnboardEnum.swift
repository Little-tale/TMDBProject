//
//  OnboardImageEnum.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/4/24.
//

import Foundation


enum OnboardEnum{
    case first
    case second
    case third
    
    var image: String {
        switch self {
        case .first:
            return "firstImage"
        case .second:
            return "SecondImage"
        case .third:
            return "LastImage"
        }
    }
    
    var text: String {
        switch self {
        case.first:
            return "요즘 영화 뭘 볼지\n고민이신가요?"
        case .second:
            return "다양한 영화들을\n찾아보세요"
        case .third:
            return "자세한 정보들을\n바로 바로!"
        }
    }
}
