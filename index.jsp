<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"> <!-- Optional for older browsers -->
    <title>Amazing Thailand - Magic Meets Tradition</title>
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
        <button class="menu-button">☰</button> <!-- Button to toggle mobile menu -->
    </nav>

    <main class="hero">
        <div class="hero-content">
            <h1>Magic Meets Tradition</h1>
            <p>Embark On An Unforgettable Journey Through The Diverse Landscapes And Rich Cultural Tapestry Of Thailand.</p> <!-- Update place to Thailand -->
        </div>
    </main>

    <script>
        // Mobile menu toggle
        const menuButton = document.querySelector('.menu-button');
        const navLinks = document.querySelector('.nav-links');

        menuButton.addEventListener('click', () => {
            navLinks.classList.toggle('active'); // Toggle the 'active' class for mobile menu visibility
        });

        // Hide menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!e.target.closest('nav')) {
                navLinks.classList.remove('active');
            }
        });

        // Smooth scroll for navigation links (if any in the future)
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>
