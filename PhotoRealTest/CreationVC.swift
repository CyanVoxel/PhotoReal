//
//  CreationVC.swift
//  PhotoReal
//
//  Created by Anthony Ronca on 4/4/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import Photos

class CreationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //  VARIABLES USED:
    
    let imagePickerController = UIImagePickerController()
    var passedImage: UIImage!
    var selectedIndex = "none"
    
//    OUTLETS
    
    @IBOutlet var AnchorImage: UIImageView! //  Middle image AKA Anchor for AR scene
    @IBOutlet var A_Image: UIImageView!  //  image at [0,0]
    @IBOutlet var B_Image: UIImageView!  //  image at [0,1]
    @IBOutlet var C_Image: UIImageView!  //  image at [0,2]
    @IBOutlet var D_Image: UIImageView!  //  image at [2,2]
    @IBOutlet var E_Image: UIImageView!  //  image at [3,2]
    @IBOutlet var F_Image: UIImageView!  //  image at [3,1]
    @IBOutlet var G_Image: UIImageView!  //  image at [3,0]
    @IBOutlet var H_Image: UIImageView!  //  image at [2,0]
    
    
//    ACTIONS
    
    @IBAction func onSubmit(_ sender: Any) {
        
        // initialization of new table "collage"
         let collage = PFObject(className: "collage")
        
        //  store image into a PFFile
        let anchor = AnchorImage.image!.pngData()
        let file = PFFileObject(data: anchor!)
        
        //  store image into a PFFile
        let A = A_Image.image!.pngData()
        let A_file = PFFileObject(data: A!)
        
        //  add that PFFile to parse under column Anchor
          collage["AnchorImage"] = file
          collage["A_Index"] = A_file
        
       // save results to Parse
        collage.saveInBackground{ (success, error) in
            if success {
                print ("Saved Successfully.")
              self.dismiss(animated: true, completion: nil)
                
            } else {
                print("Image not saved.")
                print(error as Any)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //  set destination View Controller
        let destinationVC = segue.destination as! ViewController
        destinationVC.passedImage = sender as? UIImage
    }
    
    
    
    @IBAction func onAnchorImage(_ sender: Any) {
        
        //  Change index for appropriate case
        selectedIndex = "Anchor"
        
        //  Allow user to select or take a picture
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
            
        }else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    
   @objc internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let image = info[.editedImage] as! UIImage
    let size = CGSize(width: 300, height: 300)
    let scaledImage = image.af_imageAspectScaled(toFill: size)
    
    
    //  Case is selected based on which imageView is selected
    
    switch(selectedIndex) {
        
    case "Anchor"  :
        print("Anchor case entered")
        self.AnchorImage.image = scaledImage
        
        break;
        
    case "A_Index"  :
        print("A_Index case entered")
        A_Image.image = image;
        
        break;

    default :
        print("error - default")
    }
    
        dismiss(animated: true, completion: nil)
    
    }
    
    
    //  When Image at Index A is selected:
    
    @IBAction func onImageA(_ sender: Any) {
        
        //  Change index for appropriate case
        selectedIndex = "A_Index"
        
        //  Allow user to select or take a picture
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
            
        }else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath: IndexPath ){
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
 
    }
}