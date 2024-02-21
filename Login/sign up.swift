import SwiftUI
import Firebase
import FirebaseAuth
import AuthenticationServices

struct SignUp_Page: View {
    @State private var name = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float = 0
    @State private var errorMessage: String?
    @State private var showingDetails1 = false
    @State private var showingLoginPage = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.teal
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    TextField("Name", text: $name)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)

                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)

                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))

                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button("Sign Up") {
                        signUp()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)

                    // Button to navigate to LoginPage
                    Button("Already have an account? Login") {
                        showingLoginPage = true
                    }
                    .foregroundColor(.black)

                    NavigationLink(destination: Details1(), isActive: $showingDetails1) {
                        EmptyView()
                    }
                    .navigationBarHidden(true)
                }
            }
        }
        .fullScreenCover(isPresented: $showingLoginPage) {
            // Instantiate your LoginPage() view here
            // Example: LoginPage()
            LoginPage()
        }
    }

    func signUp() {
        // Validate email and password
        guard isValidEmail(email) else {
            errorMessage = "Invalid email address"
            return
        }

        guard isValidPassword(password) else {
            errorMessage = "Invalid password. Password must be at least 6 characters."
            return
        }

        // Check if email is already registered
        Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
            guard let error = error else {
                // Email is not registered
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard let user = authResult?.user, error == nil else {
                        errorMessage = error?.localizedDescription ?? "Error during sign-up"
                        return
                    }
                    // Successfully signed up
                    print("User signed up with UID: \(user.uid)")
                    // Navigate to Details1
                    showingDetails1 = true
                }
                return
            }

            // Email is already registered
            errorMessage = "Email is already registered"
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        // Implement your email validation logic
        // For simplicity, a basic email format check is used here
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        // Implement your password validation logic
        // For simplicity, checking if the password has at least 6 characters
        return password.count >= 6
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp_Page()
    }
}
