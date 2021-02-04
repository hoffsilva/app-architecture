//
//  RootViewController.swift
//  Recordings
//
//  Created by Hoff Henry Pereira da Silva on 04/02/21.
//

import UIKit

final class RootViewController: UIViewController {
	
	@IBOutlet weak var heightConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	
	var miniPlayerIsVisible: Bool = true {
		didSet {
			bottomConstraint.constant = miniPlayerIsVisible ? 0 : -heightConstraint.constant
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		miniPlayerIsVisible = false
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "embedSplitViewController" {
			let splitViewController = segue.destination as! UISplitViewController
			splitViewController.delegate = self
			splitViewController.preferredDisplayMode = .allVisible
		}
	}
	
	@IBAction func unWindFromPlayer(segue: UIStoryboardSegue) {
		let isPlaying = SharedPlayer.shared.audioPlayer?.isPlaying == true
		miniPlayerIsVisible = isPlaying
	}
	
}

extension RootViewController: UISplitViewControllerDelegate {
	
	func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
		guard let topAsDetailController = (secondaryViewController as? UINavigationController)?.topViewController as? PlayViewController else { return false }
		if topAsDetailController.recording == nil {
			// Don't include an empty player in the navigation stack when collapsed
			return true
		}
		return false
	}
	
}
