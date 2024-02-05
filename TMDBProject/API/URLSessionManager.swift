//
//  URLSessionManager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit

enum URLError{
    case noData
    case noResponse
    case errorResponse
    case failRequest
    case errorDecoding
    case unknownError
}

class URLSessionManager {
    static let Shared = URLSessionManager()
    private init () {}
    
    /// 해당함수는 URL 세션을 이용하여 통신을 시도할수 있는 메서드 입니다.
    /// T에는 각종 모델을 넣어줄수 있습니다.
    /// 에러 처리와 성공 처리에 대한 컴플리셔 핸들러를 제공합니다.
    func fetchSearchView<T:Decodable >(type: T.Type, api: URLAPI, complitionHandler: @escaping (T? , URLError?) -> Void ) {
        
        //var url = URLRequest(url: api.endPoint)
        var url = api.endPoint
        url.httpMethod = api.method
        
        let header = api.Header
        for (key,value) in header {
            url.addValue(value, forHTTPHeaderField: key)
        }
        
        // 1. URL 세션. 싱글톤. 데이타 URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            // print(data, response, error)
        
            DispatchQueue.main.async {
                // 에러가 없어야만
                guard error == nil else{
                    
                    complitionHandler(nil, .failRequest)
                    return
                }
                // 데이타가 있어야만
                guard let data = data else {
                    
                    complitionHandler(nil, .noData)
                    return
                }
                dump(String(data: data, encoding: .utf8))

                
                // 정정 리스폰 코드가 있을때만
                guard let response = response as? HTTPURLResponse else {
                    complitionHandler(nil, .noResponse)
                    return
                }
                guard response.statusCode >= 200 && response.statusCode<300 else {
                    complitionHandler(nil, .errorResponse)
                    return
                }
                
                var json = JSONDecoder()
                
                
                do{
                    let result = try json.decode(T.self, from: data)
                    complitionHandler(result, nil)
                }catch let error {
                    complitionHandler(nil, .errorDecoding)
                    return
                }
            }
            
        }.resume() // 유아레 리슘! 꼭 호출
        // 자이제 통신 데이터 음답 테스트는 완료 했으나 예외는 는 발생할수 있다.
        // 그래서 컴플리셔 이스케이핑 통해 밖에서도 어떻게 처리하게 할지 해보자
    }
    // 반복되는게 많고 가독성도 떨어져 보여서 줄여줄려고 한다.
    func fetchSuccesORFailForStartView<T: Decodable>(type: T.Type, api: URLAPI,dispatchGroup: DispatchGroup, viewController: UIViewController, complitionHandeler: @escaping (T)-> Void) {
        dispatchGroup.enter()
        URLSessionManager.Shared.fetchSearchView(type: T.self, api: api) { success, error in
            dump(error)
            guard error == nil else{
                if let errorSelf = error.self {
                    viewController.present(AlertManager.shared.getAlert(error: errorSelf), animated: true)
                }else {
                    viewController.present(AlertManager.shared.getAlert(error: .unknownError), animated: true)
                }
                dispatchGroup.leave()
                return
            }
            guard let success = success else{
                viewController.present(AlertManager.shared.getAlert(error: .noData), animated: true)
                dispatchGroup.leave()
                return
            }
            
            complitionHandeler(success)
            dispatchGroup.leave()
        }
    }
   
    
}


/*
 헤더도 안넣어주고
 그냥 요청했을때
 print(data, response, error)
 
 Optional(103 bytes) Optional(<NSHTTPURLResponse: 0x6000033283e0> { URL: https://api.themoviedb.org/3/tv/popular } { Status Code: 401, Headers {
     "Alt-Svc" =     (
         "h3=\":443\"; ma=86400"
     );
     "Cache-Control" =     (
         "public, max-age=300"
     );
     "Content-Type" =     (
         "application/json; charset=utf-8"
     );
     Date =     (
         "Mon, 05 Feb 2024 04:59:38 GMT"
     );
     Server =     (
         openresty
     );
     Vary =     (
         Origin
     );
     Via =     (
         "1.1 a6ab345505905317042e086e1f18d372.cloudfront.net (CloudFront)"
     );
     "x-amz-cf-id" =     (
         "mc6MuHuPURJheWRNLgn-CgapgA_kj5SQBHk0hS0sM0Lk_KnQ_CQfhQ=="
     );
     "x-amz-cf-pop" =     (
         "ICN55-C1"
     );
     "x-cache" =     (
         "Error from cloudfront"
     );
 } }) nil
 
 Optional(103 bytes) -> 를 보려면 dump(String(data: data, encoding: .utf8))
 Optional("{\"status_code\":7,\"status_message\":\"Invalid API key: You must be granted a valid key.\",\"success\":false}\n")
   - some: "{\"status_code\":7,\"status_message\":\"Invalid API key: You must be granted a valid key.\",\"success\":false}\n"
 선택 사항("{\"status_code\":7,\"status_message\":\"잘못된 API 키: 유효한 키가 부여되어야 합니다.\",\"success\":false}\n")
   - some: "{\"status_code\":7,\"status_message\":\"잘못된 API 키: 유효한 키를 부여받아야 합니다.\",\"success\":false}\n"
 
 2번쨰 시도 통신 O 읍답코드 Status Code: 200 O Data OK
 
 
 실수 했던것
 // 응답이 이있어야만
//            guard let response = response else{
//                complitionHandler(nil, .noResponse)
//                return
//            }
 // 에러가 없어야만
 
 
//            guard response.statusC >= 200 && response <= 299 else {
//                complitionHandler(nil, .errorResponse)
//                return error
//            }
 
 
 */
