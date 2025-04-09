//
//  MangaCollectionViewCell.swift
//  mana
//
//  Created by ios_starter on 4/8/25.
//

import UIKit
import SnapKit

class MangaCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let infoBackgroundView = UIView()
    
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    static let identifier = "MangaCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMangaCollection()
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupMangaCollection() {
        [imageView,infoBackgroundView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        
        [titleLabel, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            infoBackgroundView.addSubview($0)
        }
            
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = (CGColor(red: 1, green: 0.45, blue: 0, alpha: 1.0))
            imageView.contentMode = .scaleAspectFill //이미지 잘리지 않고 크기 유지
            
            infoBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            infoBackgroundView.layer.cornerRadius = 30
            infoBackgroundView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
            
            titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            titleLabel.textColor = UIColor(red: 1, green: 0.45, blue: 0, alpha: 1)
            
            priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            priceLabel.textColor = UIColor(red: 1, green: 0.45, blue: 0, alpha: 1)
        }


   func setupCellLayout() {
       imageView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
       }

       infoBackgroundView.snp.makeConstraints { make in
           make.leading.trailing.bottom.equalTo(imageView)
           make.height.equalTo(55)
       }

       titleLabel.snp.makeConstraints { make in
           make.leading.equalToSuperview().offset(12)
           make.top.equalToSuperview().offset(8)
       }

       priceLabel.snp.makeConstraints { make in
           make.leading.equalTo(titleLabel)
           make.top.equalTo(titleLabel.snp.bottom).offset(4)
       }
   }
   func configure(imageName: String, title: String = "", price: String = "") {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
        priceLabel.text = price
    }
       
            
    }

