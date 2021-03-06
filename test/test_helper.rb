$: << File.expand_path(File.dirname(__FILE__), "../lib")

require "minitest/autorun"
require "minitest/pride"
require "tempfile"
require "firma"

def sample_pdf_file
  sample_path = "test/fixtures/sample_pdf.pdf"
  file = Tempfile.new(["tempfile", ".pdf"]) << File.open(sample_path).read

  file.path
end

def sample_signed_pdf_file
  "test/fixtures/signed_pdf.pdf"
end

def sample_key
  "test/fixtures/sample.key"
end

def sample_certificate
  "test/fixtures/sample.crt"
end
