# ModelFromTable

Rails generator for generating model from exsistent tables

- Automatically generate model files from existent tables
- Set table_name and primary_key if not following Rails conventions

## Usage

```
gem 'model_from_table'
```

```
$ bundle
```

```
$ rails generate model_from_table
```

## Example

if your existent tables is below

```sql
CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" varchar(255)
);

CREATE TABLE "company" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" varchar(255)
);

CREATE TABLE "legacy_table" (
  "code" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" varchar(255)
);
```

run command

```
$ rails generate model_from_table
```

then, these model files will be generated

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
end

# app/models/company.rb
class Company < ActiveRecord::Base
  self.table_name = "company"
end

# app/models/legacy_table.rb
class LegacyTable < ActiveRecord::Base
  self.table_name = "legacy_table"
  self.primary_key = "code"
end
```
