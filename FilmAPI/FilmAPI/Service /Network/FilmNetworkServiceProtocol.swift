//
//  FilmNetworkServiceProtocol.swift
//  FilmAPI
//
//  Created by Artem  on 06.06.2021.
//

import Foundation

typealias GetFilmAPIResponse = Result<GetFilmResponse, NetworkServiceError>

protocol FilmNetworkServiceProtocol {
    func getFilm(completion: @escaping (GetFilmAPIResponse) -> Void)
    func getImage(path: String, completion: @escaping (Data) -> Void)
    func searchFilm(query: String, completion: @escaping (GetFilmAPIResponse) -> Void)
}
