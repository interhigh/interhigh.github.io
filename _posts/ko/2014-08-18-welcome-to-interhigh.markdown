---
layout: post
title:  "Welcome to Interhigh! (Korean)"
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
This is an example of a Korean post.

[translate]: #end
