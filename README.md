# 🧺 Already Washed

Already Washed is a mobile application developed using Flutter, designed to provide an easy and efficient laundry service. This app covers the complete cycle of laundry services, from creating orders to tracking them, with an easy-to-use interface.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screens](#screens)
- [Architecture](#architecture)
- [Figma Project Link](#figma-project-link)
- [Installation](#installation)

---

## 📝 Overview

Already Washed aims to make laundry services accessible and straightforward, allowing users to manage their laundry orders efficiently from their mobile devices. The app includes various screens and features for managing orders, tracking status, setting schedules, and accessing subscription packages.

---

## ✨ Features

- 🔐 **User Authentication**: Login, Register, Forgot Password
- 📧 **Email Verification**
- 💳 **Membership and Subscription Management**
- 🚚 **Order Tracking and Status Updates**
- 🔔 **Notifications for Updates**
- 🔒 **Secure Password Reset**
- 📱 **User-friendly Navigation and UI**

---

## 📱 Screens

1. **Onboarding Screen**  
   Display an introduction to the app's features.  
   ![Onboarding Screen](assets/images/onboard.png)

2. **Login Screen**  
   Secure login with email and password.  
   ![Login Screen](assets/images/login.png)

3. **Register Screen**  
   Create a new account.  
   ![Register Screen](assets/images/register.png)

4. **Forgot Password Screen**  
   Initiate password recovery.  
   ![Forgot Password Screen](assets/images/forgot_pass.png)

5. **Email Verification Screen**  
   Verify email for secure access.  
   ![Email Verification Screen](assets/images/verify_mail.png)

6. **Set New Password Screen**  
   Securely set a new password.  
   ![Set New Password Screen](assets/images/set_pass.png)

7. **Home Screen**  
   Main dashboard for navigating features.  
   ![Home Screen](assets/images/home.png)

8. **Membership Screen**  
   View and manage membership options.  
   ![Membership Screen](assets/images/membership.png)

9. **New Order Screen**  
   Place a new laundry order with details, scheduling, and price calculation.  
   ![New Order Screen](assets/images/neworder.png)

10. **Packages and Subscriptions Screen**  
    Access and subscribe to available packages.  
    ![Packages and Subscriptions Screen](assets/images/packages.png)

11. **Settings Screen**  
    Adjust app settings.  
    ![Settings Screen](assets/images/settings.png)

12. **Contact Us Screen**  
    Reach out for support or inquiries.  
    ![Contact Us Screen](assets/images/contactus.png)

13. **Track Order Screen**  
    Track the status of placed orders.  
    ![Track Order Screen](assets/images/trackorder.png)

14. **Order Status Screen**  
    Check the real-time status of the current order.  
    ![Order Status Screen](assets/images/orderstatus.png)

15. **Rating Screen**  
    Rate the service post-completion.  
    ![Rating Screen](assets/images/rating.png)

---

## 🏗️ Architecture

The application is built with the **Cubit** state management approach, making the app's state predictable and efficient. Firebase integration powers key functionalities, such as:

- 📂 **Data Management**: Storing user information and order details.
- 🔒 **Email Verification**: Secure account setup with email verification.
- 🔔 **Notifications**: Real-time updates for order status and reminders.

---

## 🔗 Figma Project Link

Explore the complete design prototype on Figma: [Already Washed on Figma](https://www.figma.com/design/6IeOs5jxPnAnAByqLIE3pO/Laundry-App-(7)?node-id=0-1&node-type=canvas&t=vXR1Z4BuK15Usjpn-0)

---

## ⚙️ Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repo/already-washed.git
   ```
   
2. Navigate to the project directory:

   ```bash
   cd already-washed
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```
   
4. Run the app::

   ```bash
   flutter run
   ```
