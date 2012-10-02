require "openssl"
require "tempfile"
require "origami"

class Subskribas < Struct.new(:file)
  def create_certificate_from_key(key)
    name = "CN=ruby/DC=subskribas"
    certificate = OpenSSL::X509::Certificate.new

    certificate.version     = options.fetch(:version, 2)
    certificate.serial      = options.fetch(:serial, 0)
    certificate.not_before  = options.fetch(:not_before, Time.now)
    certificate.not_after   = options.fetch(:not_after, Time.now + 3600)
    certificate.public_key  = key.public_key
    certificate.subject     = OpenSSL::X509::Name.parse(name)
    certificate
  end

  def create_temp_file(name, content)
    Tempfile.new(name) { |file| file.write content }
  end

  def generate_keys(passphrase)
    rsa_key = OpenSSL::PKey::RSA.new(2048)

    key = create_temp_file(["key", ".pem"], rsa_key.to_pem)

    public_key = create_temp_file(
      ["public_key", ".pem"],
      rsa_key.public_key.to_pem
    )

    cipher = OpenSSL::Cipher::Cipher.new("AES-128-CBC")
    secure_key = key.export(cipher, passphrase)

    private_key = create_temp_file(["private_key", ".pem"], secure_key)

    {
      key:          key,
      public_key:   public_key,
      private_key:  private_key,
      certificate:  certificate
    }
  end

  def sign(options)
    key = OpenSSL::PKey::RSA.new(
      File.open(options.fetch(:key)),
      options.fetch(:passphrase)
    )

    certificate = OpenSSL::X509::Certificate.new(
      File.open(options.fetch(:certificate))
    )

    pdf = Origami::PDF.read(file)

    pdf.sign(certificate, key)
    pdf.save(file)
  end

  def is_signed?
    Origami::PDF.read(file).is_signed?
  end

  class << self
    def is_signed?(file)
      new(file).is_signed?
    end

    def sign(file, options = {})
      new(file).sign(options)
    end
  end
end
