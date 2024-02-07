//
//  ProfileImageView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import UIKit
import SnapKit

///해당 뷰에는 이밎 뷰 두개에 코너 레디우스 원으로 2개
///밑에는 "사진또는 이미지 수정" Plain 버튼이 있는것으로 추정
class ProfileViewImage: BaseView {
    let ProfileImageView = UIImageView()
    let genderImageView = UIImageView()
    let allImageView = UIView()
    
    let PhotoOrAvartarModifybutton : UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .blue
        config.baseBackgroundColor = .clear
        view.configuration = config
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(allImageView)
        allImageView.addSubview(ProfileImageView)
        allImageView.addSubview(genderImageView)
        self.addSubview(PhotoOrAvartarModifybutton)
    }
    override func configureLayout() {
         // layoutIfNeeded()
        PhotoOrAvartarModifybutton.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        // MARK: 이미지 두개 감싼 뷰
        allImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(140)
            make.bottom.equalTo(PhotoOrAvartarModifybutton.snp.top).inset(8)
        }
        /// 프로필이미지 레이아웃
        ProfileImageView.snp.makeConstraints { make in
            //make.width.equalTo(40)
           // make.height.equalTo(ProfileImageView.snp.width)
            make.verticalEdges.leading.equalTo(allImageView)
            make.size.equalTo(allImageView.snp.width).dividedBy(2)
        }
        ///성별 이미지 레이아웃
        genderImageView.snp.makeConstraints { make in
//            make.width.height.equalTo(ProfileImageView.snp.width)
            // make.height.equalTo(ProfileImageView.snp.width)
            make.verticalEdges.trailing.equalTo(allImageView)
            make.size.equalTo(allImageView.snp.width).dividedBy(2)
        }
        
        
    }// 언스플래쉬
    override func designView() {
        PhotoOrAvartarModifybutton.backgroundColor = .red
        // ProfileImageView.backgroundColor = .blue
        genderImageView.backgroundColor = .green
        ProfileImageView.backgroundColor = .cyan
        
    }
    
    func cornerImage() {
        DispatchQueue.main.async {
            self.ProfileImageView.layer.cornerRadius = self.ProfileImageView.frame.width / 2
            self.genderImageView.layer.cornerRadius = self.genderImageView.frame.width / 2
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerImage()
    }
    
}

