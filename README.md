# kodar_task
# Mini Task Manager App

##  Features

* **Task Management (CRUD Opration):** View all tasks, add new tasks, update existing ones, and delete tasks.
* **State Management: **Flutter BLoC** and **Cubit** for separation of concerns.
it seprate the ui and logic. make the code clean and easy to update and maintain.
**cubit** = Cubit was chosen for simplicity and efficiency. for the theme only.
* **Theming:** Support for **Light & Dark Mode** with a toggle switch.
* **Navigation:** Declarative routing using **GoRouter**.
* **Responsive UI:** Adaptive layout using `flutter_screenutil`.
* **Dependency Injection:** Decoupled logic using `get_it` (Service Locator pattern).
* **Mock API Integration:** Connected to `mockapi.io` for real-world data .

---

## 🛠 Tech Stack & Libraries
* **State Management:** `flutter_bloc`, `equatable`
* **Networking:** `http` = 
* **Routing:** `go_router`
* **Dependency Injection:** `get_it`
* **Responsiveness:** `flutter_screenutil`

---

## 🏗 flutter Architecture

The project follows a **Clean Layered Architecture** to ensure scalability and testability:
lib/
├── core/                   # Global configurations (Theme, Router, Constants)
├── data/                   # Data Layer (Repositories, Models, API calls)
├── logic/                  # Business Logic Layer (BLoC, Cubit)
├── presentation/           # UI Layer (Screens, Widgets)
└── injection_container.dart # Dependency Injection Setup

**State Management Choice**
I selected a hybrid approach to optimize for both complexity and simplicity:

TaskBloc (BLoC): Used for Task operations (Fetch, Add, Update, Delete).

Reason: Handling API calls involves complex state transitions (Loading, Success, Error). BLoC's event-driven nature makes tracking these changes predictable and easy to debug.

ThemeCubit (Cubit): Used for Theme toggling.

Reason: Toggling between Light/Dark mode is a simple binary state. Using a full BLoC with events would be boilerplate-heavy, so Cubit was chosen for its simplicity.


**Data & API Approach**
Source: MockAPI.io

Base URL: https://692475183ad095fb84744770.mockapi.io/api/v1

Endpoint: /tasks

Implementation: The TaskRepository handles all HTTP requests using the http package, ensuring the UI layer remains unaware of data sources.

**Time Taken**
total time 3 hours

// screenshots
### Add Task Screen

![Add Task](https://raw.githubusercontent.com/sc16141/kodar-task/main/assets/images/add%20task%20screen.png)
![Add manager](https://raw.githubusercontent.com/sc16141/kodar-task/main/assets/images/home2.png)




