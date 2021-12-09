//
//  CustomNavigationController.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 20.09.2021.
//

import UIKit

class CustomNavigationController: UINavigationController,
                                  UINavigationControllerDelegate,
                                  UIViewControllerTransitioningDelegate {
    
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController, to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return PushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return PopAnimator()
        }
        return nil
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController:
            UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        
        return interactiveTransition.interactionInProgress
            ? interactiveTransition : nil
    }
}
