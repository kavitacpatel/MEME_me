//
//  ViewController.swift
//  
//
//  Created by kavita patel on 4/9/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    let imgpicker = UIImagePickerController()
    var memes = [MeMe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEnable(false)
        
       
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        addObserver()
    }
    func addObserver()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func cancelBtn(sender: AnyObject) {
        clearFields()
       textFieldEnable(false)
        
        
    }
    @IBAction func imagePicker(sender: AnyObject) {
        imgpicker.sourceType = .PhotoLibrary
        imagePicker()
    }
    
    @IBAction func cameraPicker(sender: AnyObject) {
        if(UIImagePickerController.isSourceTypeAvailable(.Camera))
        {
          imgpicker.sourceType = .Camera
            imagePicker()
        }
        else
        {
            showAlert("Error", message: "Device does not support Camera")
        }
    }
    
    @IBAction func actionBtn(sender: AnyObject) {
        saveImg()
    }
    
    func showAlert(title: String, message: String)
    {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
         alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
         self.presentViewController(alert, animated: true, completion: nil)
        

    }
    
    func imagePicker()
    {
        clearFields()
        imgpicker.allowsEditing = false
        imgpicker.delegate = self
        self.presentViewController(imgpicker, animated: true, completion: nil)
        textFieldEnable(true)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = img
        }
    }
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    func keyboardWillShow(notification: NSNotification) {
       if bottomText.editing
       {
        self.view.frame.origin.y = -180
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
       if bottomText.editing
       {
        self.view.frame.origin.y = 0
        }
    }
    func textFieldEnable(value: Bool)
    {
        topText.enabled = value
        bottomText.enabled = value
        shareBtn.enabled = value
    }
    func barToolHidden(value: Bool)
    {
        navigationBar.hidden = value
        toolBar.hidden = value
    }
   func clearFields()
   {
    topText.text = ""
    bottomText.text = ""
    imageView.image = nil
    }
    func saveImg()
    {
        
        let img = generateImage()
        
        let messageStr:String  = "Check out my awesome photo!"
        
        let shareItems:Array = [img, messageStr]
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
        self.presentViewController(activityViewController, animated: true, completion: nil)
        let memeObj = MeMe(toptext: topText.text!, bottomtext: bottomText.text!, image: img)
        memes.append(memeObj)
        
       
    }
    
    func generateImage() -> UIImage
    {
        barToolHidden(true)
       
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        barToolHidden(false)
        return memedImg
    }
}
