//
//  ChatViewController.swift
//  Chatty
//
//  Created by mmt on 16/10/21.
//

import UIKit

class ChatViewController: UIViewController {

    var viewModel = ChatViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textChat: UITextField!

    @IBOutlet weak var viewBottom: NSLayoutConstraint!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setup()
    }

    func setup() {
        
        viewModel.chatDelegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(hexString: Constants.HEXColorString.chatViewBgColor)
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: Constants.Identifiers.rightCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.rightCell)
        tableView.register(UINib(nibName: Constants.Identifiers.leftCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.leftCell)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        //TODO:Disable button to avoid multiple requests
        self.view.endEditing(true)
        if let msg = textChat.text, msg.count > 0 {
            spinner.startAnimating()
            viewModel.sendMessage(message: msg)
            textChat.text = ""
        } else {
            //show Alert
            print("show alert")
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardFrame.height
        }
    }
}
extension ChatViewController : ChatDelegate {
    func didReceiveMessage() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
            self.tableView.scrollToBottom()
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.spinner.stopAnimating()
        return true
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messages[indexPath.row]
        if let side = message.side, side % 2 == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.rightCell) as! RightTableCell
            cell.configureCell(message: message)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.leftCell) as! LeftTableCell
            cell.configureCell(message: message)
            return cell
        }
    }
}
