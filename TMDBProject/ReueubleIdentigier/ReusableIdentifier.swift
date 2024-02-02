//
//  ReusableIdentifier.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/3/24.
//

import UIKit

// cell 은 UIView 클래스의 제약 조건은 받고 있는것을 확인했다 그래서
// 제네릭으로 반환하는걸 시도해보려고 한다.
// 1차 실패
// 2차시도
class ReusableIdentifier <T: UIView> {
    static var reuseableItentifier : String {
        return String(describing: T.self )
    }
}

//extension <T: UIView> {
//
//}
