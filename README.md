# README

### Project

#### What have we done?
- Implemented most of the requirements, the biggest missing is the API. I ran out of time, but would have used the gem Devise-api to implement a api with user auth, and tokens going forward.
##### Models
- Created the required Models: ProjectManager, Employee, Task, Project
- Created a few additional models: Ability, Organization, User
- Why the additional? I wanted to use Devise for login authentication, and I've found devise to be easiest to work with if we have a standard login class, in this case, User. Ability is our defined abilities via cancancan. Organization is an easy way to keep users and projects grouped, and to prevent other users outside the org from accessing them.
- What did I do with the ProjectManager and Employee classes then? I used them as "roles" on the User class. User has a polymorphic association with role, and the values and types could be either ProjectManager or Employee. I then added two quick methods on User to differenciate employees and managers. We have the generic fields of name, email, and password on User, and then keep what was asked on the other classes. If I were to make a change there, I'd remove name from both ProjectManager and Employee classes, so that it just lives on the User class. I did consider Employee.name to be a nickname field.
- Task is a bit of a complicated class, mainly for the addition on a subclass of statuses, and some relations, validations, and scopes. All is fairly straight-forward though.

##### Interactions
- Interactions are where I like to keep business logic. The best example of this is in ```Interactions::Tasks::ChangeStatus```. There are certain statuses that a PM and an employee can set. This interaction allows you to pass in the task, status, and change_user, and it handles all the validations necessary to only change the task status as needed. Interactions live in ```models/interactions```
- I also like to have create and updates as interactions for various models. It keeps controllers tidy, and also allows for type validation on inputs.
- For more info on active interactions, see https://github.com/AaronLasseigne/active_interaction

##### Controllers
- I implemented as much as I could in the time I had. I would have ideally implemented more show and index pages, as well as edit and updates, but I ran out of time. 
- The UsersController needed some massaging in order to add new users inside the app and not connected to Devise. I ideally would have come up with a better solution, but this one isn't bad, and get's the job done. See ```update_user``` and ```create_new``` methods and routes. There is a collision with Devise routers on update and create, so I neeed to get around them.

##### Views
- Let's be honest, these are quick and dirty, but work decently well.
- There are some extra ones laying around that I ran out of time to cleanup.

##### Specs
- I'm using Rspec here.
- Not fully tested, but the more logic heavy ones (looking at your ```Interactions::Tasks::ChangeStatus```) are a good example of the types of tests I write (spec in ```spec/interactions/tasks/change_status_spec.rb```)

##### Job
- I did create the ```mark_tasks_late_job```, but did not hook it up to sidekiq as I ran out of time. Ideally, I would have it on a cron to run each morning. 

##### Comments
- Starting a Rails app from scratch takes quite a bit of time if you haven't done it in a while.
- If I were making a production ready app, I would use either MySql or Postgres, instead of sqlite
- I wish I had gotten to the API portion. Using interactions in controllers makes it pretty easy to get the actions to be identical. I just didn't have time to dig in and get the devise api credentials and everything going, so stuck to the UI.

##### To run
- This is a ruby 3.2.2 and Rails 7 application, so make sure each is installed.
- Should be able to bundle install and get everything installed.
- ```rails db:create && rails db:migrate```
- ```bin/dev``` is what I use to run it.