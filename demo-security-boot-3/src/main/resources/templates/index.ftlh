<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
</head>
<body>
    <#include "components/header.ftlh">
    <main>
        <h1>Welcome</h1>
        <#if username??>
            <p>Hello, ${username}!</p>
        <#else>
            <p>Please <a href="/login">login</a> or <a href="/register">register</a>.</p>
        </#if>
    </main>
</body>
</html>
