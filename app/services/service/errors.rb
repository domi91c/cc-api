module Service
  class NotImplementedError < ::StandardError;
  end

  class Errors < Hash
    def add(key, value, _opts = {})
      self[key] ||= []
      self[key] << value
      self[key].uniq!
    end

    def add_multiple_errors(errors_hash)
      errors_hash.each do |key, values|
        values.each { |value| add key, value }
      end
    end

    def full_messages
      map { |attribute, message| full_message(attribute, message) }
    end

    private

    def full_message(attribute, message)
      attr_name = attribute.to_s.tr('.', '_').capitalize
      if message.size > 1
        str = ''
        message.each do |m|
          str.join("%s%s \n" % [attr_name, m])
        end
      else
        str = "%s" % [message.first]
      end

      str

    end
  end
end
