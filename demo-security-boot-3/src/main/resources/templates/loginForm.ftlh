<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <#include "components/header.ftlh">
    <main>
        <h1>Login</h1>
        <#if message??>
            <p style="color: green;">${message}</p>
        </#if>
        <#if error??>
            <p style="color: red;">${error}</p>
        </#if>
        <form action="/login" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div>
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required autofocus/>
            </div>
            <div>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required/>
            </div>
            <button type="submit">Login</button>
        </form>
    </main>
</body>
</html>
