//
//  MainViewController.swift
//  skillz
//
//  Created by Florent Capon on 13/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var skillzLabel: UILabel!
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController]!

    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.skillzLabel.font = Fonts.screenTitleFont()
        self.skillzLabel.text = i18n("app.title").uppercased()
        
        if (self.view.bounds.size.width == 675.0) { // iPhone 6
            self.backgroundImageView.image = UIImage(named: "Background~iphone6")
        }
        
        let searchAllyViewController: SearchAllyViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchAllyViewController") as! SearchAllyViewController
        let searchSkillViewController: SearchSkillViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchSkillViewController") as! SearchSkillViewController
        
        self.viewControllers = Array(arrayLiteral: searchAllyViewController, searchSkillViewController)
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        self.pageViewController.setViewControllers([self.viewControllers[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        let superview = self.view
        self.view.addSubview(pageViewController.view)
        pageViewController.view.snp_makeConstraints { (make) in
            make.edges.equalTo(superview!)
        }
        
        self.searchAllyViewController().onSkillSelect = { [weak self] (skill) in
            self?.pageViewController.setViewControllers([(self?.searchSkillViewController())!], direction: .forward, animated: false, completion: nil)
            self?.searchSkillViewController().selectSkill(skill!)
        }
    }
    
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.indexOfViewController(viewController)
        if (index == (self.viewControllers.count - 1)) {
            return nil
        }
        return self.viewControllers[(index + 1)]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.indexOfViewController(viewController)
        if (index == 0) {
            return nil
        }
        return self.viewControllers[(index - 1)]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (previousViewControllers.first == self.searchAllyViewController()) {
            self.searchAllyViewController().swipeTutoHidden = true
        }
    }
    
    
    // MARK: - Helpers
    fileprivate func indexOfViewController(_ viewController: UIViewController) -> Int {
        return self.viewControllers.index(of: viewController)!
    }
    
    fileprivate func searchAllyViewController() -> SearchAllyViewController! {
        return self.viewControllers.first as! SearchAllyViewController
    }
    
    fileprivate func searchSkillViewController() -> SearchSkillViewController! {
        return self.viewControllers.last as! SearchSkillViewController
    }
}
