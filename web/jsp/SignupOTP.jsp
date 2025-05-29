<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Sign in enter otp</title>

        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap"
            rel="stylesheet"
            />

        <link rel="stylesheet" href="css/otp.css" >
        <link rel="stylesheet" href="css/home.css">

        <script>
            function validateForm() {
                var otpInput = document.getElementById("otp").value;
                if (otpInput === "") {
                    document.getElementById("error-message").innerText =
                            "Please enter the OTP.";
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <header>
            <div class="logo">
                <img onclick="location.href = 'home.jsp';"
                     src="https://static.vecteezy.com/system/resources/previews/012/986/609/non_2x/network-sharing-circle-logo-icon-free-png.png">
            </div>
            <h3 class="title-home">Fantasy Grammarly</h3>
            <c:if test="${acc != null}">
                <h5 class="accountname">Hello ${acc.realname}</h5>
                <img class="avatar" src="${acc.img}" alt="avatar"/>
            </c:if>
        </header>
        <aside class="sidebar">
            <nav>
                <button class="button-side-bar" onclick="location.href = 'Account';">👤 Account</button>
                <button class="button-side-bar" onclick="location.href = 'history';">🧾 History</button>
                <button class="button-side-bar" onclick="location.href = 'trash';">🗑️ Trash</button>
                <button class="button-side-bar" onclick="location.href = 'ProductController';">💡 Update </button>
            </nav>
            <button onclick="location.href = 'logout';" class="sign-out button-side-bar">🕛 Log Out</button>
            <c:if test="${acc == null}">
                <button onclick="location.href = 'login';" class="sign-out button-side-bar">👤 Log In</button>
            </c:if>
        </aside>
        <main  style="max-width: 70vw; margin-left:300px">
            <div class="main-content">
                <div>
                    <h1>Your OTP</h1>
                    <p>Hey you,</p>
                    <p class="otp-info">
                        Thank you for choosing Fantasy Grammarly. Use the following OTP
                        to complete the procedure to change your email address. OTP is
                        valid for
                        <span class="otp-validity">5 minutes</span>. Do not share this code
                        with others, including Fantasy Grammarly employees.
                    </p>
                    <p class="otp-code"></p>
                    <h1>Enter OTP</h1>
                    <form action="verifyOtp" method="post" onsubmit="return validateForm();">
                        <label for="otp">OTP:</label>
                        <input type="text" id="otp" name="otp" />
                        <input type="submit" value="Verify" />
                    </form>
                    <c:if test="${not empty er}">
                        <p class="error-message">${er}</p>
                    </c:if>
                </div>
            </div>

            <p class="help-text">
                Need help? Ask at
                <a href="mailto:archisketch@gmail.com" style="color: #499fb6; text-decoration: none;"
                   >congkhoa2723@gmail.com</a
                >
                or visit our
                <a href="" target="_blank" style="color: #499fb6; text-decoration: none;"
                   >Help Center</a
                >
            </p>
        </main>
        <% if (request.getAttribute("message") != null) { %>
        <p><%= request.getAttribute("message") %></p>
        <% } %>
    </body>
</html>