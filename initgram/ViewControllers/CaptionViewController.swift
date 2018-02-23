//
//  CaptionViewController.swift
//  initgram
//
//  Created by Kelvin Lui on 2/23/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController {

    @IBOutlet weak var captionField: UITextField!
    
    var photoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(_ sender: UIButton) {
        Post.postUserImage(image: photoImage, withCaption: captionField.text ?? "", withCompletion: nil)
        self.dismiss(animated: true, completion: nil)
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
