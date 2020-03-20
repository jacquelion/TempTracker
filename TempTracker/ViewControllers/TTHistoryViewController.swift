//
//  TTHistoryViewController.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

class TTHistoryViewController: UIViewController {

    // MARK: - Private props

    private var tempRecords: [TTTempRecord] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }

    private let historyTableViewCellReuseIdentifier = "TTHistoryTableViewCellReuseIdentifier"

    private var loading: Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.updateLoadingState()
            }
        }
    }

    // MARK: - Lazy Loaded Props

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width/2 - 15), y: (UIScreen.main.bounds.width/2 - 15), width: 30.0, height: 30.0))
        view.hidesWhenStopped = true
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TTTempRecordTableViewCell.self, forCellReuseIdentifier: historyTableViewCellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

//    let errorView: TTHistoryErrorView = TTHistoryErrorView(delegate: self)
//

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        setupConstraints()
        fetchData()
    }

    // MARK: Setup Appearance

    private func setupAppearance() {
        view.addSubview(loadingIndicator)
        view.addSubview(tableView)
        view.backgroundColor = .white
    }

    private func setupConstraints() {
        loadingIndicator.center = view.center
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Fetch Data

    private func fetchData() {
        loading = true
        TTNetworkManager.getTempRecords { [weak self] result in
            self?.loading = false
            switch result {
                case .success(let results):
                    self?.tempRecords = results
                case .failure(let error):
                    print(error.localizedDescription)
//                    let viewModel = TTHistoryErrorViewViewModel(error: error)
//                    self?.errorView.viewModel = viewModel
//                    self?.showErrorView()
                }
        }
    }

    // MARK: - Update Appearance

    private func updateLoadingState() {
        loading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        tableView.isHidden = loading
    }

//    private func showErrorView() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else {
//                return
//            }
//            if self.view.subviews.contains(self.errorView) {
//                self.errorView.isHidden = false
//            } else {
//                self.view.addSubview(self.errorView)
//                self.errorView.snp.makeConstraints { make in
//                    make.centerX.centerY.equalToSuperview()
//                    make.edges.equalToSuperview()
//                }
//            }
//        }
//    }
}

// MARK: - TableView Delegate & Data Source

extension TTHistoryViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("Historical Data", comment: "Title of Historical Data")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempRecords.count
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: historyTableViewCellReuseIdentifier, for: indexPath) as? TTTempRecordTableViewCell else {
            return UITableViewCell()
        }
        let record = tempRecords[indexPath.row]
        cell.viewModel = TTTempRecordTableViewCellViewModel(record: record)
        return cell
    }
}

extension TTHistoryViewController: TTHistoryErrorViewProtocol {
     func errorViewButtonTapped() {
//            errorView.isHidden = true
            fetchData()
        }
}
