//
//  TTTempRecordTableViewCellViewModel.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import UIKit

struct TTTempRecordTableViewCellViewModel {

    let titleText: String

    init(record: TTTempRecord) {
        self.titleText = record.symptoms.first?.description ?? "No Symptoms"
    }
}
