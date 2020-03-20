//
//  TTTempRecordTableViewCell.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

class TTTempRecordTableViewCell: UITableViewCell {

    // MARK: - Public Props

    var viewModel: TTTempRecordTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.titleText
//            detailLabel.text = viewModel.details
//            emailLabel.text = viewModel.email
//            phoneLabel.text = viewModel.phone
        }
    }

    // MARK: - Private Props

    // MARK: - Lazy Loaded Props

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: Constants.Font.title)
        label.numberOfLines = 1
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: Constants.Font.body)
        label.numberOfLines = 0
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.Font.body)
        label.numberOfLines = 1
        return label
    }()

    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.Font.body)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - View Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupAppearance()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        titleLabel.text = ""
        detailLabel.text = ""
        emailLabel.text = ""
        phoneLabel.text = ""
    }

    // MARK: - Setup Appearance

    private func setupAppearance() {

        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(phoneLabel)
    }

    private func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Constants.Margins.medium)
            make.height.equalTo(Constants.Label.largeHeight)
            make.trailing.equalToSuperview().offset(-Constants.Margins.medium)
        }

        detailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Margins.small)
            make.bottom.equalTo(emailLabel.snp.top).offset(-Constants.Margins.small)
        }

        emailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(Constants.Margins.small)
            make.height.equalTo(Constants.Label.medHeight)
            make.bottom.equalTo(phoneLabel.snp.top).offset(-Constants.Margins.small)
        }

        phoneLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(emailLabel.snp.bottom).offset(Constants.Margins.small)
            make.height.equalTo(Constants.Margins.medium)
            make.bottom.equalToSuperview().offset(-Constants.Margins.medium)
        }
    }
}
