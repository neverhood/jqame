#! /bin/bash

cd 'spec/dummy'
rm 'db/migrate/*'

rake 'jqame:install:migrations'

rake 'db:drop'
rake 'db:create'
rake 'db:migrate'

rake 'db:test:prepare'
