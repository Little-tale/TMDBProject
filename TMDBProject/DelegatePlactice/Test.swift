//
//  Test.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit



class TestClass: StartBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        URLSessionManager.Shared.requestOfSession(type: DetailModel.self, request: URLAPI.top(language: .kor)) { response in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

