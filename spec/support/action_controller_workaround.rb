if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5.0.0'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        if RUBY_VERSION >= '2.7.0'
          @mon_data = nil
          @mon_data_owner_object_id = nil
        else
          @mon_mutex = nil
          @mon_mutex_owner_object_id = nil
        end
        initialize
      end
    end
  end
end
