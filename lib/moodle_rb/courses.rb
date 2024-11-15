module MoodleRb
  class Courses
    include HTTParty
    include Utility

    attr_reader :token, :query_options

    def initialize(token, url, query_options)
      @token = token
      @query_options = query_options
      self.class.base_uri url
    end

    def index
      response = self.class.get(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_get_courses', token)
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response
    end

    # Search courses by (name, module, block, tag)
    def search(criteria_value, criteria_name = 'search')
      response = self.class.get(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_search_courses', token).merge({
            :criterianame => criteria_name,
            :criteriavalue => criteria_value
          })
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response
    end

    # required params:
    # full_name
    # short_name
    #   must be unique
    # parent_category
    #   the parent category id inside which the new category will be created
    # optional params:
    # idnumber
    #     the new course external reference. must be unique
    def create(params)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_create_courses', token),
          :body => {
            :courses => {
              '0' => {
                :fullname => params[:full_name],
                :shortname => params[:short_name],
                :categoryid => params[:parent_category],
                :idnumber => params[:idnumber],
                :startdate => params[:start_date],
                :enddate => params[:end_date]
              }.select {|k, v| v }
            }
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response.first
    end

    def show(*id)
      ids = id.map.with_index do |item, idx|
        [idx.to_s, item]
      end.to_h

      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_get_courses', token),
          :body => {
            :options => {
              ids: ids
            }
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      id.count > 1 ? response.parsed_response : response.parsed_response.first
    end

    def destroy(id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_delete_courses', token),
          :body => {
            :courseids => {
              '0' => id
            }
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response
    end

    def enrolled_users(course_id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_enrol_get_enrolled_users', token),
          :body => {
            :courseid => course_id
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response
    end

    def grade_items(course_id, user_id=0, group_id=0)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('gradereport_user_get_grade_items', token),
          :body => {
            :courseid => course_id,
            :userid => user_id,
            :groupid => group_id
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response['usergrades']
    end

    def contents(course_id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_get_contents', token),
          :body => {
            :courseid => course_id
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response
    end

    def module(course_module_id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_get_course_module', token),
          :body => {
            :cmid => course_module_id
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response['cm']
    end

    # required params:
    # from_course_id: the id of the course we are importing from
    # to_course_id:   the id of the course we are importing to
    def core_course_import_course(params)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_import_course', token),
          :body => {
            :importfrom => params[:from_course_id],
            :importto => params[:to_course_id]
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.code == 200 && response.parsed_response.nil?
    end
  end
end
