class Macchiato.Collections.Posts extends Backbone.Collection
  url: "/api/posts"

class Macchiato.Collections.SearchPosts extends Backbone.Collection
  url: "/api/posts/search"

class Macchiato.Collections.SearchDeletedPosts extends Backbone.Collection 
  url: "/api/posts/search_deleted"

class Macchiato.Collections.SearchPublishedPosts extends Backbone.Collection 
  url: "/api/posts/search_published"

class Macchiato.Collections.SearchUnpublishedPosts extends Backbone.Collection
  url: "/api/posts/search_unpublished"
  
class Macchiato.Collections.UnpublishedPosts extends Backbone.Collection
  url: "/api/posts/unpublished"
  
class Macchiato.Collections.PublishedPosts extends Backbone.Collection
  url: "/api/posts/published"
  
class Macchiato.Collections.DeletedPosts extends Backbone.Collection
  url: "/api/posts/deleted"