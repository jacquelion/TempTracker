//
//  TTHistoryErrorViewViewModel.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import UIKit

struct TTHistoryErrorViewViewModel {

    let title: String
    let subtitle: String
    let button: String

    init(error: TTNetworkManager.FetchError) {
        switch error {
        case .noTempRecordResults:
            self.title = NSLocalizedString("No History Found", comment: "Title for data fetch returning no historical data.")
            self.subtitle = NSLocalizedString("No historical data was found. Please enter a temperature record.", comment: "Description for data fetch returning no history.")
            self.button = NSLocalizedString("Retry", comment: "Call to action to retry historical data fetch.")
        default:
            self.title = NSLocalizedString("Data Fetch Error", comment: "Title for generic historical data fetch error.")
            self.subtitle = NSLocalizedString("An error occurred when fetching your data. Please try again later.", comment: "Description for generic historical data fetch error")
            self.button = NSLocalizedString("Retry", comment: "Call to action to retry historical data fetch.")
        }
    }
}
