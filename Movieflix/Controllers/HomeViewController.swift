//
//  HomeViewController.swift
//  Movieflix
//
//  Created by Macbook Pro on 10.02.2023.
//

import UIKit


enum Sections: Int {
    case TrendingMovies = 0
    case Popular = 1
    case TrendingTv = 2
    case UpcomingMovies = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles : [String] = ["Trending Movies", "Popular", "Trending TV", "Upcoming Movies", "Top Rated"]
    
    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeFeedTable)

        view.backgroundColor = .systemBackground

        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        
    }
    
    private func configureNavBar() {
            /// left bar button
            /// tutorial'da direkt image'i bar button'a atıyor ama o şekil yapınca
            /// sola değil de ortaya koyuyor ikonu. onun için uiview ekleyip onun içine imageView koyuyoruz
            let containerView = UIControl(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
            let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
            
            imageView.image = UIImage(named: "MovieFlixIcon")?.withRenderingMode(.alwaysOriginal)
            containerView.addSubview(imageView)
            
            let logoBarButtonItem = UIBarButtonItem(customView: containerView)
            navigationItem.leftBarButtonItem = logoBarButtonItem
            
            /// right bar buttons
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
                UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
            ]
            
            navigationController?.navigationBar.tintColor = .white
        }
    
    ///Layout metodları, UIViewController içerisinde IBOutlet objelerinin sınırları, konumları ve boyutları dikkate alınarak yapılacak bütün aksiyonlar için kullanılabilir.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    ///Bu method cell'leri 1'er 1'er gruplandırmaya yarıyor.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    ///Bu method tabloda kaç cell olacağını ifade eder.
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    ///Sections başlıklarını sırayla yazdırmamızı sağlayan fonksiyon
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    ///Sectionların başlıkları ile ilgili ayarlamaları sağlayan fonksiyon
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        ///Alttaki yorum satırı section isimlerinin baş harflerini büyük yapmaya geri kalanını küçük yapmaya yarar. Extensionstan gelir.
        //        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
    
    ///Scroll ettiğinde nav bar'ın görünürlüğünü kaldırıyor.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvData { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularData { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.UpcomingMovies.rawValue:
            APICaller.shared.getUpcomingData { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getRatedData { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
      
        default:
            return UITableViewCell()
        }
        return cell
    }
}
