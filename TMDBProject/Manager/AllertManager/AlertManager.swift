//
//  AlertManager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/5/24.
//

import UIKit

class AlertManager {
    private init() {}
    static let shared = AlertManager()
    
    func getAlert(error: URLError) -> UIAlertController{
        switch error {
        case .noData:
            let alert = errorAlert(title: "데이터가 없습니다.", message: "데이터를 서버에서 불러오지 못했습니다.")
            return alert
        case .noResponse:
            let alert = errorAlert(title: "응답을 받지 못했습니다.", message: "서버에서 응답을 받아오지 못했습니다.")
            return alert
        case .errorResponse:
            let alert = errorAlert(title: "응답코드 문제", message: "응답코드가 정상범위 밖 값입니다.")
            return alert
        case .failRequest:
            let alert = errorAlert(title: "요청에 실패하였습니다.", message: "재시도를 하거나 잠시후에 다시 시도하십시오")
            return alert
        case .errorDecoding:
            let alert = errorAlert(title: "디코딩 에러", message: "디코딩 과정중 에러가 발생했습니다.")
            return alert
        case .unknownError:
            let alert = errorAlert(title: "알수없는 에러", message: "알수없는 에러가 발생했습니다. 관리자에게 문의하세요")
            return alert
        }
    }
    private func errorAlert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acction = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(acction)
        return alert
        
    }
    
    
}
