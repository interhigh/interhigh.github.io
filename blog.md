---
layout: page
title: Blog
permalink: /blog/
---

English:

  <ul class="post-list">
    {% assign en_posts=site.posts | where:"lang", "en" %}
    {% for post in en_posts %}
      <li>
        <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>

        <h2>
          <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
        </h2>
      </li>
    {% endfor %}
  </ul>

Korean:

  <ul class="post-list">
    {% assign ko_posts=site.posts | where:"lang", "ko" %}
    {% for post in ko_posts %}
      <li>
        <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>

        <h2>
          <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
        </h2>
      </li>
    {% endfor %}
  </ul>


  <p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | prepend: site.baseurl }}">via RSS</a></p>
