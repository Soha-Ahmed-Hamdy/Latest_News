//
//  HomeTableViewCell.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 30/07/2023.
//

import UIKit

protocol MyCustomCellDelegate: AnyObject{
    func showAlert(title : String , message: String, confirmAction: UIAlertAction)
    func showToast(message: String)
    func renderView()
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var favButton: UIButton!
    weak var delegate : MyCustomCellDelegate?
    
    var viewModel : FavouriteViewModelProtocol?
    var article : Article?
    
    func initViewModel(article : Article){
        viewModel = FavouriteViewModel()
        self.article = article
        if (viewModel?.checkIfFavourite(title: article.title ?? "")) == true {
            favButton.tintColor = UIColor(.red)
        }else{
            favButton.tintColor = UIColor(.gray)
        }
        articleImage.sd_setImage(with: URL(string: article.urlToImage ?? ""), placeholderImage: UIImage(named: "1"))
        articleTitle.text = article.title
        articleDescription.text = article.description
        articleSource.text = article.source?.name
        articleDate.text = article.publishedAt
        //cell design
        articleImage.layer.cornerRadius = 20
    }
    
    @IBAction func addToFavourite(_ sender: Any) {
        
        if (viewModel?.checkIfFavourite(title: article?.title ?? "")) == true {
            let confirmAction = UIAlertAction(title: "Delete", style: .default){ action  in
                self.viewModel?.deleteFavArticle(article: Mapper.MapArticleToFav(article: self.article!))
                self.favButton.tintColor = UIColor(.gray)
                self.delegate?.renderView()
            }
            self.delegate?.showAlert(title: "Delete from favourite!", message: "This item in favourite, Do you want to delete?", confirmAction: confirmAction)
        }else{
            viewModel?.saveFavArticle(article: Mapper.MapArticleToFav(article: self.article!))
            favButton.tintColor = UIColor(.red)
            self.delegate?.showToast(message: "Added to Favourites Successfully")
        }
    }
    
}
