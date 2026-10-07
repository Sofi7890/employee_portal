# Added Features

## 1. Live GPS Attendance
- Employee clicks **Check In with Live Location**.
- Browser Geolocation API supplies latitude/longitude.
- Backend uses the Haversine formula to calculate distance from the configured college location.
- Within 200 meters = `OFFICE`.
- Outside 200 meters = `HOME`.
- Attendance stores type and coordinates.
- Admin attendance screen and CSV show the location.

Configured office:
- Latitude: 19.028042
- Longitude: 72.845149
- Radius: 200 meters

## 2. AI Attendance Analysis
- Admin can open **AI Attendance Analysis** from the Attendance page.
- Select an employee and analyze the last 30/60/90/180 days.
- The local, dependency-free analysis engine considers checkout completion, average working hours and late-arrival frequency.
- It produces an explainable attendance score, risk level, summary and recommendation.
- It does not require an external API key or internet connection.

## 3. Employee Profile Images
- Admin can upload an optional JPG/JPEG/PNG/GIF/WEBP photo when creating or editing an employee.
- Images are stored outside the web application under:
  `~/ems-uploads/employee-images`
- The database stores only the generated filename.
- The photo is displayed on the employee list, employee details and employee dashboard.
- Existing employee records continue to work without a photo.

## Important
The existing Spring MVC + Hibernate + MySQL architecture was retained. These features were added without migrating the project to Spring Boot.
