---
layout: post
title: "오신 것을 환영 합니다 Interhigh!"
date:   2014-08-18 22:16:11
name: welcometointerhigh
categories: ['ko']
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
이 블로그 게시물의 예입니다.



[translate]: #end

