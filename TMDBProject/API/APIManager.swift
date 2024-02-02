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
    // type: T.Type 를 적은 이유 -> 메타 타입 즉 타입의 타입을 알고 즉 자체에 접근해서 사용하려는 건데
    // 중요한건 안쓴다는 거다. 몽말이냐? 내가 of: type 이라한다면 사용하는 거지만
    // 정작 T.self 메타타입(나야~) 를 사용하게 된다면 그저 타입을 명시하려는 목적에서 사용한다는 것이다.
    // 제네릭 함수에서 타입 자체를 매개변수로 받고자 할 때는 T.Type을 사용하고, 이를 호출할 때는 타입.self를 사용하여 해당 타입의 메타 타입 인스턴스를 전달한다.
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

