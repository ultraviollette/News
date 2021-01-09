//
//  NewsDetailController.swift
//  News
//
//  Created by Miel on 2021-01-08.
//

import UIKit

class NewsDetailController : UIViewController {
    
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    
    // 1. image url
    // 2. desc
    
    var imageUrl: String?
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        if let img = imageUrl {
            //
            // Data
            if let data = try? Data(contentsOf: URL(string: img)!) {
                // Main Thread
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }
        }
        
        if let d = desc {
            // Show the contents
            self.LabelMain.text = d
        }
    }
    
}
