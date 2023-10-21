import SwiftUI

struct PageView: View {
    var viewControllers: [UIHostingController<AnyView>]

    init(_ views: [AnyView]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        PageViewController(controllers: viewControllers)
            .edgesIgnoringSafeArea(.all)
    }
}

struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [controllers[0]], direction: .forward, animated: true)
    }
}

