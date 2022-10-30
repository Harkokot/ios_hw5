//
//  NewsModel.swift
//  nadumkin@edu.hse.ru PW5
//
//  Created by Никита Думкин on 26.10.2022.
//

import UIKit
final class NewsViewModel {
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, description: String, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
