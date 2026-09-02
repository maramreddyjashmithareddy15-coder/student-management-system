# College Student Management System (CampusLink)

CampusLink is a modern, responsive, full-stack college portal designed to manage academic departments, courses, subjects, student records, faculty files, attendance schedules, and student transcripts. 

---

## 🚀 Features

### 👤 Role-Based Authentication & Access
The portal provides three custom dashboards with restricted privileges:
*   **Admin Dashboard**: Has full CRUD authority over student details, faculty profiles, notices, course programs, departments, and subjects. Accesses visual analytics on student demographics, gender distributions, and logs.
*   **Faculty Dashboard**: Views assigned subjects, logs student attendance for classes, enters marks for exams (auto-calculates grades, percentages, and GPAs), and views academic notices.
*   **Student Dashboard**: Views profile summaries, notice boards, subject schedules, and detailed academic transcripts (marks cards) and attendance percentages with colored progress indicators and deficit warnings (below 75%).

### 📊 Dynamic Visual Data Analytics
*   Students by department counts (Recharts BarChart).
*   Demographic gender spreads (Recharts PieChart).
*   Presence ratios & subject-wise attendance performance (Recharts BarChart).

### 📋 Reports & Audits
*   Generate summaries for Students, Faculty, Departments, Attendance lists, and Marks cards.
*   **Export to CSV**: Generates standard spreadsheet formats instantly.
*   **Export to PDF/Print**: Implements customized CSS layouts to print official records.

---

## 🛠️ Technology Stack

*   **Frontend**: React.js, Vite, Tailwind CSS, React Router v6, Axios, Recharts, Lucide Icons
*   **Backend**: Node.js, Express.js (REST API, JWT auth, role authorization filters)
*   **Database**: Dual-Adapter Support (connects to **MySQL** by default, but seamlessly falls back to **SQLite** local databases for zero-setup verification out-of-the-box).

---

## 📦 Project Directory Structure

```text
/
├── backend/                       # Node.js + Express API
│   ├── src/
│   │   ├── config/
│   │   │   └── db.js              # Database Client Wrapper (MySQL/SQLite)
│   │   ├── db/
│   │   │   ├── schema.mysql.sql   # Production MySQL Script
│   │   │   ├── schema.sqlite.sql  # Local Verification SQLite Script
│   │   │   └── seeder.js          # Auto-seeder for demo profiles
│   │   ├── middleware/
│   │   │   └── auth.js            # JWT RBAC checks
│   │   ├── routes/                # API routers per module
│   │   │   ├── auth.js
│   │   │   ├── students.js
│   │   │   ├── faculty.js
│   │   │   ├── departments.js
│   │   │   ├── courses.js
│   │   │   ├── subjects.js
│   │   │   ├── attendance.js
│   │   │   ├── marks.js
│   │   │   ├── notices.js
│   │   │   └── dashboard.js
│   │   └── app.js                 # App settings
│   ├── package.json
│   └── .env                       # Environment configs
│
├── frontend/                      # React + Vite Client
│   ├── src/
│   │   ├── components/            # Reusable UI widgets
│   │   │   ├── Navbar.jsx
│   │   │   ├── Sidebar.jsx
│   │   │   ├── DashboardCard.jsx
│   │   │   ├── DataTable.jsx
│   │   │   ├── Modal.jsx
│   │   │   ├── Loading.jsx
│   │   │   └── ErrorMessage.jsx
│   │   ├── context/
│   │   │   └── AuthContext.jsx    # Session context
│   │   ├── routes/
│   │   │   └── ProtectedRoute.jsx # Route security guard
│   │   ├── services/
│   │   │   ├── api.js             # Axios base instance
│   │   │   └── auth.js            # Auth API triggers
│   │   ├── pages/                 # Interface views
│   │   │   ├── Login.jsx
│   │   │   ├── AdminDashboard.jsx
│   │   │   ├── FacultyDashboard.jsx
│   │   │   ├── StudentDashboard.jsx
│   │   │   ├── Students.jsx
│   │   │   ├── StudentProfile.jsx
│   │   │   ├── Faculty.jsx
│   │   │   ├── Departments.jsx
│   │   │   ├── Courses.jsx
│   │   │   ├── Subjects.jsx
│   │   │   ├── Attendance.jsx
│   │   │   ├── Marks.jsx
│   │   │   ├── Notices.jsx
│   │   │   ├── Reports.jsx
│   │   │   └── Profile.jsx
│   │   ├── App.jsx
│   │   ├── main.jsx
│   │   └── index.css              # Custom styling definitions
│   ├── package.json
│   ├── vite.config.js
│   └── tailwind.config.js
```

---

## ⚙️ Installation & Setup Instructions

### System Requirements
*   Node.js (v18.0.0 or higher recommended)
*   npm (Package Manager)

### Step 1: Clone and Configure Environment

Navigate to the `backend/` directory, copy the `.env.example` configurations, and edit `.env`:

```bash
# Inside /backend directory
cp .env.example .env
```

By default, `.env` is configured to use **SQLite** (`DB_TYPE=sqlite`) to run the database completely locally inside a single database file without requiring a MySQL server.

To switch to a production **MySQL** database, update `.env` to:
```ini
PORT=5000
JWT_SECRET=your_jwt_secret_key_here
DB_TYPE=mysql
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password_here
DB_NAME=student_management
```
*(If using MySQL, ensure you have created the database `student_management` in your MySQL database before running the server).*

---

### Step 2: Start the Backend Server

```bash
cd backend
npm install
npm run dev
```

*   The database schemas and seeder records are **automatically applied** on first launch if the database is empty.
*   The server will bind to port `5000`.

---

### Step 3: Start the Frontend React Client

In a separate terminal window:

```bash
cd frontend
npm install
npm run dev
```

*   The Vite development server will bind to `http://localhost:3000`.
*   All api endpoints calls are proxied dynamically to the backend at port `5000`.

---

## 🔑 Demo Login Credentials

Upon database initialization, the database seeder creates default profiles with the following login keys:

| User Role | Username/Email | Default Password | Linked Profile Name |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin@college.com` | `admin123` | Administrator |
| **Faculty** | `faculty@college.com` | `faculty123` | Dr. Grace Hopper |
| **Student** | `student@college.com` | `student123` | Jane Smith |

---

## 📡 REST API Documentation

### 🔒 Public Authentication
*   `POST /api/auth/login` - Authenticate credentials. Returns signed JWT token and user profile.
*   `GET /api/auth/me` - Resolves token, returns fresh login details (Protected).
*   `PUT /api/auth/change-password` - Changes password for current session (Protected).

### 🎓 Students Management
*   `GET /api/students` - List students (with filters `department_id`, `course_id`, `year`, `semester`, search strings, and pagination parameters).
*   `GET /api/students/:id` - Detailed profile metrics (grades list, subject list, attendance aggregates).
*   `POST /api/students` - Register student. Auto-inserts login credentials.
*   `PUT /api/students/:id` - Modify student details.
*   `DELETE /api/students/:id` - Remove student profile and login account.

### 👤 Faculty Management
*   `GET /api/faculty` - List staff members.
*   `POST /api/faculty` - Register staff member. Auto-inserts login credentials.
*   `PUT /api/faculty/:id` - Modify staff details.
*   `DELETE /api/faculty/:id` - Remove faculty records and login account.

### 🏫 Departments, Courses & Subjects
*   `GET /api/departments` - List departments with student/faculty counts.
*   `POST` / `PUT` / `DELETE` `/api/departments` - Modify departments.
*   `GET /api/courses` - List course curriculums.
*   `POST` / `PUT` / `DELETE` `/api/courses` - Modify course offerings.
*   `GET /api/subjects` - List subjects (shows assigned instructors).
*   `POST` / `PUT` / `DELETE` `/api/subjects` - Create subjects and assign faculty.

### 📅 Attendance Logs
*   `GET /api/attendance` - Pull roll sheet by filters (`course_id`, `semester`, `subject_id`, `date`) or returns detailed log array for student user.
*   `POST /api/attendance` - Bulk log/update class presence sheet.

### 🏆 Academic Grades
*   `GET /api/marks` - Load marks list by filters (`course_id`, `semester`, `subject_id`, `exam_type`) or returns transcript array for student.
*   `POST /api/marks` - Publish/update marks card for components.

### 📢 Notices & Announcements
*   `GET /api/notices` - Fetch notices board targeted to user role.
*   `POST` / `PUT` / `DELETE` `/api/notices` - Modify campus circular bulletins (Admin only).

### 📊 Dashboard Analysis
*   `GET /api/dashboard/stats` - Fetch aggregate charts arrays and stats counters based on token permissions.

---

## 🔮 Future Enhancements

1.  **Online Admissions Module**: Enable prospective students to register, upload academic credentials, and pay fees online.
2.  **LMS Integration**: Integrate class notes, file uploads, quizzes, and assignment portals.
3.  **Real-time Notifications**: Trigger immediate notifications or email alerts to students when attendance slips below 75% or new grades are published.
4.  **SMS Gateway Integration**: Forward automated SMS warnings to parent contacts when students register absences.
