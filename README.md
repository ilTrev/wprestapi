# WP Rest API
Tinkering with the Wordpress REST API.

So far, the WpRestObject offers the following GET API methods:

####getAllPosts 
- retrieves all posts from the Web site

####getPostWithId
- Retrieves a specific post

####getLastPost
- Retrieves the most recent post

####getAllCategories
- Retrieves the list of the site's categories

####getCategoryWithId
- Retrieves a specific post category

####getAllTags
- Retrieves all tags from the blog at the base URL

Each of the API methods is attached to a delegate method (all delegate methods are optional):

####didReceivePostsArray
- Called when getAllPosts and getLastPost method end with success

####didReceivePost
- Called when getPostWithId method ends with success

####didReceiveCategoriesArray
- Called when getAllCategories method ends with success

####didReceiveCategory
- Called when getCategoryWithId method ends with success

####didReceiveTagsArray
-  Called when getAllTags method ends with success
