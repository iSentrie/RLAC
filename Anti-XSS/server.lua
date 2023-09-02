local patterns = { "<!DOCTYPE>","<a>", "<abbr>", "<address>", "<area>", "<article>", "<aside>", "<audio>","<b>", "<base>", "<basefont>", "<bdi>", "<bdo>", "<big>", "<blockquote>", "<body>", "<br>", "<button>","<canvas>", "<caption>", "<center>", "<cite>", "<code>", "<col>", "<colgroup>","<data>", "<datalist>", "<dd>", "<del>", "<details>", "<dfn>", "<dialog>", "<dir>", "<div>", "<dl>", "<dt>","<em>", "<embed>","<fieldset>", "<figcaption>", "<figure>", "<font>", "<footer>", "<form>", "<frame>", "<frameset>","<h1>", "<h2>", "<h3>", "<h4>", "<h5>", "<h6>", "<head>", "<header>", "<hr>", "<html>","<i>", "<iframe>", "<img>", "<input>", "<ins>", "<kbd>", "<keygen>", "<label>", "<legend>", "<li>", "<link>", "<listing>","<main>", "<map>", "<mark>", "<marquee>", "<menu>", "<menuitem>", "<meta>", "<meter>","<nav>", "<noframes>", "<noscript>", "<object>", "<ol>", "<optgroup>", "<option>", "<output>","<p>", "<param>", "<picture>", "<pre>", "<progress>","<q>","<rp>", "<rt>", "<ruby>","<s>", "<samp>", "<script>", "<section>", "<select>", "<small>", "<source>", "<span>", "<strike>", "<strong>", "<style>", "<sub>", "<summary>", "<sup>", "<svg>","<table>", "<tbody>", "<td>", "<template>", "<textarea>", "<tfoot>", "<th>", "<thead>", "<time>", "<title>", "<tr>", "<track>","<u>", "<ul>","<var>", "<video>","<wbr>", "<script", "<" }



local function isXss(inputString)
    local lowerInput = string.lower(inputString)
    for _, pattern in ipairs(patterns) do
        local escapedPattern = string.gsub(pattern, "([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1")
        if string.find(lowerInput, escapedPattern) then
            return true
        end
    end
    return false
end


AddEventHandler('playerConnecting', function(playerName, kickReason, deferrals)
    deferrals.defer()
    local hasXSS = isXss(playerName)
    
    if hasXSS then
        local message = string.format(" You aren't allowed to have that name sir.")
        deferrals.done(message)
    else
        deferrals.done()
    end
end)

