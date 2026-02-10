<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
</head>
<body>
    <#include "components/header.ftlh">
    <main>
        <h1>Register</h1>
        <#if error??>
            <p style="color: red;">${error}</p>
        </#if>
        <form action="/register" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div>
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required autofocus/>
            </div>
            <div>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required/>
            </div>
            <div>
                <label for="confirmPassword">Confirm password</label>
                <input type="password" id="confirmPassword" name="confirmPassword"/>
            </div>
            <button type="submit">Register</button>
        </form>
    </main>
</body>
</html>
