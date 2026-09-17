//
//  ViewController.swift
//  practica-1-IOS
//
//  Created by Jesus Alberto Villarreal Perez on 17/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var carouselScroll: UIScrollView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!

    private var currentIndex = 0

    private var images: [UIImageView] { [image1, image2, image3] }

    override func viewDidLoad() {
        super.viewDidLoad()
        carouselScroll.delegate = self
        carouselScroll.isPagingEnabled = true
        carouselScroll.showsHorizontalScrollIndicator = false
        carouselScroll.showsVerticalScrollIndicator = false
        carouselScroll.contentInsetAdjustmentBehavior = .never
        updateCounter()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let pageWidth = carouselScroll.bounds.width
        if pageWidth > 0 {
            carouselScroll.contentOffset.x = pageWidth * CGFloat(currentIndex)
        }
    }

    private func updateCounter() {
        counterLabel.text = "\(currentIndex + 1) / \(images.count)"
    }

    private func goToPage(_ index: Int, animated: Bool) {
        currentIndex = max(0, min(index, images.count - 1))
        let pageWidth = carouselScroll.bounds.width
        carouselScroll.setContentOffset(CGPoint(x: pageWidth * CGFloat(currentIndex), y: 0), animated: animated)
        updateCounter()
    }

    @IBAction func menuButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Menú", message: "Aquí irá el menú lateral.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @IBAction func prevButtonTapped(_ sender: UIButton) {
        goToPage(currentIndex - 1, animated: true)
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        goToPage(currentIndex + 1, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        syncPage(from: scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        syncPage(from: scrollView)
    }

    private func syncPage(from scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        guard pageWidth > 0 else { return }
        currentIndex = Int((scrollView.contentOffset.x / pageWidth).rounded())
        updateCounter()
    }
}