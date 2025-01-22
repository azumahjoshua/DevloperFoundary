<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="index.css">
</head>
<body>
    <nav>
        <div class="nav-links">
            <a href="tourism.jsp">Tourism</a>
            <a href="student.jsp">Student</a>
            <a href="jobs.jsp">Job applicant</a>
            <a href="business.jsp">Business</a>
        </div>
        <div class="logo">
            <img src="images/mylogo.png" alt="Amazing Thailand Logo">
        </div>
        <a href="#book" class="cta-button">Let's Traveling</a>
        <button class="menu-button">☰</button>
    </nav>

    <main>
        <div class="container">
            <h2>Login</h2>
            <form action="./api3" method="post" id="loginForm">
                <label for="usename">Username:</label>
                <input type="text" id="usename" name="usename" required>

                <label for="pass">Password:</label>
                <div class="password-container">
                    <input type="password" id="pass" name="pass" required>
                    <span class="toggle-password" onclick="togglePassword()">Show</span>
                </div>
                <button type="submit">Log in</button>
            </form>
        </div>
    </main>

    <script>
        // Mobile menu toggle
        const menuButton = document.querySelector('.menu-button');
        const navLinks = document.querySelector('.nav-links');

        menuButton.addEventListener('click', () => {
            navLinks.classList.toggle('active'); // Toggle the visibility of the menu
        });

        // Hide menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!e.target.closest('nav')) {
                navLinks.classList.remove('active');
            }
        });

        // Smooth scroll for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Function to toggle password visibility (optional)
        function togglePassword() {
            const passwordField = document.getElementById("pass");
            const passwordToggle = document.querySelector(".toggle-password");
            if (passwordField.type === "password") {
                passwordField.type = "text";
                passwordToggle.textContent = "Hide";
            } else {
                passwordField.type = "password";
                passwordToggle.textContent = "Show";
            }
        }
    </script>
</body>
</html>
