#! /bin/bash

cd 'spec/dummy'

rake 'jqame:install:migrations'

rake 'db:drop'
rake 'db:create'
rake 'db:migrate'

rake 'db:test:prepare'
