//
//  ViewController.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 09.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var didShowCatalog = false

       override func viewDidAppear(_ animated: Bool) {
           print("main viewDidAppear")
           super.viewDidAppear(animated)
           
           // Проверяем, чтобы переход был выполнен только один раз
           if !didShowCatalog {
               didShowCatalog = true
               print("UserBuilder")
               let controller = UserBuilder().build()
               if navigationController==nil{
                   print("null")
               }
               navigationController?.pushViewController(controller, animated: true)
           }
       }

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
//        let controller = UserBuilder().build()
//        navigationController?.pushViewController(controller, animated: true)
        // Do any additional setup after loading the view.
        //let controller = UserBuilder().build()
        //navigationController?.pushViewController(controller, animated: true)
    }

}

