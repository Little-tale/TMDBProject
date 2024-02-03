
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

class DetailPosterViewCell : BaseTableViewCell {
    
    let backDropImageView = UIImageView()
    let miniPosterView = UIImageView()
    let detailView = overviewView()
    
    override func configureHierarchy() {
        contentView.addSubview(backDropImageView)
        backDropImageView.addSubview(detailView)
        backDropImageView.addSubview(miniPosterView)
    }
    
    override func configureLayout() {
        backDropImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 1.7).priority(100)
        }
        detailView.snp.makeConstraints { make in
            
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(backDropImageView.snp.bottom).inset(8)
            make.height.equalTo(200)
        }
        
        miniPosterView.snp.makeConstraints { make in
            make.bottom.equalTo(detailView.snp.top).inset( -12 )
            make.leading.equalTo(detailView.snp.leading).inset(4)
            make.width.equalTo(100)
            make.height.equalTo(miniPosterView.snp.width).multipliedBy(1.5)
        }
    }
    override func designView() {
        contentView.backgroundColor = .black
       // backDropImageView.backgroundColor = .red
        // detailView.backgroundColor = .gray
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        backDropImageView.layer.cornerRadius = 12
        backDropImageView.clipsToBounds = true
        // miniPosterView.backgroundColor = .blue
        backDropImageView.contentMode = .scaleAspectFill
        miniPosterView.contentMode = .scaleAspectFill
        miniPosterView.layer.cornerRadius = 12
        miniPosterView.clipsToBounds = true
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepare(backDropImage: nil, miniPoster: nil)
    }
    func prepare(backDropImage: URL?,miniPoster: URL?) {
        self.miniPosterView.isHidden = false
        if let backDrop = backDropImage {
            
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
    
}
