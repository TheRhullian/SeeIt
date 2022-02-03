//
//  SeriesSeason.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import Foundation

class SeriesSeason: Codable {
    let id: Int?
    let url: String?
    let number: Int?
    let name: String?
    let episodeOrder: Int?
    let premiereDate, endDate: String?
    let network, webChannel: Network?
    let image: Image?
    let summary: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, webChannel, image, summary
        case links
    }
}

// MARK: - URLSession Task
extension URLSession {
    func seriesSeasonTask(seriesId: Int, completionHandler: @escaping ([SeriesSeason]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let endpoint = URLSession.Endpoints.serieSeason.replacingOccurrences(of: "{info}", with: seriesId.description)
        guard let url = URL(string: URLSession.baseUrl + endpoint) else {
            return nil
        }
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
