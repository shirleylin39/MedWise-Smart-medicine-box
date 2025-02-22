# MedWise: A Smart Medication Management System

## 1. Overview
MedWise is an intelligent medication management system designed to assist users in managing their daily medication intake. The system features a smart box, a Flutter-based mobile application, and a robust Node.js backend powered by Express.js and MongoDB. Together, these components provide timely reminders, secure medication storage, and detailed tracking for users and caregivers. Watch the demonstration on [Youtube](https://youtu.be/1V0bv1TzS4I).

---

## 2. Key Features


### 2.1. Smart Box (Adruino)
- **Secure Storage**: Compartmentalized design with a smart locking mechanism.
- **Integrated Notifications**: Provides visual and auditory reminders for medication times.
- **Intake Monitoring**: Infrared sensors (planned) to detect medication removal.

### 2.2. Mobile App Frontend (Flutter)
- **User-Friendly Interface**: Built using Dart and Flutter for seamless user experience.
- **Medication Management**: Schedule medications, set reminders, and monitor intake.
- **Remote Monitoring**: Caregivers can track users' adherence in real-time.

### 2.3. Backend System
- **API Integration**: RESTful APIs built with Express.js to handle device data and schedules.
- **Database Management**: MongoDB for secure and efficient data storage.
- **Scheduling Logic**: Automatically generates medication schedules based on user input.

---

## 3. Mobile App Frontend (Flutter)

### 3.1. Technologies Used
- **Flutter**: For cross-platform application development.
- **Dart**: Programming language for building the application.
- **Figma**: Used for UI/UX prototyping.
- **HTTP Package**: To make API calls to the backend.
- **Android Studio**: IDE for development and debugging

### 3.2. Features
- **Add/Update Medications**: Users can enter detailed medication plans, including time and dosage.
- **Notifications**: Push notifications for timely reminders.
- **Add/Modify Devices**: Seamlessly manage devices and schedules.


---

## 4. Backend (Node.js & Express.js)

### 4.1. Technologies Used
- **Node.js**: Server-side runtime.
- **Express.js**: Framework for building RESTful APIs.
- **MongoDB**: Database for storing user, device, and schedule data.
- **Mongoose**: Object Data Modeling (ODM) library for MongoDB.

### 4.2. API Endpoints
#### MedWise Device Management
- `GET /api/medwises`: Fetch all registered devices.
- `POST /api/medwises`: Add a new device.
- `PUT /api/medwises/:id`: Update an existing device.
- `GET /api/medwises/:id`: Fetch a specific device by ID.

#### Schedule Management
- `POST /api/create-schedule/:id`: Create a 7-day medication schedule for a device.
- `GET /api/backlogs`: Fetch all schedules.
- `GET /api/backlogs/:deviceId`: Fetch schedules for a specific device.

### 4.3. Backend Logic
- **Scheduling**: Generates 7-day medication schedules based on input times and medication names.
- **Data Validation**: Ensures robust data handling and error checking.

---

## 5. Use Cases

1. **Busy Professionals**: Tim, an office worker, uses MedWise to manage his medications and receives timely reminders on his phone and smart box.
2. **Elderly Care**: Tim helps his mother, Mary, by setting up her weekly medications on MedWise. Mary receives notifications, and Tim monitors her adherence remotely.
3. **Childcare Settings**: Tim's sister, a teacher, manages medications for multiple children using MedWise, ensuring accuracy and security.

These scenarios demonstrate the system's versatility and practicality for diverse users and settings.

---

## 6. Installation and Usage

### 6.1. Backend Setup
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/shirleylin39/MedWise-Smart-medicine-box
   cd medwise_app_backend
   ```
2. **Install Dependencies**:
   ```bash
   npm install
   ```
3. **Run the Server**:
   ```bash
   node app.js
   ```
4. **Database**:
   Ensure MongoDB is running locally or provide a remote connection string.

### 6.2. Frontend Setup
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/shirleylin39/MedWise-Smart-medicine-box
   cd medwise_app_frontend
   ```
2. **Install Flutter**:
   Follow instructions at [Flutter Installation](https://flutter.dev/docs/get-started/install).
3. **Install All Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the App**:
   ```bash
   flutter run
   ```

---

## 7. License
This project is licensed under the ![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg).

