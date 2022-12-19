//
//  PopAnimator.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import UIKit

// MARK: - UIViewControllerAnimatedTransitioning

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	enum Direction {
		case present
		case dismiss
	}
	
	let duration = 0.8
	var direction = Direction.present
	var originFrame = CGRect.zero
	
	var dismissCompletion: (() -> Void)?
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let containerView = transitionContext.containerView
		let toView = transitionContext.view(forKey: .to) ?? UIView()
		let destView = direction == .present ? toView : transitionContext.view(forKey: .from) ?? UIView()
		
		let initialFrame = direction == .present ? originFrame : destView.frame
		let finalFrame = direction == .present ? destView.frame : originFrame
		
		let xScaleFactor = direction == .present ?
		initialFrame.width / finalFrame.width :
		finalFrame.width / initialFrame.width
		
		let yScaleFactor = direction == .present ?
		initialFrame.height / finalFrame.height :
		finalFrame.height / initialFrame.height
		
		let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
		
		if direction == .present {
			destView.transform = scaleTransform
			destView.center = CGPoint(
				x: initialFrame.midX,
				y: initialFrame.midY)
			destView.clipsToBounds = true
		}
		
		destView.layer.cornerRadius = direction == .present ? 20.0 : 0.0
		destView.layer.masksToBounds = true
		
		containerView.addSubview(toView)
		containerView.bringSubviewToFront(destView)
		
		UIView.animate(
			withDuration: duration,
			delay:0.0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 0.2,
			animations: {
				destView.transform = self.direction == .present ? .identity : scaleTransform
				destView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
				destView.layer.cornerRadius = self.direction == .dismiss ? 20.0 : 0.0
			}, completion: { _ in
				if self.direction == .dismiss {
					self.dismissCompletion?()
				}
				transitionContext.completeTransition(true)
			})
	}
	
	private func handleRadius(destView: UIView, hasRadius: Bool) {
		destView.layer.cornerRadius = hasRadius ? 20.0 : 0.0
	}
}
