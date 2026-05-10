# 💼 Transaction Tracker

![Status](https://img.shields.io/badge/Status-Active_Development-brightgreen)
![Backend](https://img.shields.io/badge/Backend-Completed-blue)
![Frontend](https://img.shields.io/badge/Frontend-In_Progress-orange)

A comprehensive, full-stack Android application designed to help businesses seamlessly manage and track financial transactions and worker attendance. 

Whether it's logging standard salary payouts, managing advance payments, or tracking daily presence and overtime hours, Transaction Tracker provides a centralized dashboard for complete workforce financial management.

---

## ✨ Key Features

*   **Financial Tracking:** Record and monitor worker salaries and advance payments.
*   **Attendance Management:** Keep a daily log of worker presence.
*   **Overtime Calculation:** Track and calculate overtime hours for accurate compensation.
*   **Real-Time Updates:** Live synchronization of data across devices using WebSockets.
*   **Robust Database:** Secure and scalable relational database architecture for reliable record-keeping.

---

## 🛠️ Tech Stack

### Backend (✅ Completed)
*   **Framework:** Node.js with Express.js
*   **Database:** PostgreSQL
*   **Real-time Communication:** Socket.io

### Frontend (🚧 In Progress)
*   **Framework:** Flutter (Android Application)
*   **State Management:** (e.g., Riverpod/Provider - *Update as needed*)

---

## 🚀 Current Project Status

The project is currently in active development. 

*   **Phase 1: Backend Architecture (Completed) 🟢** 
    *   Database schema design and PostgreSQL integration.
    *   RESTful API endpoint creation using Express.js.
    *   Socket.io configuration for real-time state updates.
*   **Phase 2: Mobile Application (In Progress) 🟡**
    *   UI/UX design and Flutter layout construction.
    *   API integration and real-time socket listeners.
    *   State management implementation.

---

## ⚙️ Getting Started (Backend Setup)

Since the frontend is still under construction, you can set up and run the backend environment locally.

### Prerequisites
*   Node.js installed (v16+ recommended)
*   PostgreSQL installed and running locally

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/codeArray-go/transections-tracker.git

2. Install dependencies:
3. ```bash
   npm install
   
4. Set up environment variables:
   Create a `.env` file in the backend root directory and add your PostgreSQL credentials and port details:
   ```env
   PORT=5000
   DB_HOST=localhost
   DB_USER=your_postgres_user
   DB_PASS=your_postgres_password
   DB_NAME=transaction_tracker
