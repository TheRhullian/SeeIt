//
//  Show.swift
//  SeeIt
//
//  Created by Rhullian Damião on 01/02/22.
//

import Foundation

// MARK: - Show
class Show: Codable {
    let score: Double?
    let show: ShowDetails?

    init(score: Double?, show: ShowDetails?) {
        self.score = score
        self.show = show
    }
}

// MARK: - ShowClass
class ShowDetails: Codable {
    let id: Int?
    let url: String?
    let name, type, language: String?
    let genres: [String]?
    let status: String?
    let runtime, averageRuntime: Int?
    let premiered, ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network, webChannel: Network?
    let dvdCountry: String?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links
    }
}

// MARK: - Externals
class Externals: Codable {
    let tvrage, thetvdb: Int?
    let imdb: String?

    init(tvrage: Int?, thetvdb: Int?, imdb: String?) {
        self.tvrage = tvrage
        self.thetvdb = thetvdb
        self.imdb = imdb
    }
}

// MARK: - Image
class Image: Codable {
    let medium, original: String?

    init(medium: String?, original: String?) {
        self.medium = medium
        self.original = original
    }
}

// MARK: - Links
class Links: Codable {
    let linksSelf, previousepisode, nextepisode: Nextepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf
        case previousepisode, nextepisode
    }

    init(linksSelf: Nextepisode?, previousepisode: Nextepisode?, nextepisode: Nextepisode?) {
        self.linksSelf = linksSelf
        self.previousepisode = previousepisode
        self.nextepisode = nextepisode
    }
}

// MARK: - Nextepisode
class Nextepisode: Codable {
    let href: String?

    init(href: String?) {
        self.href = href
    }
}

// MARK: - Network
class Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
    let officialSite: String?

    init(id: Int?, name: String?, country: Country?, officialSite: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.officialSite = officialSite
    }
}

// MARK: - Country
class Country: Codable {
    let name, code, timezone: String?

    init(name: String?, code: String?, timezone: String?) {
        self.name = name
        self.code = code
        self.timezone = timezone
    }
}

// MARK: - Rating
class Rating: Codable {
    let average: Double?

    init(average: Double?) {
        self.average = average
    }
}

// MARK: - Schedule
class Schedule: Codable {
    let time: String?
    let days: [String]?

    init(time: String?, days: [String]?) {
        self.time = time
        self.days = days
    }
}

// MARK: - URLSession Task
extension URLSession {
    func showTask(movie: String, completionHandler: @escaping ([Show]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let endpoint = URLSession.Endpoints.searchShows.replacingOccurrences(of: "{info}", with: movie)
        guard let url = URL(string: URLSession.baseUrl + endpoint) else {
            return nil
        }
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}


