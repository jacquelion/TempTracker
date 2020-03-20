//
//  TTHistoryErrorView.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

protocol TTHistoryErrorViewProtocol: AnyObject {
    func errorViewButtonTapped()
}

class TTHistoryErrorView: UIView {

    // MARK: - Public Props

    var viewModel: TTHistoryErrorViewViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.title
            subtitleLabel.text = viewModel.subtitle
            actionButton.setTitle(viewModel.button, for: .normal)
        }
    }

    // MARK: - Private Props

    private weak var delegate: TTHistoryErrorViewProtocol?

    // MARK: Lazy Loaded Props

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Constants.Font.header)
        label.numberOfLines = 1
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.Font.title, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.layer.cornerRadius = Constants.Label.largeHeight/2
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: View Lifecycle

    init(delegate: TTHistoryErrorViewProtocol) {
        self.delegate = delegate
        super.init(frame: .zero)

        setupAppearance()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Appearance

    private func setupAppearance() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(actionButton)
        backgroundColor = .white
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Constants.Margins.medium)
            make.trailing.equalToSuperview().offset(-Constants.Margins.medium)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-Constants.Margins.medium)
            make.height.equalTo(Constants.Label.largeHeight)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Margins.medium)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(actionButton.snp.top).offset(-Constants.Margins.medium)
            make.height.equalTo(Constants.Label.xLargeHeight)
        }

        actionButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Margins.medium)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview()
            make.height.equalTo(Constants.Label.largeHeight)
        }
    }

    // MARK: - Actions

    @objc private func retryButtonTapped() {
        self.actionButton.isEnabled = false
        self.delegate?.errorViewButtonTapped()
    }
}
