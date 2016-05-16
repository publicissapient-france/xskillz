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
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var skillzLabel: UILabel!
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController]!

    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.skillzLabel.text = i18n("app.title").uppercaseString
        
        if (self.view.bounds.size.width == 675.0) { // iPhone 6
            self.backgroundImageView.image = UIImage(named: "Background~iphone6")
        }
        
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
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (previousViewControllers.first == self.searchAllyViewController()) {
            self.searchAllyViewController().swipeTutoHidden = true
        }
    }
    
    
    // MARK: - Helpers
    private func indexOfViewController(viewController: UIViewController) -> Int {
        return self.viewControllers.indexOf(viewController)!
    }
    
    private func searchAllyViewController() -> SearchAllyViewController {
        return self.viewControllers.first as! SearchAllyViewController
    }
    
    private func searchSkillViewController() -> SearchSkillViewController {
        return self.viewControllers.last as! SearchSkillViewController
    }
}
