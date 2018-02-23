//
//  DashboardViewController.swift
//  initgram
//
//  Created by Kelvin Lui on 2/21/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import Parse

class DashboardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var photoPickerViewController: UIImagePickerController!
    var posts: [Post]!
    var newImage: UIImage!
    var selectedRowCaption: String!
    var selectedRowAuthor: String!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        photoPickerViewController = UIImagePickerController()
        photoPickerViewController.delegate = self
        photoPickerViewController.allowsEditing = true
        
        tableView.rowHeight = 400
        tableView.dataSource = self
        tableView.delegate = self
        tableView.insertSubview(refreshControl, at: 0)
        
        let query = Post.query()!
        query.order(byDescending: "_created_at")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts as! [Post]? {
                // Do soemthing with posts
                self.posts = posts
                self.tableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        let query = Post.query()!
        query.order(byDescending: "_created_at")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts as! [Post]? {
                // Do soemthing with posts
                self.posts = posts
                self.tableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "instagramPostTableViewCell", for: indexPath) as! InstagramPostTableViewCell
        
        if let posts = posts {
            cell.instagramPost = posts[indexPath.row]
        }
        
        return cell
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancecl picking media.")
        
        self.photoPickerViewController.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let posts = posts {
            if posts[indexPath.row].author.username != nil {
                self.selectedRowAuthor = posts[indexPath.row].author.username
            }

            self.selectedRowCaption = posts[indexPath.row].caption
            
            performSegue(withIdentifier: "detailSegue", sender: nil)
        } else {
            self.selectedRowCaption = ""
            self.selectedRowAuthor = ""
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Finish picking media.")
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage!
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        self.newImage = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        self.photoPickerViewController.dismiss(animated: true, completion: nil)
        
        self.performSegue(withIdentifier: "captionSegue", sender: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func onLibrary(_ sender: UIButton) {
        photoPickerViewController.sourceType = .photoLibrary
        self.present(photoPickerViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func onCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            photoPickerViewController.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            photoPickerViewController.sourceType = .photoLibrary
        }
        self.present(photoPickerViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "captionSegue" {
            let vc = segue.destination as! CaptionViewController
            vc.photoImage = self.newImage
        } else if segue.identifier == "detailSegue" {
            let vc = segue.destination as! DetailViewController
            
            vc.author = self.selectedRowAuthor
            vc.caption = self.selectedRowCaption
        }
    }
}
