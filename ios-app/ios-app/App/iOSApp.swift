import SwiftUI
import shared

@main
struct iOSApp: App {
    
    @ObservedObject
    private var appRouter: AppRouter = AppRouter.shared
    
    init() {
        self.appRouter = appRouter
        KurrencySetup.Builder()
            .setCacheManager(cacheManager: CacheManagerImpl())
            .start()
    }
    
	var body: some Scene {
        
		WindowGroup {
            Group {
                switch appRouter.navGraph.destination {
                case .splash: SplashView()
                case .main: MainView()
                }
            }
            .transition(appRouter.navGraph.animation)
            .animation(.default, value: appRouter.navGraph.destination)
		}
	}
}
