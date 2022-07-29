//
//  ViewController.swift
//  FiveStarShop
//
//  Created by Psycho on 27.07.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeLable: UILabel!
    
    var user = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLable.text = "Welcome \(user)!"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
