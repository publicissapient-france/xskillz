//
//  MainViewController.swift
//  skillz
//
//  Created by Florent Capon on 13/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit
import Masonry

class MainViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchAllyViewController: SearchAllyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchAllyViewController") as! SearchAllyViewController
        let searchSkillViewController: SearchSkillViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchSkillViewController") as! SearchSkillViewController
        
        self.viewControllers = Array(arrayLiteral: searchAllyViewController, searchSkillViewController)
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        self.pageViewController.setViewControllers([self.viewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        let superview = self.view
        self.view.addSubview(pageViewController.view)
        pageViewController.view.mas_makeConstraints { make in
            make.edges.equalTo()(superview)
        }
    }
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        return self.viewControllers.indexOf(viewController)!
    }
    
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = self.indexOfViewController(viewController)
        if (index == (self.viewControllers.count - 1)) {
            return nil
        }
        return self.viewControllers[(index + 1)]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = self.indexOfViewController(viewController)
        if (index == 0) {
            return nil
        }
        return self.viewControllers[(index - 1)]
    }
    
    
    // MARK: - UIPageViewControllerDelegate
}
