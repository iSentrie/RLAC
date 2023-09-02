local patterns = {}
local default = {"<!DOCTYPE>","<html>","<head>","<title>","<meta>","<link>","<style>","<script>","<body>","<h1>","<h2>","<h3>","<h4>","<h5>","<h6>","<p>","<a>","<img>","<ul>","<li>","<ol>","<dl>","<dt>","<dd>","<blockquote>","<div>","<span>","<table>","<tr>","<th>","<td>","<form>","<input>","<button>","<textarea>","<select>","<label>","<iframe>","<audio>","<video>","<canvas>","<svg>","<header>","<nav>","<main>","<article>","<section>","<aside>","<footer>","<time>","<mark>","<abbr>","<code>","<pre>","<hr>","<br>"}

PerformHttpRequest('https://raw.githubusercontent.com/Endpoints1337/RLAC/main/Anti-XSS/check.json', function(statusCode, response, headers)
    if statusCode == 200 then
        patterns = json.decode(response)
    else
        print("Using default one cuz.")
        patterns = default
    end
end, 'GET')

local function isXss(inputString)
    for _, pattern in ipairs(patterns) do
        if string.match(inputString, pattern) then
            return true
        end
    end
    return false
end

AddEventHandler('playerConnecting', function(playerName, kickReason, deferrals)
    deferrals.defer()
    local hasXSS = isXss(playerName)
    
    if hasXSS then
        deferrals.done("You Are Using XSS")
    else
        deferrals.done()
    end
end)
