//
//  SectionText.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import Foundation

enum SectionText {
    enum searchView:String, CaseIterable {
        case TREND
        case TOP10
        case POPULAR
    }
    enum DetailView: String, CaseIterable {
        case Poster
        case 출연진들
        case 추천작들
    }
}
