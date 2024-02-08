//
//  NaverAPI.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/8/24.
//

import Foundation

//protocol URLRequest{
//    
//}

enum NaverError: Error{
    case nodata
    case noResponse
    case errorResponse
    case failRequest
    case errorDecoding
    case cantStatusCoding
    case unknownError
    case componatsError
}

protocol UrlSession{
    var baseUrl : String {get}
    var query : URLQueryItem {get}
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
    
    var query: URLQueryItem {
        switch self {
        case .searchImage(searchText: let searchText,_):
            let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed )
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

struct NaverComponets {
    
}
// 원래 있는걸 써도 좋지만 연습을 위해 계속 만듭니다.
typealias naverUrl<T:Decodable> = (Result<T,NaverError>) -> Void
typealias urlRequestTest<T:Decodable> = Result<T,NaverError>
typealias urlTest = Result<URLRequest,NaverError>

class URLSessionNaver {
    private init() {}
    
    static let shared =  URLSessionNaver()

    func fetchSession<T: Decodable>(type: T.Type, API: UrlSession, completionHandler: @escaping naverUrl<T>) {
    
        let componentsTest = componentsErrorCatch(API:API)
        switch componentsTest {
        case .success(let url):
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    let result = self.urlErrorCatch(type:T.self, data: data, response: response, error: error)
                    switch result {
                    case .success(let success) :
                        completionHandler(.success(success))
                    case .failure(let failer) :
                        completionHandler(.failure(failer))
                    }
                }
            }.resume()
        case .failure(let error) :
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        
    }
    
    // MARK: 컴포넌트 전용 에러 캐치
    private func componentsErrorCatch(API:UrlSession) -> urlTest{
        var urlComponents = URLComponents()
        urlComponents.scheme = API.schem
        urlComponents.host = API.host
        urlComponents.path = "/" + API.path
        urlComponents.queryItems = [API.query]
        // urlComponents.queryItems = API.header
        
        // print(urlComponents.queryItems)
        
        guard let url = urlComponents.url else {
            print("url 컴포넌츠 미스")
            return .failure(.componatsError)
        }
        
        var urlRe = URLRequest(url: url)
        print(urlRe.headers)
        urlRe.allHTTPHeaderFields = API.header
        
        print(urlRe.headers)
        return .success(urlRe)
    }
    
    
    // MARK: URL 테스트 전용 에러 캐치
    private func urlErrorCatch<T:Decodable>(type:T.Type, data: Data?, response: URLResponse?, error: Error?) -> urlRequestTest<T> {
        guard error == nil else {
            print("에러가 존재 즉 요청실패입니다.")
            return urlRequestTest.failure(.failRequest)
        }
        guard let data = data else {
            print("에러는 없으나 데이터가 없습니다.")
            return urlRequestTest.failure(.nodata)
        }
        print(data)
        guard let response = response else {
            print("에러는 없으나 응답이 오지 않았습니다.")
            return urlRequestTest.failure(.noResponse)
        }
        print(response)
        guard let response = response as? HTTPURLResponse else {
            print("응답은 있었으나 응답코드로 변경을 싪패")
            return urlRequestTest.failure(.errorResponse)
        }
        print(response.statusCode)
        guard response.statusCode == 200 else {
            print("응답코드 200이 아닌 상황 발생")
            return urlRequestTest.failure(.cantStatusCoding)
        }
        
        do{
            let result = try JSONDecoder().decode(T.self, from: data)
            return urlRequestTest.success(result)
        } catch {
            print("디코딩에 실패 하였습니다.")
            return urlRequestTest.failure(.errorDecoding)
        }
        
    }
    
}
