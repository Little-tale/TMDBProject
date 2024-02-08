//
//  ProfileImageView.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/7/24.
//

import UIKit
import SnapKit

// -> 뷰컨은 데이터를 조리하고 지급
// -> 뷰 )> 그려요

///해당 뷰에는 이밎 뷰 두개에 코너 레디우스 원으로 2개
///밑에는 "사진또는 이미지 수정" Plain 버튼이 있는것으로 추정
final class ProfileViewImage: BaseView {
    let ProfileImageButton = UIButton()
    let genderImageButton = UIButton()
    let allImageView = UIView()
    
    var ProfileImageName : String?
    var gerderImageName : String?
    
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
        allImageView.addSubview(ProfileImageButton)
        allImageView.addSubview(genderImageButton)
        self.addSubview(PhotoOrAvartarModifybutton)
        allImageView.clipsToBounds = true
        allImageView.backgroundColor = .blue
        self.backgroundColor = .gray
    }
    override func configureLayout() {
        // 버튼 위치
        PhotoOrAvartarModifybutton.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)// .inset(20)
            make.width.equalTo(self.safeAreaLayoutGuide).dividedBy(2)
            make.height.equalTo(20)
        }
        // MARK: 이미지 두개 감싼 뷰
        allImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 2)
            make.bottom.equalTo(PhotoOrAvartarModifybutton.snp.top).inset(-8)
        }
        /// 프로필이미지 레이아웃
        ProfileImageButton.snp.makeConstraints { make in
            make.centerY.equalTo(allImageView)
            make.size.equalTo(allImageView.snp.width).multipliedBy(0.4)
            make.leading.equalTo(allImageView.snp.leading)
        }
        
        ProfileImageButton.layer.cornerRadius = ProfileImageButton.frame.height / 2
        ProfileImageButton.clipsToBounds = true
        ///성별 이미지 레이아웃
        genderImageButton.snp.makeConstraints { make in
            make.centerY.equalTo(allImageView)
            // make.verticalEdges.equalTo(allImageView)
            make.trailing.equalTo(allImageView.snp.trailing)
            make.size.equalTo(allImageView.snp.width).multipliedBy(0.4)
        }
       
        
    }// 언스플래쉬
    override func designView() {
        PhotoOrAvartarModifybutton.backgroundColor = .red
        genderImageButton.backgroundColor = .green
        ProfileImageButton.backgroundColor = .cyan
        
        ProfileImageButton.setBackgroundImage(UIImage(systemName: "person.fil"), for: .normal)
    }
    
    
    private func cornerImage() {
        DispatchQueue.main.async {
            self.ProfileImageButton.layer.cornerRadius = self.ProfileImageButton.frame.width / 2
            self.ProfileImageButton.clipsToBounds = true
            self.genderImageButton.layer.cornerRadius = self.genderImageButton.frame.width / 2
            self.genderImageButton.clipsToBounds = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerImage()
    }
    
}
