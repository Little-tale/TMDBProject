//
//  APIManager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit
import Alamofire




class TMDBAPIManager {
    static let shared =  TMDBAPIManager()
    private init() {}
    
    // 프로토콜 제약을 받는 Type Parametter
    // Generic parameter 'T' is not used in function signature -> 그냥 <T> 했을때
    // 일반 매개변수 T는 함수 서명에 사용되지 않습니다.
    // MARK: 일단 메타 타입이란 -> 타입의 타입 -> 타입(자체)을 참조하고 싶어 라는 것.
    // type: T.Type 를 적은 이유 -> 메타 타입 즉 타입의 타입을 알고
    func fetchSearchView<T: Decodable>(type: T.Type, api: TMDBAPI, compliteHandler : @escaping (T) -> Void ) {
        print(api.endPoint)
        print(api.baseUrl)
        print(api.parametter)
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parametter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) {
            response in
            switch response.result {
            case .success(let success):
                compliteHandler(success)
            case .failure(let failure):
                dump(failure)
            }
        }
        
    }
    

}

