//
//  ArticleTableViewCell.swift
//  NYTimesApi
//
//  Created by Deák Dávid on 2019. 09. 29..
//  Copyright © 2019. Deák Dávid. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: RoundableUIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var byline: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(model : Article) {
        title.text = model.title
        byline.text = model.byline
        date.text = model.published_date
        downloadImage(from: URL(string: model.photo_url)!)
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
                self.articleImage.image = UIImage(data: data)
            }
        }
    }
}
