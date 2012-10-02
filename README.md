# Firma
![](http://www.duhaime.org/Portals/duhaime/images/Copperman-signature.jpg)

Add a secure signature to a pdf file.

## Check if a pdf it's signed

```ruby
  require "firma"

  Firma.is_signed?("my_file.pdf")
```

## Sign a pdf file

```ruby
  require "firma"

  Firma.sign("my_file.pdf",
    key: "key.pem",
    passphrase: "passphrase",
    certificate: "key.crt"
  )
```

## Sign a pdf file with newly generated certificates

```ruby
  require "firma"

  keys = Firma.generate_keys("passphrase")

  Firma.sign("my_file.pdf",
    key: keys.fetch(:key).path,
    passphrase: "passphrase",
    certificate: keys.fetch(:certificate)
  )
```
