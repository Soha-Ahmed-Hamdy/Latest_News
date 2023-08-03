//
//  DetailsViewController.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    var article : Article?
    
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleTit: UILabel!
    @IBOutlet weak var articleOuther: UILabel!
    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articeImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articeImg.layer.cornerRadius = 20
        
        articleDate.text = "Published at : \((article?.publishedAt)!)"
        articleSource.text = article?.source?.name
        articleContent.text = "\((article?.description)! ), \((article?.content)!)"
        articleTit.text = article?.title
        articleOuther.text = "Auther : \((article?.author) ?? "Not known")"
        articeImg.sd_setImage(with: URL(string: article?.urlToImage ?? ""), placeholderImage: UIImage(named: "1"))

    }
    
    
    @IBAction func gotoWebsite(_ sender: Any) {
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC.link = article?.url
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
