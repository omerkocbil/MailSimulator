//
//  ViewController.swift
//  MailSimulator
//
//  Created by Ömer Koçbil on 22.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    @IBOutlet weak var textSubject: UITextField!

    @IBOutlet weak var textMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clickSend(_ sender: Any) {
        //let imageName = "image\(selectedQuoteIndex+1).png"
        showMailComposerWith(/*imageName*/)
    }
    
    func showMailComposerWith(/*_ attachmentName: String*/)
    {
        if MFMailComposeViewController.canSendMail() {
            let subject = textSubject.text
            let messageBody = textMessage.text
            let toRecipients = [textTo.text!]
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setSubject(subject!)
            mailComposer.setMessageBody(messageBody!, isHTML: false)
            mailComposer.setToRecipients(toRecipients)
            
            /*let fileParts = attachmentName.components(separatedBy: ".")
            let fileName = fileParts[0]
            let fileExtension = fileParts[1]
            
            if let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
                if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)), let mimeType = MIMEType(type: fileExtension) {
                    mailComposer.addAttachmentData(fileData, mimeType: mimeType.rawValue, fileName: fileName)
                    
                    present(mailComposer, animated: true, completion: nil)
                }
            }*/
            present(mailComposer, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        switch result.rawValue
        {
        case MFMailComposeResult.cancelled.rawValue:
            alert("Ooops", msg: "Mail canceled")
        case MFMailComposeResult.sent.rawValue:
            alert("Yes!", msg: "Mail sent")
        case MFMailComposeResult.saved.rawValue:
            alert("Yes!", msg: "Mail saved")
        case MFMailComposeResult.failed.rawValue:
            alert("Oooops!", msg: "Mail failed")
        default: break
        }
        
        dismiss(animated: true, completion: nil)
    }

    fileprivate func alert(_ title: String, msg: String)
    {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

