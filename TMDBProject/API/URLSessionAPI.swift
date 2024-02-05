//
//  URLSessionAPI.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit

enum URLAPI {
    case trend(type: TrendType,language: Language?)
    case top(language: Language?)
    case popular(language: Language?)
    
    var baseUrl : String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URLRequest {
        switch self {
        case .trend(let type,_):
            let url: URL = URL(string:"\(baseUrl)trending/tv/\(type.get)")!
            let urlRequest = URLRequest(url: url)
            return urlRequest
        case .top:
            let url: URL = URL(string:"\(baseUrl)tv/top_rated")!
            let urlRequest = URLRequest(url: url)
            return urlRequest
        case .popular:
            let url: URL = URL(string:"\(baseUrl)tv/popular")!
            let urlRequest = URLRequest(url: url)
            return urlRequest
        }
    }
    
    var Header: [String: String] {
        switch self {
        default:  return ["Authorization":APIKey.tmdb]
        }
    }
    enum TrendType {
        case day
        case week
        
        var get : String {
            switch self {
            case .day:
                return "day"
            case .week:
                return "week"
            }
        }
    }
    enum Language {
        case kor
        case eng
        
        var get: String {
            switch self {
            case .kor:
                "ko-KR"
            case .eng:
                "en-US"
            }
        }
    }
    
    var method : String {
        switch self {
        case .trend:
            "GET"
        case .top:
            "GET"
        case .popular:
            "GET"
        }
    }
    
}

