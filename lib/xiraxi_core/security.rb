
require 'openssl'
require 'md5'

class XiraxiCore::Security

  attr_reader :aes_iv, :aes_key, :hmac_key

  mattr_accessor :keys_files
  self.keys_files = Rails.root.join("tmp/keys")

  class <<self
    def load
      instance = new
      if File.exist?(keys_files)
        instance.load_keys! keys_files
      else
        instance.random_keys!
      end
      instance
    end

    def encrypt(data)
      load.encrypt(data)
    end

    def decrypt(data)
      load.decrypt(data)
    end
  end

  def initialize(pathname = nil)
    if pathname
      load_keys! pathname
    end
  end

  def random_keys!
    cipher = OpenSSL::Cipher::Cipher.new(CipherAlgo)

    @aes_key = cipher.random_key
    @aes_iv = cipher.random_iv
    @hmac_key = MD5.new(File.read("/dev/urandom", 100)).hexdigest
    self
  end

  def load_keys!(pathname)
    source = YAML.load(File.read(pathname))
    @aes_key = source["aes_key"]
    @aes_iv = source["aes_iv"]
    @hmac_key = source["hmac_key"]
    true
  end

  def save_keys(pathname = self.class.keys_files)
    File.open(pathname, "w") do |f|
      f.write({
        "aes_key" => @aes_key,
        "aes_iv" => @aes_iv,
        "hmac_key" => @hmac_key
      }.to_yaml)
    end
  end

  CipherAlgo = 'AES-256-CBC'
  def encrypt(data)
    cipher = OpenSSL::Cipher::Cipher.new(CipherAlgo)
    cipher.encrypt
    cipher.key = aes_key
    cipher.iv = aes_iv

    content = Base64.encode64(cipher.update(Marshal.dump(data)) + cipher.final).gsub(/\s/, '')
    content + "--" + generate_digest(content)
  end

  def decrypt(data)
    return unless data.kind_of?(String) and data.include?("--")

    content, digest = data.split("--")
    return if digest != generate_digest(content)

    cipher = OpenSSL::Cipher::Cipher.new(CipherAlgo)
    cipher.decrypt
    cipher.key = aes_key
    cipher.iv = aes_iv
    Marshal.load(cipher.update(Base64.decode64(content)) + cipher.final)
  end

  def generate_digest(data)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('SHA1'), hmac_key, data)
  end

end
