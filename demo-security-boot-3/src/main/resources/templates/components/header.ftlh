<header style="border-bottom: 1px solid #ccc; padding: 0.5rem 1rem; margin-bottom: 1rem;">
    <nav style="display: flex; align-items: center; gap: 1rem; flex-wrap: wrap;">
        <a href="/">Home</a>
        <span>|</span>
        <a href="/public">Public</a>
        <span>|</span>
        <a href="/admin">Admin</a>
        <#if username??>
            <span style="margin-left: auto;">
                <span>Hello, ${username}</span>
                <form action="/logout" method="post" style="display: inline; margin-left: 0.5rem;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Logout</button>
                </form>
            </span>
        <#else>
            <span style="margin-left: auto;">
                <a href="/login">Login</a>
                <span>|</span>
                <a href="/register">Register</a>
            </span>
        </#if>
    </nav>
</header>
