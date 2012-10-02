require_relative "test_helper"

describe Firma do
  before do
    @pdf_file = sample_pdf_file
  end

  it "should validate if a pdf is signed" do
    assert !Firma.is_signed?(@pdf_file)
    assert Firma.is_signed?(sample_signed_pdf_file)
  end

  it "should sign a pdf file with a given keys" do
    assert !Firma.is_signed?(@pdf_file)

    Firma.sign(@pdf_file,
      key: sample_key,
      passphrase: "passphrase",
      certificate: sample_certificate
    )

    assert Firma.is_signed?(@pdf_file)
  end

  it "should sign a pdf with a generated keys" do
    assert !Firma.is_signed?(@pdf_file)

    keys = Firma.generate_keys("passphrase")

    Firma.sign(@pdf_file,
      key: keys.fetch(:key),
      passphrase: "passphrase",
      certificate: keys.fetch(:certificate)
    )

    assert Firma.is_signed?(@pdf_file)
  end
end
