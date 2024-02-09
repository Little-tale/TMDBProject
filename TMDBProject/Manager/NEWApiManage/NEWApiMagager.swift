//
//  NEWApiMagager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/9/24.
//

import Foundation

typealias naverUrl<T:Decodable> = (Result<T,Error>) -> Void

typealias urlRequestTest<T:Decodable> = Result<T,NewAPIManagerRequestError>

typealias urlTest = Result<URLRequest,NewAPIManagerRequestError>

final class NEWURLSessionMAnager {
    private init() {}
    
    static let shared =  NEWURLSessionMAnager()

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
        if let apikeys = API.query {
            urlComponents.queryItems = [apikeys]
        }
        
        // urlComponents.queryItems = API.header
        
        // print(urlComponents.queryItems)
        
        guard let url = urlComponents.url else {
            print("url 컴포넌츠 미스")
            return .failure(.componatsError)
        }
        
        var urlRe = URLRequest(url: url)
        print(urlRe.headers)
        urlRe.allHTTPHeaderFields = API.header
        
        // print(urlRe.headers)
        print(urlRe.url)
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
            if response.statusCode == 400{
                print("정상적인 쿼리가 아님")
            }
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
