//
//  LastViewController.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/4/24.
//

import UIKit
import SnapKit

class LastViewController: StartBaseViewController {
    let imageView = OnboardSampleImageView(frame: .zero)
    let explainLabel = OnboardLabel()
    let startButton = UIButton()
    
    override func configureHierarchy() {
        self.view.backgroundColor = .black
        self.view.addSubview(imageView)
        self.view.addSubview(explainLabel)
        self.view.addSubview(startButton)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            // make.centerY.equalTo(view.safeAreaLayoutGuide).offset( -60 )
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.width.equalTo(UIScreen.main.bounds.width / 1.5 )
            make.height.equalTo(imageView.snp.width).multipliedBy(1.7)
        }
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset( -30 )
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.lessThanOrEqualTo(100)
            // make.horizontalEdges.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(40)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-40)
        }
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
            make.top.equalTo(explainLabel.snp.bottom).inset( -24 )
        }
        
    }
    override func designView() {
        imageView.backgroundColor = .brown
        imageView.image = UIImage(named: OnboardEnum.third.image)
        imageView.contentMode = .scaleAspectFill
        // explainLabel.backgroundColor = .red
        explainLabel.numberOfLines = 3
        explainLabel.clipsToBounds = true
        explainLabel.text = OnboardEnum.third.text
        buttonLayout()
    }
    
    func buttonLayout() {
        var config = UIButton.Configuration.filled()
        
        config.title = "시작하기"
        config.baseBackgroundColor = .red
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        
        startButton.configuration = config
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    // MARK: 시작 버튼 클릭시 루트뷰 변경
    @objc func startButtonClicked(for sender: UIButton) {
        print("클릭됨")
        
        UserDefaltsManager.shared.userInfo = true
        
        let nav = UINavigationController(rootViewController: StartViewController())
        
        let secondNav = UINavigationController(rootViewController:  GenreViewCon())
        let tabber = UITabBarController()
        
        let firstTab = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        let seccondTab = UITabBarItem(title: "장르", image: UIImage(systemName: "fleuron"), tag: 1)
        
        nav.tabBarItem = firstTab
        secondNav.tabBarItem = seccondTab
        
        tabber.viewControllers = [nav, secondNav]
        
        if let window = UIApplication.shared.windows.first {
//            transitrionView(viewInstens: nbc, tresitionStyle: .pushNavigation)
            UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve) {
                window.rootViewController = tabber
            }
            window.makeKeyAndVisible()
        }
//         transitionView(viewType: StartViewController.self, tresitionStyle: .pushNavigation)
//        transitrionView(viewInstens: nbc, tresitionStyle: .pushNavigation)
        //transitionView(viewType: StartViewController.self, tresitionStyle: .pushNavigation)
    }
    
}
