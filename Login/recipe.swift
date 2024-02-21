import SwiftUI
import WebKit

struct Recipe {
    var title: String
    var videoURL: String
}

struct RecipeListPage: View {
    let recipes: [Recipe] = [
        Recipe(title: "Healthy Pregnancy Snacks", videoURL: "https://www.youtube.com/watch?v=example1"),
        Recipe(title: "Nutrient-Rich Smoothies", videoURL: "https://www.youtube.com/watch?v=example2"),
        Recipe(title: "Balanced Pregnancy Meals", videoURL: "https://www.youtube.com/watch?v=example3"),
        Recipe(title: "Superfoods for Moms", videoURL: "https://www.youtube.com/watch?v=example4"),
        Recipe(title: "Indian Pregnancy Recipes", videoURL: "https://www.youtube.com/watch?v=example5"),
        Recipe(title: "Healthy Juices", videoURL: "https://www.youtube.com/watch?v=example6"),
        Recipe(title: "Fruit-based Recipes", videoURL: "https://www.youtube.com/watch?v=example7"),
        Recipe(title: "Healthy Breakfast Options", videoURL: "https://www.youtube.com/watch?v=example8"),
        Recipe(title: "Lunch Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example9"),
        Recipe(title: "Dinner Recipes for Pregnancy", videoURL: "https://www.youtube.com/watch?v=example10"),
        Recipe(title: "Snack Ideas for Moms", videoURL: "https://www.youtube.com/watch?v=example11"),
        Recipe(title: "Remedy Foods for Moms", videoURL: "https://www.youtube.com/watch?v=example12"),
        Recipe(title: "Ayurvedic Pregnancy Recipes", videoURL: "https://www.youtube.com/watch?v=example13"),
    ]

    var body: some View {
        NavigationView {
            List(recipes, id: \.title) { recipe in
                NavigationLink(destination: RecipeDetailPage(videoURL: recipe.videoURL)) {
                    RecipeListItem(title: recipe.title)
                }
            }
            .navigationBarTitle("Mom's Recipes", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // Handle back button action
            }) {
                Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.blue)
            })
        }
    }
}

struct RecipeListItem: View {
    var title: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    symbolForTitle(title)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(.systemTeal))
                    Text(title)
                        .font(.headline)
                        .padding(.top, 4)
                }
                
            }
            
        }
        .padding(10)
    }

    private func symbolForTitle(_ title: String) -> Image {
        switch title.lowercased() {
        case "healthy pregnancy snacks":
            return Image(systemName: "leaf.arrow.circlepath")
        case "nutrient-rich smoothies":
            return Image(systemName: "flame.circle.fill")
        case "balanced pregnancy meals":
            return Image(systemName: "square.grid.3x2.fill")
        case "superfoods for moms":
            return Image(systemName: "staroflife.circle.fill")
        case "indian pregnancy recipes":
            return Image(systemName: "flag.circle.fill")
        case "healthy juices":
            return Image(systemName: "drop.circle.fill")
        case "fruit-based recipes":
            return Image(systemName: "f.circle.fill")
        case "healthy breakfast options":
            return Image(systemName: "sun.max.circle.fill")
        case "lunch ideas for moms":
            return Image(systemName: "tray.circle.fill")
        case "dinner recipes for pregnancy":
            return Image(systemName: "moon.circle.fill")
        case "snack ideas for moms":
            return Image(systemName: "bag.circle.fill")
        case "remedy foods for moms":
            return Image(systemName: "pill.circle.fill")
        case "ayurvedic pregnancy recipes":
            return Image(systemName: "leaf.circle.fill")
        default:
            return Image(systemName: "questionmark.circle.fill")
        }
    }
}

struct RecipeDetailPage: View {
    var videoURL: String

    var body: some View {
        WebView(urlString: videoURL)
            .navigationBarTitle("Recipe Video", displayMode: .inline)
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No need to update the view in this simple example
    }
}

struct RecipeListPage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListPage()
    }
}
