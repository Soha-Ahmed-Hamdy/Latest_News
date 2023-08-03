//
//  HomeViewController.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 30/07/2023.
//

import UIKit
import SDWebImage
import Lottie

class HomeViewController: UIViewController{
    var remoteDataSource: RemoteDataSourceProtocol?
    var homeViewModel : HomeViewModel?
    var articlesList : [Article]?
    var searchArticles : [Article]?
    var searching = false
    var defaults : UserDefaults?
    
    @IBOutlet weak var noData: LottieAnimationView!
    @IBOutlet weak var darkModeButton: UIBarButtonItem!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        renderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lastest News"
        defaults = UserDefaults.standard
        setUpBrightness()
        remoteDataSource = RemoteDataSource()
        homeViewModel = HomeViewModel(remote: remoteDataSource ?? RemoteDataSource())
        homeViewModel?.getAllNews()
        homeViewModel?.getLocalNews()
    }
    
    func renderView(){
        let refreshControl = UIRefreshControl()
        if Utilites.isConnectedToNetwork(){
            homeViewModel?.bindNewsResultToViewController = {() in self.renderViewWhenNetConnection()}
            refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
            newsTableView.refreshControl = refreshControl
        }else{
            getLocalData()
        }
    }
    
    func renderViewWhenNetConnection(){
        DispatchQueue.main.async {
            self.articlesList = self.homeViewModel?.VMResult?.articles
            self.newsTableView.reloadData()
            let localNews = LocalNewsModel(status: self.homeViewModel?.VMResult?.status ?? "" , totalResults: self.homeViewModel?.VMResult?.totalResults ?? 0, articlesList: Mapper.articleListToLocalArticleList(articlesList: self.articlesList ?? []))
            self.homeViewModel?.deleteLocalNews()
            self.homeViewModel?.saveLocalNews(news: localNews)
        }
    }
    
    func setUpBrightness(){
        
        if let style = defaults?.string(forKey: "brightnessMode"){
            if style == "dark"{
                UserInterfaceStyleManager.shared.setUserInterfaceStyle(.dark)
                darkModeButton.image = UIImage(systemName: "sun.min.fill")
            }else{
                UserInterfaceStyleManager.shared.setUserInterfaceStyle(.light)
                darkModeButton.image = UIImage(systemName: "moonphase.waning.crescent")
            }
        }
    }
    
    func checkListCount(articles: [Article]){
        if articles.count == 0 {
            newsTableView.isHidden = true
            noData.isHidden = false
            noData.contentMode = .scaleAspectFit
            noData.loopMode = .loop
            noData.play()
        }else{
            newsTableView.isHidden = false
            noData.isHidden = true
            self.newsTableView.reloadData()
        }
    }
    
    func getLocalData(){
        articlesList = []
        let localArticle = homeViewModel?.VMLocalNewsResult
        localArticle?.articles.forEach({ article in
            let articleModel = Article(source: Source(name: article.source), author: article.author, title: article.title, description: article.descrip, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
            articlesList?.append(articleModel)
        })
        newsTableView.reloadData()
    }
        
    @IBAction func switchBrightnessMode(_ sender: Any) {
        if Utilites.isLight() ?? true{
                UserInterfaceStyleManager.shared.setUserInterfaceStyle(.dark)
                defaults?.set("dark", forKey: "brightnessMode")
                darkModeButton.image = UIImage(systemName: "sun.min.fill")
        }else{
            UserInterfaceStyleManager.shared.setUserInterfaceStyle(.light)
            defaults?.set("light", forKey: "brightnessMode")
            darkModeButton.image = UIImage(systemName: "moonphase.waning.crescent")
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchArticles?.count ?? 0
        }else{
            return articlesList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell

        var articles : [Article] = []
        if searching{
            articles = searchArticles ?? []
        }else{
            articles = articlesList ?? []
        }
        cell.initViewModel(article: articles[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        if searching{
            detailsVC.article = searchArticles?[indexPath.row]
        }else{
            detailsVC.article = articlesList?[indexPath.row]
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension HomeViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArticles = (articlesList?.filter( {($0.title?.lowercased().prefix(searchText.count))! == searchText.lowercased() } ))
        searching = true
        self.checkListCount(articles: searchArticles ?? [])
        newsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.checkListCount(articles: searchArticles ?? [])
        newsTableView.reloadData()
    }
}

extension HomeViewController {
    @objc private func refreshData(_ sender: Any) {
        homeViewModel?.getAllNews()
        homeViewModel?.bindNewsResultToViewController = {
            DispatchQueue.main.async {
                self.articlesList = self.homeViewModel?.VMResult?.articles
                self.newsTableView.reloadData()
                self.newsTableView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension HomeViewController : MyCustomCellDelegate{
    
    func showAlert(title: String, message: String, confirmAction: UIAlertAction) {
        Utilites.displayAlert(title: title, message: message, action: confirmAction, controller: self)
    }
    
    func showToast(message: String) {
        Utilites.displayToast(message: message, seconds: 1, controller: self)
    }
}
