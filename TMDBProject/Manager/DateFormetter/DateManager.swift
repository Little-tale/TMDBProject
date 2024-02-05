//
//  DateManager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit

class DateManager {
    private init() {}
    static let shared = DateManager()
    
    
    func getKorDate(date: String) -> String {
        
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "yyyy-MM-dd"
        
        guard let dateDate = dateFormetter.date(from: date) else {return ""}
        dateFormetter.dateFormat = "yyyy년 M월 d일"
        
        let dateString = dateFormetter.string(from: dateDate)
        return dateString
    }
}
