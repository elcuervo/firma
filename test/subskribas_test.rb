require_relative "test_helper"

describe Subskribas do
  before do
    @pdf_file = sample_pdf_file
  end

  it "should validate if a pdf is signed" do
    assert !Subskribas.is_signed?(@pdf_file)
    assert Subskribas.is_signed?(sample_signed_pdf_file)
  end

  it "should sign a pdf file with a given keys" do
    assert !Subskribas.is_signed?(@pdf_file)

    Subskribas.sign(@pdf_file,
      key: sample_key,
      passphrase: "passphrase",
      certificate: sample_certificate
    )

    assert Subskribas.is_signed?(@pdf_file)
  end

  it "should sign a pdf with a generated keys" do
    assert !Subskribas.is_signed?(@pdf_file)

    keys = Subskribas.generate_keys("passphrase")

    Subskribas.sign(@pdf_file,
      key: keys.fetch(:key).path,
      passphrase: "passphrase",
      certificate: keys.fetch(:certificate)
    )

    assert Subskribas.is_signed?(@pdf_file)
  end
end
