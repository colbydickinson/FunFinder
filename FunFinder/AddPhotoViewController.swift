//
//  AddPhotoViewController.swift
//  FunFinder
//
//  Created by Colby Dickinson on 5/18/19.
//  Copyright © 2019 Colby Dickinson. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
//these delegate functions from Apple that would otherwise take forever for us to figure out how to code
    {

    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionText: UITextField!
    
    override func viewDidLoad() {
    //viewDidLoad is the function that shows up when the app fires for the first time
        super.viewDidLoad()
        imagePicker.delegate = self
    //self refers to the current class we are in
    }
    
    @IBAction func photoLibraryTapped(_ sender: UIButton) {
    //imagePicker is the object I set up in line 15
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
            photoToSave.caption = captionText.text
            
            if let userImage = imageView.image {
                if let userImageData = userImage.pngData() {
                    photoToSave.imageData = userImageData
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            navigationController?.popViewController(animated: true)
            
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("!!!!")
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("???")
            print(selectedImage)
            imageView.image = selectedImage
            
        }
        // update our photo w/selected photo
        
        imagePicker.dismiss(animated: true, completion: nil)
        // go back to our ViewController and present the selected photo for the user to see
    }

}
}
