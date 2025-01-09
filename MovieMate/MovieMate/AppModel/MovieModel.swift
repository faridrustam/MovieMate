//
//  MovieModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.

import Foundation

struct CategoryModel: Codable {
    let id: String?
    let categoryName: String?
}

struct MovieModel: Codable {
    let category: String?
    let movieName: String?
    let backgroundImage: String?
    let posterImage: String?
    let rating: Double?
    let releaseDate: String?
    let time: String?
    let aboutMovie: String?
    let trailer: String?
}
