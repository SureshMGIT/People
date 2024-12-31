//
//  PeopleModel.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import Foundation


// MARK: - Welcome
struct PeopleModel: Codable {
    let page: Int
    let list: [Person]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case list = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Person: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let knownFor: [KnownFor]?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath: String?
    let id: Int?
    let title, originalTitle: String?
    let overview, posterPath: String?
    let mediaType: MediaType?
    let adult: Bool?
    let originalLanguage: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case cn = "cn"
    case en = "en"
    case ja = "ja"
    case ko = "ko"
    case zh = "zh"
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case directing = "Directing"
    case visualEffects = "Visual Effects"
}
