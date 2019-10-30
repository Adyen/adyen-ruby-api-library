# This utility method monkey-patches Ruby's Hash class to allow keys to be read
# and updated with dot notation. Usage is entirely optional (i.e.,  hash values
# can still be accessed via symbol and string keys.
#
# Credit: https://gist.github.com/winfred/2185384#file-ruby-dot-hash-access-rb

class Hash
  class NoKeyOrMethodError < NoMethodError; end
  def method_missing(method,*args)
    m = method.to_s
    string_key = m.gsub(/=$/,'')
    sym_key = string_key.to_sym
    if self.has_key? string_key
      m.match(/=$/) ? self.send("[#{string_key}]=", *args) : self[string_key]
    elsif self.has_key? sym_key
      m.match(/=$/) ? self.send("[#{sym_key}]=", *args) : self[sym_key]
    else
      raise NoKeyOrMethodError
    end
  end
end
