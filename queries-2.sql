with 
	posts_with_tags as (
		select distinct
			authors.id as author_id,
			authors.first_name,
			authors.last_name,
			posts.title,
			posts.id as post_id
		from posts
			left join post_tag on posts.id = post_tag.post_id
			left join authors on authors.id = posts.author_id
),
	author_with_most_posts as (
		select author_id, count(author_id) as most_posts
		from posts_with_tags
		group by posts_with_tags.author_id
		order by most_posts desc
		limit 1
)
select first_name, last_name, most_posts, array_agg(title)
from (	
	select 
		authors.first_name,
		authors.last_name,
		most_posts,
		posts.title
	from author_with_most_posts
		left join posts on author_with_most_posts.author_id = posts.author_id
		left join authors on authors.id = author_with_most_posts.author_id
)
group by first_name, last_name, most_posts

