//
//  SeasonEpisode.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import Foundation

class SeasonEpisode: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let season, number: Int?
    let type, airdate, airtime: String?
    let airstamp: Date?
    let runtime: Int?
    let rating: Rating?
    let image: Image?
    let summary: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
        case links
    }
    
}

// MARK: - URLSession Task
extension URLSession {
    func seasonEpisodeTask(season: Int, completionHandler: @escaping ([SeasonEpisode]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let endpoint = URLSession.Endpoints.seasonEpisodes.replacingOccurrences(of: "{info}", with: season.description)
        guard let url = URL(string: URLSession.baseUrl + endpoint) else {
            return nil
        }
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
