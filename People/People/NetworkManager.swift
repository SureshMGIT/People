//
//  NetworkManager.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import Foundation

final class NetworkManager {
    
    func fetchPeople(page: String) async -> Result<PeopleModel, NetworkError> {

        let url = URL(string: "https://api.themoviedb.org/3/person/popular")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: page),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MzYzOTM0ZGM2ZTUwMmIzMDc0NGM2Zjc1OTJkYTYxMiIsIm5iZiI6MTczNTYyNzA3OC40MzEsInN1YiI6IjY3NzM5MTQ2OThmMmY4MmZjNDkyOTI2MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XqznN4VjxzC9tuQq5VXVn4KWUTYMWlivucvzHCj3G48"
        ]

        do {
            let session = URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil)
            let (data, _) = try await session.data(for: request)
            let peopleModel = try JSONDecoder().decode(PeopleModel.self, from: data)
            return .success(peopleModel)
        } catch {
            return .failure(.networkError)
        }
    }
}

class CustomSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let serverTrust = challenge.protectionSpace.serverTrust {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

enum NetworkError: Error {
    case networkError
}
