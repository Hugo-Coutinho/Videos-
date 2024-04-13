//
//  VideosTableViewCell.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-12.
//

import Foundation
import UIKit
import HGUIComponent

class VideosTableViewCell: UITableViewCell {
    
    // MARK: - DEFINING UI ELEMENTS -
    private lazy var videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var uploadedTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    // MARK: - OVERRIDE -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }
    
    // MARK: - SETUP -
    func setup(video: VideoDisplayInfo) {
        videoImageView.loadImage(with: video.thumbnailURL)
        titleLabel.text = video.title
        descriptionLabel.text = video.description
        uploadedTimeLabel.text = video.uploadedTime
    }
}

// MARK: - UI -
extension VideosTableViewCell {
    private func setupComponents() {
        contentView.addSubview(headerView)
        headerView.addSubview(videoImageView)
        headerView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(uploadedTimeLabel)
        activateConstraints()
    }
    
    private func activateConstraints() {
        activateHeaderViewConstraints()
        activateVideoImageViewConstraints()
        activateTitleLabelConstraints()
        activateDescriptionLabelConstraints()
        activateUploadedTimeLabelConstraints()
    }
}

// MARK: - CONSTRAINTS -
extension VideosTableViewCell {
    private func activateHeaderViewConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
    }
    
    private func activateVideoImageViewConstraints() {
        NSLayoutConstraint.activate([
            videoImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            videoImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            videoImageView.heightAnchor.constraint(equalToConstant: 120),
            videoImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func activateTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
    }
    
    private func activateDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    private func activateUploadedTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            uploadedTimeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            uploadedTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            uploadedTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            uploadedTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
