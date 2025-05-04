Data Structures Learning App (with AI ChatBot)

An interactive Flutter application designed to help students learn and explore Data Structures through detailed visual explanations and an AI-powered ChatBot.
✨ Features

    🧠 Smart ChatBot powered by Google Gemini AI
    Ask anything about data structures — the bot explains in simple language.

    🧾 Visual Pages for Each Data Structure
    Includes explanations and examples for:

        Arrays

        Linked Lists

        Stacks

        Queues

        Trees

        Graphs

        Hash Tables

    💬 Time-stamped Chat Interface
    Clean and simple UI for AI conversation.

    🔐 Secure API Key management (via secrets.dart)

📸 Screenshots

(Add your app screenshots here to show off the UI)
🚀 How to Run the Project
1. Clone the Repo

git clone https://github.com/yourusername/data-structures-app.git
cd data-structures-app

2. Add Your API Key

Create a file lib/hidden/api.dart:

const String apiKey = 'YOUR_GOOGLE_API_KEY_HERE';

✅ Make sure this file is ignored by Git (.gitignore):

lib/hidden/api.dart

3. Get Packages & Run

flutter pub get
flutter run

💡 Example Use Case

    Student types:
    What is the difference between a Stack and a Queue?

    ChatBot replies:
    A stack uses LIFO (Last-In-First-Out), while a queue uses FIFO (First-In-First-Out)...
👨‍💻 Made by

Mohamed – Flutter Developer
Inspired by the need for better, interactive tools to learn complex computer science concepts.
📝 License

This app is open-source and for educational use only
