//
//  URL_extension.swift
//  nadumkin@edu.hse.ru PW5
//
//  Created by Никита Думкин on 28.10.2022.
//

import Foundation

extension URLSession{
    func getTopStories(completion: @escaping (Model.News) -> ()){
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0dc15e08500c454f98ae6c6bf9d2bb58") else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let news = try? JSONDecoder().decode(Model.News.self, from: data)
            {
                completion(news)
            }
            else{
                print("Could not get any content")
            }
            
        }
        
        task.resume()
    }
}
