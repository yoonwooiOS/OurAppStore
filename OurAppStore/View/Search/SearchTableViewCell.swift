//
//  SearchTableViewCell.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/9/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: BaseTableViewCell {
    let baseView = {
        let view = UIView()
//        view.backgroundColor = .systemGreen
        return view
    }()
    let appIconImageView = {
        let view = UIImageView()
//        view.backgroundColor = .systemBlue
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    let appNameLabel = {
        let label = UILabel()
        label.text = "dsadas"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    let downloadButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemGray5
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    
    override func setUpHierarchy() {
        contentView.addSubview(baseView)
        baseView.addSubview(appIconImageView)
        baseView.addSubview(appNameLabel)
        baseView.addSubview(downloadButton)
    }
    override func setUpLayout() {
        baseView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        appIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.size.equalTo(72)
        }
        appNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(appIconImageView.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(100)
        }
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.width.equalTo(80)
        }
    }
     func setUpCell(data: Result) {
         appNameLabel.text = data.trackName
         let url = URL(string: data.artworkUrl512)
         appIconImageView.kf.setImage(with: url)
    }
    
}
