//
//  DetailViewController.swift
//  NYTimesApi
//
//  Created by Deák Dávid on 2019. 10. 01..
//  Copyright © 2019. Deák Dávid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var article : Article?
    
    @IBOutlet weak var detailArticleImage: RoundableUIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailByLine: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailDate.text = article?.published_date
        detailByLine.text = article?.byline
        detailTitle.text = article?.title
        downloadImage(from: URL(string: article!.photo_url)!)
    }
    

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.detailArticleImage.image = UIImage(data: data)
            }
        }
    }
    @IBAction func openURI(_ sender: UIButton) {
        UIApplication.shared.open(URL(string : article!.url)!)
    }
    
}
