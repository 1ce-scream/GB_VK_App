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
        // Задаем цвет точкам
        self.leftDot.tintColor = .systemBackground
        self.rightDot.tintColor = .systemBackground
        self.middleDot.tintColor = .systemBackground
        // Вызываем метод анимации
        showDotsAnimation()
//        showDotsAnimation2()
        showCloudAnimation()
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
    
    /// Второй вариант анимации через keyFrames
    private func showDotsAnimation2() {
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0,
            options: [.repeat],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 1/3) {
                    self.leftDot.alpha = 1
                    self.rightDot.alpha = 0
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 1/3,
                    relativeDuration: 1/3) {
                    self.middleDot.alpha = 1
                    self.leftDot.alpha = 0
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 2/3,
                    relativeDuration: 1/3) {
                    self.rightDot.alpha = 1
                    self.middleDot.alpha = 0
                }
            }) { _ in
            if self.counter < 2 {
                self.counter += 1
                self.showDotsAnimation2()
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
    
    /// Анимация облачка
    func showCloudAnimation(){
        
        /// Вьюха облачка
        let cloudView = UIView()
        
        // Добавляем в сабвью
        view.addSubview(cloudView)
        // Отключаем авторесайз
        cloudView.translatesAutoresizingMaskIntoConstraints = false
        // Задаем констрейнты
        NSLayoutConstraint.activate([
            cloudView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            cloudView.bottomAnchor.constraint(
                equalTo: middleDot.topAnchor,
                constant: -10),
            cloudView.widthAnchor.constraint(
                equalToConstant: 120),
            cloudView.heightAnchor.constraint(
                equalToConstant: 70)
        ])
        /// Форма облачка
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 60))
        path.addQuadCurve(
            to: CGPoint(x: 20, y: 40),
            controlPoint: CGPoint(x: 5, y: 50))
        path.addQuadCurve(
            to: CGPoint(x: 40, y: 20),
            controlPoint: CGPoint(x: 20, y: 20))
        path.addQuadCurve(
            to: CGPoint(x: 70, y: 20),
            controlPoint: CGPoint(x: 55, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: 80, y: 30),
            controlPoint: CGPoint(x: 80, y: 20))
        path.addQuadCurve(
            to: CGPoint(x: 110, y: 60),
            controlPoint: CGPoint(x: 110, y: 30))
        path.close()

        /// Слой для анимации облачка
        let layerAnimation = CAShapeLayer()
        layerAnimation.path = path.cgPath
        layerAnimation.strokeColor = UIColor.systemBackground.cgColor
        layerAnimation.fillColor = UIColor.clear.cgColor
        layerAnimation.lineWidth = 8
        layerAnimation.lineCap = .round
        // Добавляем слой
        cloudView.layer.addSublayer(layerAnimation)
        
        /// Анимация в конце пути
        let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimationEnd.fromValue = 0
        pathAnimationEnd.toValue = 1
        pathAnimationEnd.duration = 1.5
        pathAnimationEnd.fillMode = .both
        pathAnimationEnd.isRemovedOnCompletion = false
        
        /// Анимация в начале пути
        let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        pathAnimationStart.fromValue = 0
        pathAnimationStart.toValue = 1
        pathAnimationStart.duration = 1.5
        pathAnimationStart.fillMode = .both
        pathAnimationStart.isRemovedOnCompletion = false
        pathAnimationStart.beginTime = 1
        
        /// Группа анимаций для начала и конца
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.5
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
        animationGroup.repeatCount = .infinity
        layerAnimation.add(animationGroup, forKey: nil)

    }
}
