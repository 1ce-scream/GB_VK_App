//
//  ViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 12.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    /*
     Связывание элементов на storyboard с IBOutlet
     в контроллере
     */
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bigStack: UIStackView!
    @IBOutlet weak var logoAndAppNameStack: UIStackView!
    @IBOutlet weak var appLogoImage: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var loginStack: UIStackView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordStack: UIStackView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //просто проверка работоспособности нажатия кнопки
    @IBAction func entranceButton(_ sender: Any) {
//        if loginTextField.hasText && passwordTextField.hasText {
//            print("It's alive!!!")
//        } else {
//            print("Text fields are empty")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard))
        
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //подписываемся на сообщения из центра уведомлений
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWasShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Отписка от центра уведомлений при исчезновении контроллера с экрана.
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    
    /*
    переопределение метода shouldPerformSegue с учетом проверки корректности
    введенных значений
    */
    
    override func shouldPerformSegue(
        withIdentifier identifier: String,
        sender: Any?) -> Bool {
        
        let checkResult = checkUserData()
        
        // Проверяем данные
        // Если данные не верны, покажем ошибку
        if !checkResult {
            showLoginError()
        }
        
        // Возвращаем результат
        return checkResult
    }
    
    ///метод для проверки корректности введенных значений в поля логин и пароль
    func checkUserData() -> Bool {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return false }
        
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    ///метод для отображения пользователю ошибки в случае ввода некорректных данных
    func showLoginError() {
        // инициализация экземпляра контроллера
        let alter = UIAlertController(
            title: "Ошибка",
            message: "Введены не верные данные пользователя",
            preferredStyle: .alert)
        
        // инициализация экземпляра кнопки для контроллера UIAlertController
        let action = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil)
        
        // добавление кнопки на UIAlertController
        alter.addAction(action)
        
        // Показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    
    
    //Код из методички для взаимодействия клавиатуры и scrollview
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey)
                        as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: kbSize.height,
                                         right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    //метод для исчезновения клавиатуры при тапе по пустому месту
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
}
