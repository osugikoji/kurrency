import SwiftUI
import shared

internal struct SplashView: View {
    
    @ObservedObject
    private var viewModel: SplashViewModel
    
    private let appRouter: AppRouter
    
    init(
        viewModel: SplashViewModel = .init(),
        appRouter: AppRouter = AppRouter.shared
    ) {
        self.viewModel = viewModel
        self.appRouter = appRouter
    }

	var body: some View {
        VStack {
            Button(action: { viewModel.fetchRates() } ) {
                Text("Redirect")
            }
        }
        .onChange(of: viewModel.redirectToMain) { _ in
            appRouter.push(.main)
        }
	}
}

internal struct SplashView_Previews: PreviewProvider {
	static var previews: some View {
		SplashView()
	}
}
