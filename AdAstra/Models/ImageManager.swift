//
//  ImageManager.swift
//  AdAstra
//
//  Created by Francisco Ozuna on 3/30/21.
//

import Foundation

protocol ImageManagerDelegate {
    func didUpdateImage(_ imageManager: ImageManager, image: ImageModel)
    func didFailWithError(error: Error)
}

struct ImageManager {
    var delegate: ImageManagerDelegate?
        
    let baseURL = "https://api.nasa.gov/planetary/apod"
    let apiKey = "DEMO_KEY"
    
    func getPhoto(for date: String) {
        let urlString = "\(baseURL)?api_key=\(apiKey)&date=\(date)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let image = self.parseJSON(safeData) {
                        self.delegate?.didUpdateImage(self, image: image)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> ImageModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ImageData.self, from: data)
            let title = decodedData.title
            let url = decodedData.url
            let description = decodedData.explanation
            
            let photo = ImageModel(photoTitle: title, photoUrl: url, photoDescription: description)
            return photo
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
