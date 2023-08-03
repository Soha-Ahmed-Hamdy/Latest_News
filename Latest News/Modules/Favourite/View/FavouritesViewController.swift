//
//  FavouritesViewController.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import UIKit
import Lottie
import SwiftUI

class FavouritesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var noData: LottieAnimationView!
    var favViewModel : FavouriteViewModelProtocol?
    var favArticleList : [FavouriteModel]?
    var searchArticles : [FavouriteModel]?
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourites"
        renderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        renderView()
    }
    
    func renderView(){
        searching = false
        searchBar.text = ""
        favViewModel = FavouriteViewModel()
        favViewModel?.getAllFavArticles()
        self.favArticleList = self.favViewModel?.VMFavouriteResult
        favTableView.reloadData()
        self.checkListCount(articles: self.favArticleList ?? [])
    }
    
    func checkListCount(articles: [FavouriteModel]){
        if articles.count == 0 {
            favTableView.isHidden = true
            noData.isHidden = false
            noData.contentMode = .scaleAspectFit
            noData.loopMode = .loop
            noData.play()
        }else{
            favTableView.isHidden = false
            noData.isHidden = true
            self.favTableView.reloadData()
        }
    }
  
}

extension FavouritesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchArticles?.count ?? 0
        }else{
            return favArticleList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        var articles : [FavouriteModel] = []
        if searching{
            articles = searchArticles ?? []
            
        }else{
            articles = favArticleList ?? []
        }
        
        cell.initViewModel(article: Mapper.MapFavToArticle(favouriteItem: articles[indexPath.row]))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let confirmAction = UIAlertAction(title: "Delete", style: .default){ action  in
            if self.searching{
                self.favViewModel?.deleteFavArticle(article: (self.searchArticles?[indexPath.row])!)
            }else{
                self.favViewModel?.deleteFavArticle(article: (self.favArticleList?[indexPath.row])!)
            }
            self.renderView()
        }
        Utilites.displayAlert(title: "Delete from favourite!", message: "This item in favourite, Do you want to delete?", action: confirmAction, controller: self)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        var article : Article?
        if searching{
            article = Mapper.MapFavToArticle(favouriteItem: (searchArticles?[indexPath.row]) ?? FavouriteModel())
        }else{
            article = Mapper.MapFavToArticle(favouriteItem: (favArticleList?[indexPath.row]) ?? FavouriteModel())
        }
        detailsVC.article = article
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension FavouritesViewController : MyCustomCellDelegate{
    func showAlert(title: String, message: String, confirmAction: UIAlertAction) {
        Utilites.displayAlert(title: title, message: message, action: confirmAction, controller: self)
    }
    
    func showToast(message: String) {
        Utilites.displayToast(message: message, seconds: 1, controller: self)
    }
}

extension FavouritesViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArticles = (favArticleList?.filter( {($0.title.lowercased().prefix(searchText.count)) == searchText.lowercased() } ))
        searching = true
        self.checkListCount(articles: searchArticles ?? [])
        favTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.checkListCount(articles: searchArticles ?? [])
        favTableView.reloadData()
    }
}
