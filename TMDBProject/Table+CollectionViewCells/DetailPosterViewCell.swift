
/*
 1. 필요한것.
 -> 이미지뷰
 -> 이름
 -> 줄거리
 -> 날짜
 
 */
import UIKit
import SnapKit
import Kingfisher

final class DetailPosterViewCell : BaseTableViewCell {
    
    let backDropImageView = UIImageView()
    let miniPosterView = UIImageView()
    /// 해당 뷰는 해당 컨텐츠의 줄고리와 날짜, 이름이 적용되어있는 것입니다.
    let detailView = overviewView()
    let youtubeWebView = UIWebView()
    
    override func configureHierarchy() {
        contentView.addSubview(backDropImageView)
        backDropImageView.addSubview(detailView)
        backDropImageView.addSubview(miniPosterView)
        backDropImageView.addSubview(youtubeWebView)
    }
    
    override func configureLayout() {
        backDropImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 1.7).priority(100)
        }
        
        detailView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(backDropImageView.snp.bottom).inset(8)
            make.height.equalTo(170)
        }
        
        miniPosterView.snp.makeConstraints { make in
            make.bottom.equalTo(detailView.snp.top).inset( -12 )
            make.leading.equalTo(detailView.snp.leading).inset(4)
            make.width.equalTo(100)
            make.height.equalTo(miniPosterView.snp.width).multipliedBy(1.5)
        }
        youtubeWebView.snp.makeConstraints { make in
            make.trailing.equalTo(detailView.snp.trailing)
            make.top.equalTo(miniPosterView.snp.top)
            make.bottom.equalTo(miniPosterView.snp.bottom)
            make.width.equalTo(youtubeWebView.snp.height).multipliedBy(1.5)
            make.leading.greaterThanOrEqualTo(miniPosterView.snp.trailing).offset(15)
        }
        
    }
    override func designView() {
        contentView.backgroundColor = .black
        self.backgroundColor = .black

        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        imageViewSetting()
    }
    
    private func imageViewSetting() {
        backDropImageView.contentMode = .scaleAspectFill
        miniPosterView.contentMode = .scaleAspectFill
        
        miniPosterView.layer.cornerRadius = 12
        miniPosterView.clipsToBounds = true
        
        backDropImageView.layer.cornerRadius = 12
        backDropImageView.clipsToBounds = true
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepare(backDropImage: nil, miniPoster: nil)
        prepareForInfo(name: nil, overView: nil, date: nil)
    }
    func prepare(backDropImage: URL?,miniPoster: URL?) {
        self.miniPosterView.isHidden = false
    
        if let backDrop = backDropImage {
            print(backDrop)
            guard let poster = miniPoster else {
                self.backDropImageView.kf.setImage(with: backDrop,options:[
                    .transition(.fade(0.5)),
                    .forceTransition
                  ])
                print("포스터 정보 없음요")
                miniPosterView.isHidden = true
                return
            }
            
            self.backDropImageView.kf.setImage(with: backDrop,options:[
                .transition(.fade(0.5)),
                .forceTransition
              ])
            self.miniPosterView.kf.setImage(with: poster,options:[
                .transition(.fade(0.5)),
                .forceTransition
              ])
        }
        backDropImageView.backgroundColor = .darkGray
        miniPosterView.backgroundColor = .gray
    }
    
    func prepareForInfo(name: String?, overView: String?, date: String?) {
        detailView.nameLabel.text = name
        // print(overView,"✂️✂️✂️✂️✂️✂️✂️✂️")
        
        if overView == "" {
            detailView.overViewLabel.text = "현재는 줄거리 정보가 없어요 빠르게 준비 할께요!"
        } else {
            detailView.overViewLabel.text = overView
        }
        
        guard let dateinfo = date else {
            
            detailView.dateLabel.text = ""
            return
        }
        detailView.dateLabel.text = dateinfo
    }
    
}
