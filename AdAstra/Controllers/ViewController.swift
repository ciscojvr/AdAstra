//
//  ViewController.swift
//  AdAstra
//
//  Created by Francisco Ozuna on 3/30/21.
//

import UIKit

class ViewController: UIViewController {
    
    var today: String = ""
    var yesterday: String = ""
    
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDescription: UITextView!
    
    var imageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageManager.delegate = self
        
        let todaysDate = Date()
        let yesterdaysDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        today = formatter.string(from: todaysDate)
        yesterday = formatter.string(from: yesterdaysDate)
        
        imageManager.getPhoto(for: today)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Yesterday":
            imageManager.getPhoto(for: yesterday)
        case "Today":
            imageManager.getPhoto(for: today)
        default:
            return
        }
    }
}

extension ViewController: ImageManagerDelegate {
    func didUpdateImage(_ imageManager: ImageManager, image: ImageModel) {
        DispatchQueue.main.async {
            self.imageTitle.text = " \"\(image.photoTitle)\" "
            self.imageView.load(url: URL(string: image.photoUrl)!)
            self.imageDescription.text = image.photoDescription
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

