//
//  ViewController.swift
//  TextViewMoveToFit
//
//  Created by 清水智貴 on 2021/01/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var moveToFitTextView: UITextView!
    @IBOutlet var showKeyboardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextView()
    }
    
    
}

// textViewに関する処理
extension ViewController: UITextViewDelegate {
    
    func configureTextView() {
        moveToFitTextView.delegate = self
        moveToFitTextView.layer.cornerRadius = 10
    }
    
    // 改行(完了)ボタンを押した時に呼ばれる処理
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    // TextFieldおよびTextView以外の部分をタッチ => TextFieldが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Notificationを設定
    func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Notificationを削除
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // キーボードが現れた時に、画面全体をずらす
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
            }
        }
    }
    
    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    // テキストの初期設定を変更したい時に使う、UITextViewDelegateのオプションの関数(文字制限を設けたい場合など)
    //    func textViewDidChange(_ textView: UITextView) {
    //        confirmContent()
    //    }
    
    // textViewとimageViewの内容の有無を確認する関数
    //    func confirmContent() {
    //        // どちらにも何かしらの値がある時
    //        if postTextView.text.count > 0 && postImageView.image != placeholderImage {
    //            // "シェアする"ボタンが押せる
    //            postButton.isEnabled = true
    //        } else {// どちらか、または、両方とも何も情報がなかった場合
    //            // "シェアする"ボタンが押せない状態になる
    //            postButton.isEnabled = false
    //        }
    //    }
}
