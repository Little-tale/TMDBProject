//
//  TMDBAPI.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit
import Alamofire

enum TMDBAPI {
    case trend(type: TrendType,language: Language)
    case top(language: Language)
    case popular(language: Language)
    case search(query: String, language: Language)
    
    var baseUrl : String {
        return "https://api.themoviedb.org/3/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization":APIKey.tmdb]
    }
    
    
    // MARK: 앤드포인트 -> 이거 String으로도 되긴하는데 아마 알라모 파이어가 해주는거 같으니 정석으로 갑니다.
    var endPoint: URL {
        switch self {
        case .trend(let type,_):
            let url: URL = URL(string:"\(baseUrl)trending/tv/\(type.get)")!
            return url
        case .top:
            let url: URL = URL(string:"\(baseUrl)tv/top_rated")!
            return url
        case .popular:
            let url: URL = URL(string:"\(baseUrl)tv/popular")!
            return url
        case .search:
            let url: URL = URL(string:"\(baseUrl)search/tv")!
            return url
        }
    }
    
    var parametter : Parameters {
        switch self {
        case .trend(_, let language):
            return ["language": language.get]
        case .top(let language):
            return ["language": language.get]
        case .popular(let language):
            return ["language": language.get]
        case .search(let query,let language):
            return ["language": language.get,"query":query]
        }
    }
    var method: HTTPMethod {
        switch self {
        default: return .get
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
    
}
