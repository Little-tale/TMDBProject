//
//  SettingModel.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import Foundation


enum settingSession: String, CaseIterable {
    case name
    case userName
    case genderName
    case introduce
    case link
    
    var layerName: String {
        switch self {
        case .name:
            "이름"
        case .userName:
            "사용자이름"
        case .genderName:
            "성별 대명사"
        case .introduce:
            "소개"
        case .link:
            "링크"
        }
    }
}
