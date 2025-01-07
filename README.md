# BarberBooker

**BarberBooker** is a Barber's Reservation App that enables users to easily book appointments with their preferred barber at a barbershop. This app allows customers to schedule haircuts and other services, view available slots, and get notifications for upcoming appointments. It’s built using **Flutter** for the frontend and **Firebase** as the backend to handle authentication, database management, and notifications. The app also uses **SharedPreferences** for storing user preferences locally.

## Features

- **User Registration & Authentication**  
  Users can sign up and log in using their email/password.  
  Authentication is handled via **Firebase Authentication**.

- **Appointment Scheduling**  
  Users can browse available barbers, select a service (e.g., haircut, shave), and reserve a time slot.  
  Availability is fetched in real-time using **Firebase Firestore**.

- **Admin Panel (Barber Interface)**  
  Barbers can manage their availability and view upcoming appointments via an easy-to-use interface.

## Tech Stack

- **Frontend**  
  - **Flutter** for building a cross-platform app (iOS & Android).  
  - **Dart** as the primary programming language.  
  - **Provider** for state management (optional).

- **Backend**  
  - **Firebase Authentication** for secure sign-in and sign-up.  
  - **Firebase Firestore** for real-time data storage, including user details and bookings.  
  - **Firebase Cloud Messaging (FCM)** for sending push notifications.

- **Local Storage**  
  - **SharedPreferences** for storing local user settings, including preferences and user state.

## Setup Instructions

To set up **BarberBooker** on your local machine, follow the instructions below:

### 1. Clone the Repository

```bash
git clone https://github.com/pukarnepali/BarberQueue.git
cd BarberQueue
