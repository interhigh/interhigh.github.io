---
layout: post
title: "歡迎來到 Interhigh ！"
date:   2014-08-18 22:16:11
name: welcometointerhigh
categories: ['zh-CHT']
---
{% assign posts=site.posts | where:"name", page.name | sort: 'path' %}
<ul>
{% for post in posts %}
    <li class="lang">
        <a href="{{ post.url }}" class="{{ post.lang }}">{{ post.lang }}</a>
    </li>
{% endfor %}
</ul>

[translate]: #start
這是一篇博客文章示例。

[translate]: #end

