//
//  CancellationSuccessViewController.swift
//  assignment3
//
//  Created by Sienna Lau on 21/5/2022.
//

import UIKit

class CancellationSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    @IBAction func goToHomePage(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
