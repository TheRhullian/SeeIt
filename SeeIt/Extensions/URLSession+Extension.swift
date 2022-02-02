//
//  URLSession+Extension.swift
//  SeeIt
//
//  Created by Rhullian Damião on 01/02/22.
//

import Foundation

extension URLSession {
    
    static var baseUrl = "https://api.tvmaze.com/"
    
    enum Endpoints {
        static let searchShows = "search/shows?q={info}"
    }
    
    // MARK: - URL SESSION CODABLE TASK
    func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        print("[ENDPOINT]: \(url.absoluteString)")
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print("[RESULT]: \( json ?? "NO RESULT")")
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
}

// MARK: - Helper functions for creating encoders and decoders
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
