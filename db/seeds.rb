puts 'EMPTY THE MONGODB DATABASE!'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create!(
  first_name: "Johnny",
  last_name: "Grim",
  username: "grimmy",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
)
puts 'New user created: ' << user.username
puts "Login with #{user.email} and #{user.password}"

puts 'SETTING UP SAMPLE POSTS'
post = Post.create!(
  user: user,
  title: "Welcome to Macchiato",
  text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  tags: ["macchiato", "introduction", "news"],
  published: true
)
puts 'New post created: ' << post.title

post = Post.create!(
  user: user,
  title: "How to Publish a Post",
  text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  tags: ["macchiato", "help"],
  published: true
)
puts 'New post created: ' << post.title

post = Post.create!(
  user: user,
  title: "How to Unpublished a Post",
  text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  tags: ["macchiato", "help"],
  published: false
)
puts 'New post created and unpublished: ' << post.title

post = Post.create!(
  user: user,
  title: "How to Delete a Post",
  text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  tags: ["macchiato", "help"],
  published: false
)
puts 'New post created and unpublished: ' << post.title
post.delete
puts 'Post deleted: ' << post.title

post = Post.create!(
  user: user,
  title: "How to Restore a Post",
  text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  tags: ["macchiator", "help"],
  published: true
)
puts 'New post created: ' << post.title
post.delete
puts 'Post deleted: ' << post.title
