//
//  ViewController.swift
//  PhotoCarousel
//
//  Created by David on 2016/4/23.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var container: UIView!
	var imageView: UIImageView!
	var currentImageIndex: Int = 0
	var images: [UIImage?] = [UIImage(named: "3CoEETpvQYO8x60lnZSA_rue.jpg"), UIImage(named: "eDLHCtzRR0yfFtU0BQar_sylwiabartyzel_themap.jpg"), UIImage(named: "Dresden, German.jpg"), UIImage(named: "D8ijGd3CSGq4BxJ9EzTf_13976945916_fa0ce84ee3_o.jpg"), UIImage(named: "camera-man.jpg"), UIImage(named: "c9e42240.jpeg"), UIImage(named: "BIR62RGGjGxN5nrbnzwu_3.jpg"), UIImage(named: "apx8EPiSnWoYHSEiUENI_14553734675_699b2aa038_o.jpg"), UIImage(named: "4151481230_640b61e248_b.jpg")]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		container = UIView(frame: view.frame)
		container.clipsToBounds = true
		view.addSubview(container)
		
		imageView = UIImageView(frame: container.frame)
		imageView.contentMode = .ScaleAspectFill
		container.addSubview(imageView)
		
		imageView.image = images[currentImageIndex]
		imageView.transform = CGAffineTransformMakeScale(1.05, 1.05)
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
//		enlargeImage()
//		shrinkImage()
		shrinkPhoto()
	}
	
	func enlargeImage() {
		UIView.animateWithDuration(3.0, delay: 0, options: [], animations: {
			self.imageView.transform = CGAffineTransformMakeScale(1.05, 1.05)
			}) { (_) in
				self.switchPhotoEnlarge()
		}
	}
	
	func switchPhotoEnlarge() {
		// take a snapshot of current image
		let currentImageSnapshot = imageView.resizableSnapshotViewFromRect(container.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
		currentImageSnapshot.transform = CGAffineTransformMakeScale(1.05, 1.05)
		container.addSubview(currentImageSnapshot)
		
		// get next index
		print(currentImageIndex)
		currentImageIndex = (currentImageIndex + 1) % images.count
		print(currentImageIndex)
		// change image
		imageView.image = images[currentImageIndex]
		// initial state
		imageView.alpha = 0.0
		imageView.transform = CGAffineTransformIdentity
		
		UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { 
			currentImageSnapshot.alpha = 0.0
			self.imageView.alpha = 1.0
			}) { (_) in
				currentImageSnapshot.removeFromSuperview()
				self.enlargeImage()
		}
	}
	
	func shrinkImage() {
		UIView.animateWithDuration(3.0, delay: 0, options: [], animations: {
			self.imageView.transform = CGAffineTransformIdentity
		}) { (_) in
			self.switchPhotoShrink()
		}
	}
	
	func switchPhotoShrink() {
		// take a snapshot of current image
		let currentImageSnapshot = imageView.resizableSnapshotViewFromRect(container.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
		
		// get next index
		currentImageIndex = (currentImageIndex + 1) % images.count
		// change image
		imageView.image = images[currentImageIndex]
		// initial state
		imageView.alpha = 0.0
		imageView.transform = CGAffineTransformMakeScale(1.05, 1.05)
		
		UIView.animateWithDuration(1.0, delay: 5.0, options: [], animations: {
			self.container.addSubview(currentImageSnapshot)
			currentImageSnapshot.alpha = 0.0
			self.imageView.alpha = 1.0
		}) { (_) in
			currentImageSnapshot.removeFromSuperview()
			self.shrinkImage()
		}
	}
	
	func shrinkPhoto() {
		
		// prepate previous image
		let previousImageSnapshot = imageView.resizableSnapshotViewFromRect(container.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
		container.addSubview(previousImageSnapshot)
		imageView.alpha = 0.0
		// get next index
		currentImageIndex = (currentImageIndex + 1) % images.count
		imageView.image = images[currentImageIndex]
		// swtich photo
		UIView.animateWithDuration(1.0, delay: 0, options: [], animations: {
			self.imageView.alpha = 1.0
			previousImageSnapshot.alpha = 0.0
		}) { (_) in
			previousImageSnapshot.removeFromSuperview()
		}
		
		// from big
		self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5)
		UIView.animateWithDuration(6.0, delay: 0, options: [], animations: {
			// to small
			self.imageView.transform = CGAffineTransformIdentity
			}) { (_) in
				self.shrinkPhoto()
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

