//
//  ViewController.swift
//  News
//
//  Created by Miel on 2021-01-08.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    var newsData : Array<Dictionary<String, Any>>?
    // 1. http - URLSession
    // 2. JSON
    // 3. Matching the Data
    
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=ca&apiKey=25d8d4693de44db9a2e8287ad65309e6")!) { (data, response, error) in
            
            if let dataJson = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    //                    print(json)
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    print(articles)
                    self.newsData = articles
                    
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                }
                catch {}
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many
        if let news = newsData {
            return news.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // What kind of
        // A random cell - just for practice
        //        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        //        cell.textLabel?.text = "\(indexPath.row)"
        
        // Storyboard + id
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
        let idx = indexPath.row
        if let news = newsData {
            let row = news[idx]
            if let r = row as? Dictionary<String, Any> {
                print("TITLE :: \(r)")
                if let title = r["title"] as? String{
                    cell.LabelText.text = title
                }
            }
        }
        
        // as? as!
        
        return cell
    }
    
    // Event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        getNews()
    }
    
    // TableView
    // 1. What kind of data
    // 2. How many
    // 3. Is there any trigger
    
}

