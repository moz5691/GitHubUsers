import SwiftUI


struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            if case .LOADING = viewModel.currentState {
                loaderView()
            } else if case .SUCCESS(let users) = viewModel.currentState {
                List(users) { user in
                    userCell(user: user)
                        .frame(width: geometry.size.width, height: 80)
                }
            } else if case .FAILURE(let error) = viewModel.currentState {
                VStack(alignment: .center, content: {
                    Spacer()
                    Text(error)
                        .font(.headline.bold())
                        .multilineTextAlignment(.center)
                    Spacer()
                })
                .padding()
            }
        }
    }
    
    
    
    
    @ViewBuilder
    func userCell(user: User) -> some View {
        HStack(spacing: 40) {
            AsyncImage(url: URL(string: user.avatar_url ?? "unknown user")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60, alignment: .center)
            
            Text(user.login ?? "")
                .font(.headline)
            Spacer()

        }
    }
    
    
    @ViewBuilder
    func loaderView() -> some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
    }
    
}

#Preview {
    HomeView()
}
