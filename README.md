![Animation - 1748004044417](https://github.com/user-attachments/assets/a2fb5c18-2322-4b98-bf11-1bcf0d2445d6)## College E-commerce App

### About
The College E-commerce App is a Flutter-based mobile application designed for students to buy and sell products within a college community. Users can browse products across categories like sports, electronics, school supplies, and apparel, add items to their wishlist or cart, and sell their own products. The app features a user-friendly interface with secure authentication and an innovative **AI Chat Bot** page for interactive assistance, powered by a conversational AI to answer queries and guide users.

Key features:
- **Product Browsing**: Explore products with details like price, seller info, and location.
- **Wishlist & Cart**: Save favorite items or add them to the cart for purchase.
- **Sell Products**: Upload products with images and descriptions.
- **AI Chat Bot**: Engage with an AI assistant for help with navigation or product queries.
- **Local Network Data**: Fetches user and product data from a local server via HTTP.

### MVVM Architecture
The app follows the **Model-View-ViewModel (MVVM)** architecture with the **Provider** package for efficient state management. This structure ensures a clean separation of concerns, making the codebase scalable and maintainable.

- **Model**: Defines data structures like `User` (name, email, wishlist, cart) and `Product` (id, name, price, image, etc.), handling JSON serialization for HTTP requests.
- **View**: Stateless Flutter widgets (e.g., `HomePage`, `DetailsPage`) render the UI and respond to user interactions, using Provider to access state.
- **ViewModel**: The `UserViewModel` manages user-related state (authentication, wishlist, cart) and communicates with services (`UserService`, `ProductService`) to fetch or update data from a local server (`http://localhost:8181`).
- **Services**: `ProductService` and `UserService` handle HTTP requests (GET, POST, DELETE) to manage products and users, replacing local file storage with server-based persistence.

Provider enables reactive updates without manual state handling, while MVVM keeps business logic separate from UI code.

### Images
![Screenshot_20250523_214126](https://github.com/user-attachments/assets/09edb545-52d2-4ba5-a2db-a6a74f2254be)
![Screenshot_20250523_214123](https://github.com/user-attachments/assets/27232d1e-1f43-451a-82a9-2998a7efeeaa)
![Screenshot_20250523_214032](https://github.com/user-attachments/assets/a0f6b624-edf3-4b57-ade4-572e27b6bce9)
![Screenshot_20250523_214044](https://github.com/user-attachments/assets/07319c4c-9d65-44b8-bb67-f9e1997584bb)
![Screenshot_20250523_214048](https://github.com/user-attachments/assets/3343d012-529d-4c11-a063-d9a6529ccd8c)
![Screenshot_20250523_214113](https://github.com/user-attachments/assets/c0762776-5704-4d0a-be21-7a952f039b47) 
![Screenshot_20250523_214054](https://github.com/user-attachments/assets/1011ec69-1d75-430c-9323-370827aad6b6)

### Cool Features
The College E-commerce App stands out with features tailored for a vibrant student marketplace:

- **AI-Powered Chat Bot**: The `/bots` page integrates an AI conversational agent.
