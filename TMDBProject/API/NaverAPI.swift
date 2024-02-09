//
//  NaverAPI.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import Foundation




enum NewAPIManagerRequestError: Error{
    case nodata
    case noResponse
    case errorResponse
    case failRequest
    case errorDecoding
    case cantStatusCoding
    case unknownError
    case componatsError
}

/*
 URL Session 의 컴포넌트 방식으로 하지만
 BaseUrl를 구현하라고 한 이유는 만일의 사태일때 그것으로 대체하라는 의미에 두었습니다.
 */
protocol UrlSession{
    var baseUrl : String {get}
    var query : URLQueryItem? {get}
    var header : [String: String] {get}
    var method : String {get}
    
    var schem : String{get}
    var host: String {get}
    var path: String {get}
}

enum naverApi:UrlSession {
    case searchImage(searchText: String, APiKey: NaverAPIKey)
    
    var schem : String {
        switch self {
        case .searchImage:
            return "https"
        }
    }
    
    var baseUrl: String {
        switch self {
        case .searchImage:
            return "https://openapi.naver.com/v1/search/image"
        }
    }
    
    var query: URLQueryItem? {
        switch self {
        case .searchImage(searchText: let searchText,_):
            // let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed )
            return URLQueryItem(name: "query", value: searchText)
        }
    }
    var header: [String: String] {
        switch self {
        case .searchImage(_, APiKey: let apikey):
            //let test = naverClient + naverSecret
            return apikey.queryItems
        }
    }
    
    var method: String {
        switch self {
        case .searchImage:
            return "GET"
        }
    }
    
    var host: String {
        switch self {
        case .searchImage:
            return "openapi.naver.com"
        }
    }
    
    var path: String{
        switch self {
        case .searchImage:
            return "v1/search/image"
        }
    }
    
   
    
}

enum NewTMDB: UrlSession {
    case videos(key: Int)
    /*schme: https
     host: api.themoviedb.org
     path: /3/tv/{series_id}/videos
     qury: NULL*/
    
    var baseUrl: String {
        switch self {
        case .videos(let key):
            return "https://api.themoviedb.org/3/tv/\(key)/videos"
        }
    }
     // MARK: Base URL 을 쓰진 않지만 그렇다면 조립할수 있다면? -> 이것도 좋기는 한데.... 에러 처리가 애매해짐...
//    var testBaseUrl: URL {
//        switch self {
//        case .videos(let key):
//            var component = URLComponents()
//            component.scheme = "https"
//            component.host = "api.themoviedb.org"
//            component.path = "3/tv/\(key)/videos"
//            component.url
//            
//        }
//    }
    
    var query: URLQueryItem? {
        switch self {
        case .videos:
            return nil
        }
    }
    
    var header: [String : String] {
        return TMDBAPIkey().getAPI
    }
    
    var method: String {
        return "GET"
    }
    
    var schem: String {
        switch self {
        case .videos(let key):
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .videos(let key):
            "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .videos(let key):
            "/3/tv/\(key)/videos"
        }
    }
    
    
}
// 원래 있는걸 써도 좋지만 연습을 위해 계속 만듭니다.


