//
//  LoadingViewController.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 08.09.2021.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var dotStack: UIStackView!
    @IBOutlet weak var leftDot: UIImageView!
    @IBOutlet weak var middleDot: UIImageView!
    @IBOutlet weak var rightDot: UIImageView!
    
    /// Счетчик для выхода из цикла
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Задаем начальное значение alpha
        self.leftDot.alpha = 0
        self.rightDot.alpha = 0
        self.middleDot.alpha = 0
        // Вызываем метод анимации
        showDotsAnimation()
    }
    
    /// Метод анимирующий точки на экране
    private func showDotsAnimation() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [],
            animations: {
                self.leftDot.alpha = 1
                self.rightDot.alpha = 0
            })
        { _ in
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: [],
                animations: {
                    self.middleDot.alpha = 1
                    self.leftDot.alpha = 0
                })
            { _ in
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: [],
                    animations: {
                        self.rightDot.alpha = 1
                        self.middleDot.alpha = 0
                    })
                { _ in
                    if self.counter < 2 {
                        // Если счетчик меньше 2, то увеличиваем его
                        //и заново вызываем метод анимации
                        self.counter += 1
                        self.showDotsAnimation()
//                        self.fadeDotsAnimation()
                    } else {
                        // Присваиваем переменной логин контроллер по ID
                        let loginViewController = self.storyboard?
                            .instantiateViewController(
                                withIdentifier: "LoginViewController")
                            as! LoginViewController
                        // Задаем полноэкранный режим контроллеру
                        loginViewController.modalPresentationStyle =
                            UIModalPresentationStyle.fullScreen
                        // Задаем анимацию перехода
                        loginViewController.modalTransitionStyle =
                            UIModalTransitionStyle.flipHorizontal
                        // Переходим к контроллеру
                        self.present(
                            loginViewController,
                            animated: true,
                            completion: nil)
                    }
                }
            }
        }
    }
}
