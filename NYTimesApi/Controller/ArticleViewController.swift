//
//  ViewController.swift
//  NYTimesApi
//
//  Created by Deák Dávid on 2019. 09. 29..
//  Copyright © 2019. Deák Dávid. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON

class ArticleViewController: UITableViewController {

    var listOfArticles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllArticles()
    }
    
    func getAllArticles(){
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json")!
        Alamofire.request(url, method: .get, parameters: ["api-key": "o7sksrGPWxvuRIi8ISHbEmBKi7srjI6u"]).responseSwiftyJSON { dataResponse in
            if let items = dataResponse.value?["results"].array {
                for item in items {
                    guard let url = item["url"].string else{print("No URL"); return}
                    guard let byline = item["byline"].string else{print("No Byline"); return}
                    guard let title = item["title"].string else{print("No Title"); return}
                    guard let published_date = item["published_date"].string else{print("No Published_Date"); return}
                    var photo_url = ""
                    var format = ""
                    if let medias = item["media"][0]["media-metadata"].array{
                        for media in medias {
                            photo_url = media["url"].string!
                            format = media["format"].string!
                        }
                    }
                    let id = "0"
                    if item["media"].array != nil {
                
                    }
                    self.listOfArticles.append(Article(id: id, title: title, url: url, byline: byline, photo_url: photo_url, photo_format: format, published_date: published_date))
                }
            }
            self.tableView.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
      cell.setup(model: listOfArticles[indexPath.row])
      return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.article = listOfArticles[tableView.indexPathForSelectedRow!.row]
            }
        }
    }

}

