# MoodleRb

[![Build](https://github.com/jobready/moodle-rb/actions/workflows/build.yml/badge.svg)](https://github.com/jobready/moodle-rb/actions/workflows/build.yml)

[![Gem Version](https://badge.fury.io/rb/moodle_rb.svg)](https://badge.fury.io/rb/moodle_rb)

A Ruby Client for the Moodle REST API.

https://docs.moodle.org/dev/Web_services#Developer_documentation

## Usage

Initialise a MoodleRb client
```
moodle = MoodleRb.new(webservices_token, moodle_url)
```

Get site information
```
moodle.site_info
```

### Courses

Create a course
```
moodle.courses.create(
  :full_name => 'My Course',
  :short_name => 'MyC',
  :parent_category => 5,
  :idnumber => 'ExtRef',
  :startdate => 1646312400,
  :enddate => 1646398800
)
```

List all courses
```
moodle.courses.index
```

Search for a course by name
```
moodle.courses.search('My course')
```

Show a course
```
moodle.courses.show(course_id)
```

```
moodle.courses.show(course_ids) #Example: moodle.courses.show([1030, 679....])
```

Delete a course
```
moodle.courses.destroy(course_id)
```

Get course grades
```
moodle.courses.grade_items(course_id)
```

Get course contents
```
moodle.courses.contents(course_id)
```

Get course module
```
moodle.courses.module(course_module_id)
```

Import course data from a course into another course
```
moodle.courses.core_course_import_course(
  :from_course_id => from_course_id,
  :to_course_id => to_course_id
)
```

### Categories

Create a category
```
moodle.categories.create(
  :name => 'Test category'
)
```

List all categories
```
moodle.categories.index
```

Show a category
```
moodle.categories.show(category_id)
```

Delete a category
```
moodle.categories.destroy(category_id)
```

### Enrolments

Create a student enrolment
```
moodle.enrolments.create(
  :user_id => user_id,
  :course_id => course_id,
  :time_start => 1646312400,
  :time_end => 1646398800
)
```

Create a teacher enrolment
```
moodle.enrolments.create(
  :user_id => user_id,
  :course_id => course_id,
  :role_id => 3,
  :timestart=> 1646312400,
  :timeend=> 1646398800
)
```

Delete an enrolment
```
moodle.enrolments.destroy(
  :user_id => user_id,
  :course_id => course_id
)
```

View enrolled users by course
```
moodle.courses.enrolled_users(course_id)
```

View enrolled courses by user
```
moodle.users.enrolled_courses(user_id)
```

### Users

Create a user
```
moodle.users.create(
  :username => 'brucew',
  :password => 'password',
  :firstname => 'Bruce',
  :lastname => 'Wayne',
  :email => 'bruce@wayneenterprises.com'
)
```

Show a user
```
moodle.users.show(user_id)
```

Delete a user
```
moodle.users.destroy(user_id)
```

Search for a user
```
moodle.users.search(:email => 'admin@localhost')
```

Search for a user via identity
```
moodle.users.search_identity('admin@localhost')
```

Update a user
```
moodle.users.update(:id => 4, :email => 'bwayne@wayneenterprises.com')
```

## Development

To start development, spin up a container

```
docker build -t moodle .
```

To run the test suite with docker


```
docker run -v "$(pwd):/app" --rm moodle rspec spec
```

Docker compose

```
docker-compose build
docker-compose run app bundle exec rspec spec
```

## Tests

Tests must be written for new lines of code added as part of a pull request and the test suite must pass. If creating new cassettes, consider updating the hardcoded moodle token and url parameters throughout the suite. They can also be configured with environment variables.

You will need to set some environment variables to create new cassettes. We build using MAMP https://www.mamp.info/en/ so it might be

```
export MOODLE_URL=http://localhost:8888/moodle29/
export MOODLE_TOKEN=87b95af2df709fa60b395b5c59a3fc2e
```

## Deployment

The gem is automatically published when a new release is created on github. If there is an issue or a new release is required, please contact one of the maintainers

- Jordan Huizenga (jordan.huizenga@readytech.io)
