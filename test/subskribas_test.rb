require_relative "test_helper"

describe Subskribas do
  before do
    @pdf_file = sample_pdf_file
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

end
