# zipcode-db

Unified interface to query international zip/postal codes

[![Build Status](https://travis-ci.org/lloeki/zipcode-db.svg?branch=master)](https://travis-ci.org/lloeki/zipcode-db)

## Usage

```ruby
require 'zipcode-db'
require 'zipcode-fr'                 # load data source per country
require 'zipcode-de'

# load data banks individually, typically builds memory-backed global index
ZipCode::FR.load
ZipCode::DE.load

ZipCode::DB.for(:fr).search(:zip, '50000')     # exact zip code search
ZipCode::DB.for(:fr).search(:zip, '50')        # prefixes work
ZipCode::DB.for(:fr).search(:name, 'PARIS')    # search by name
ZipCode::DB.for(:fr).search(:name, 'BORD')     # prefixes work
ZipCode::DB.for(:fr).search(:name, 'MARIE')    # prefixes work on inner words
ZipCode::DB.for(:de).search(:name, 'BERLIN')   # another country
```

Main fields are:

- `:name`: normalised name without diacritics nor symbols
- `:zip`: zip code, as used by postal service

Extra fields can be provided depending on data source. See the correspondig
gem documentation.

## Extending data

Defining a new database is as simple as creating a class defining a search
method complying with expectations, and registering it as a country:

```ruby
require 'zipcode-db'

class MyZipCodeData
  def search(key, value)
    return [{name: 'foo', zip: '42']
  end
end

ZipCode::DB.register(:mine, MyZipCodeData)
```

The storage, indexing and search itself is delegated to each class.

## License

MIT
