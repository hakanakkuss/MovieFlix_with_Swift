//
//  ViewController.swift
//  Movieflix
//
//  Created by Macbook Pro on 10.02.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TabBar elemanlarını (sayfaları) oluşturduk.
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        tabBar.tintColor = .label
        
        //TabBar elemanlarını (sayfalarını) initialize ettik.
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
        
        //TabBar elemanlarına icon atadık
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        //TabBar elemanlarına başlık verdik
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Downloads"

    }
}

