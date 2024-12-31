//
//  PersonDetailViewController.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import UIKit

class PersonDetailViewController: UIViewController {
    @IBOutlet var infoLabel1: UILabel!
    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var infoLabel4: UILabel!
    @IBOutlet var infoLabel3: UILabel!
    @IBOutlet var infoLabel2: UILabel!
    
    let viewModel = PersonDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
