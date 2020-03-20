//
//  TTNetworkManager.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import Foundation

struct TTNetworkManager {

    enum FetchError: Error {
        case serverError(Error)
        case malformedURL
        case noResponseData
        case noTempRecordResults
        case decodeFailure
    }

    private static let getTempRecordsURL = "https://s3.amazonaws.com/temp-tracker/temp-records.json"

    static func getTempRecords(completion: @escaping (Result<[TTTempRecord], FetchError>) -> Void) {

        guard let url = URL(string: TTNetworkManager.getTempRecordsURL) else {
            completion(.failure(.malformedURL))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noResponseData))
                return
            }

            completion(TTNetworkManager.decodeData(data: data))
        }.resume()
    }

    static func decodeData(data: Data) -> Result<[TTTempRecord], FetchError> {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(TTTempRecordResult.self, from: data)
            guard !result.tempRecords.isEmpty else {
                return .failure(.noTempRecordResults)
            }
            return .success(result.tempRecords)
        } catch {
            return .failure(.decodeFailure)
        }
    }
}
