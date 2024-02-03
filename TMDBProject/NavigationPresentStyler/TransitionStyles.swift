//
//  NavigationStyles.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

// 자 이제 또한번에 제네릭과의 싸움이다
// 자 다시! 제네릭 너 뭐하고?
// 타입 파라미터 입니다!
// 그래 그럼 너가 하는일이 뭐야
// 일반적인 타입 혹은 클래스 혹은 프로토콜의 제약을 받는 타입이면 다 받아 드립니다!
// 그래 그럼 이제 오늘 배운 네비게이션 보네기 해보자

// 방금 깨닳았는데 스토리 보드가 없는뎅
// 코드베이스롷 일단 만들어 보지뭐

enum TransitionStyles {
    case present
    case presentFullScreen
    case pushNavigation
    case presentOfNavigation
    case presentOfNavigationFullScreen
}

extension UIViewController {
    // MARK: 와 이게 문제였다.
    // 전환할때 요놈이 나를 망쳤다
    
    func transitionView<T: UIViewController>(view: T, tresitionStyle: TransitionStyles) {
        //let vc = view
        switch tresitionStyle {
        case .present:
            present(view, animated: true)
        case .presentFullScreen:
            view.modalPresentationStyle = .fullScreen
            present(view, animated: true)
        case .pushNavigation:
            navigationController?.pushViewController(view, animated: true)
        case .presentOfNavigation:
            let nav = UINavigationController(rootViewController: view)
            present(nav,animated: true)
        case .presentOfNavigationFullScreen:
            let nav = UINavigationController(rootViewController: view)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated: true)
            
        }
    }
}
