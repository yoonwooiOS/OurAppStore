//
//  SearchDetailView.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/10/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class SearchDetailView: BaseViewController {
    let baseView = {
        let view = UIView()
//        view.backgroundColor = .systemGreen
        return view
    }()
    let appIconImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    let appNameLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        return label
    }()
    let appCoperationNameLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray3
        return label
    }()
    let downloadButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    var value: Result?
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func setUpHierarchy() {
        view.addSubview(baseView)
        baseView.addSubview(appIconImageView)
        baseView.addSubview(appNameLabel)
        baseView.addSubview(appCoperationNameLabel)
        baseView.addSubview(downloadButton)
    }
    override func setUpLayout() {
        baseView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(120)
        }
        appIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.size.equalTo(100)
        }
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(8)
        }
        appCoperationNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(12)
            
        }
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(appCoperationNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(12)
            make.width.equalTo(80)
        }
    }
    override func setUpView() {
        guard let data = value else { return }
        appNameLabel.text = data.trackName
        let url = URL(string: data.artworkUrl512)
        appIconImageView.kf.setImage(with: url)
        appCoperationNameLabel.text = data.artistName
    }
}
