import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 15")
    }
}

struct ContentView: View {
    @State private var selectedAvatar: Int? = nil
    
    let avatars = Array(repeating: "person.crop.circle", count: 12)
    let texts = Array(repeating: "This is an avatar description.", count: 12)
    
    var body: some View {
        ZStack {
            // Background Image
            Image("bg_pink")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            // Content
            ScrollView {
                VStack {
                    // Title
                    Text("About Us")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top, 35.0)
                        
                    
                    // Avatar Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(avatars.indices, id: \.self) { index in
                            if selectedAvatar != index {
                                AvatarView(imageName: avatars[index], text: texts[index], isSelected: false)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            selectedAvatar = index
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
            
            // Selected Avatar Overlay
            if let selectedAvatar = selectedAvatar {
                VStack {
                    AvatarView(imageName: avatars[selectedAvatar], text: texts[selectedAvatar], isSelected: true)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.selectedAvatar = nil
                            }
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
                .animation(.spring(), value: selectedAvatar)
            }
        }
    }
}

struct AvatarView: View {
    let imageName: String
    let text: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: isSelected ? 180 : 120, height: isSelected ? 180 : 120)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                .shadow(radius: 3)
                .padding(.bottom, isSelected ? 20 : 0)
            
            if isSelected {
                Text(text)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
        }
        .transition(.scale)
    }
}

