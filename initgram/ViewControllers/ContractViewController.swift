//
//  ContractViewController.swift
//  initgram
//
//  Created by Kelvin Lui on 2/21/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class ContractViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var scrollView: UITextView!
    @IBOutlet weak var agreeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Terms and Conditions"
        scrollView.delegate = self
        agreeButton.setTitleColor(UIColor.gray, for: .disabled)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height && agreeButton.state == .disabled) {
                //agreeButton.setTitleColor(UIColor.blue, for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
