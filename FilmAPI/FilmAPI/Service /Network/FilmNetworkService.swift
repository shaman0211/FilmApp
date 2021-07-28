//
//  FilmNetworkService.swift
//  FilmAPI
//
//  Created by Artem  on 06.06.2021.
//

import UIKit


final class FilmNetworkService  {
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let apiKey = "1a424b676a5fe546fc60b68ca9928d12"
        

}

extension FilmNetworkService: FilmNetworkServiceProtocol {
   // typealias GetFilmAPIResponse = Result<GetFilmResponse, NetworkServiceError>
    private func genericFetch<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return completion(.failure(NetworkServiceError.networkError))
            }
            if let data = data {
                do {
                    let objects = try self.decoder.decode(T.self, from: data)
                    completion(.success(objects))
                } catch {
                    completion(.failure(NetworkServiceError.networkError))
                }
            }
        }.resume()
        
    }
    
    
    func getFilm(completion: @escaping (GetFilmAPIResponse) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        genericFetch(urlString: urlString, completion: completion)
    }
    
    func getImage(path: String, completion: @escaping (Data) -> Void) {
        let urlString = "https://image.tmdb.org/t/p/w154" + path
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }

            if let data = data {
                completion(data)
            }
        }.resume()
        //genericFetch(urlString: urlString, completion: completion)
    }
    
    func searchFilm(query: String, completion: @escaping (GetFilmAPIResponse) -> Void) {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)"
        genericFetch(urlString: urlString, completion: completion)
    }

}

