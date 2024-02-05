//
//  URLSessionManager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit


class URLSessionManager {
    static let Shared = URLSessionManager()
    private init () {}
    
    /// 해당함수는 URL 세션을 이용하여 통신을 시도할수 있는 메서드 입니다.
    /// T에는 각종 모델을 넣어줄수 있습니다.
    /// 에러 처리와 성공 처리에 대한 컴플리셔 핸들러를 제공합니다.
    func fetchSearchView(api: URLAPI) {
        
        //var url = URLRequest(url: api.endPoint)
        var url = api.endPoint
        url.httpMethod = api.method
        //url.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)
        //url.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        //url.allHTTPHeaderFields
        let header = api.Header
        for (key,value) in header {
            url.addValue(value, forHTTPHeaderField: key)
        }
        
        // 1. URL 세션. 싱글톤. 데이타 URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(data, response, error)
        
            // 에러가 없어야만
            guard error == nil else{
                
                return
            }
            // 데이타가 있어야만
            guard let data = data else {
                
                return
            }
            dump(String(data: data, encoding: .utf8))
            // 응답이 이있어야만
            guard let response = response else{
                
                return
            }
            // 에러가 없어야만
            
            
            
        }.resume() // 유아레 리슘! 꼭 호출
        
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
 
 */
