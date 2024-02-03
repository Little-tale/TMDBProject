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
    case detail(id: Int, language: Language)
    case recommend(id: Int, language: Language)
    case crew(id:Int)
    
    var baseUrl : String {
        return "https://api.themoviedb.org/3/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization":APIKey.tmdb]
    }
    
    
    // MARK: 앤드포인트 -> 이거 String으로도 되긴하는데 아마 알라모 파이어가 해주는거 같으니 정석으로 갑니다.
    /// 몰랐던 사실 추가 만약 하나만 쓸거면 나머지는 _ 로 해야함 정상적으로 나온다 안그러면
    /// id: 62819, language: TMDBProject.TMDBAPI.Language.kor) 같은 자기 맘대로 출력이 나온다.
    /// 이유는 -> 하나만 쓰면 case 에서 각 문자열로 변환할때 단순한 값대신 예상값을 출력해 주기에 (기댓값? ) 그리하여 그렇다.
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
        case .detail(id: let id,_):
            let url: URL = URL(string:"\(baseUrl)tv/\(id)")!
            return url
        case .recommend(id: let id,_):
            let url: URL = URL(string:"\(baseUrl)tv/\(id)/recommendations")!
            return url
        case .crew(id: let id):
            let url: URL = URL(string:"\(baseUrl)tv/\(id)/aggregate_credits")!
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
        case .detail(_,language: let language):
            return ["language": language.get]
        case .recommend(_,language: let language):
            return ["language": language.get]
        case .crew:
            return ["":""]
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
