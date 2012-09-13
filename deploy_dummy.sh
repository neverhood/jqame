#! /bin/bash

cd 'spec/dummy'
rm 'db/migrate/*' -r

rake 'jqame:install:migrations'

rake 'db:drop'
rake 'db:create'
rake 'db:migrate'

rake 'db:test:prepare'
