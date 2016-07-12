require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('pg')
require('pry')

DB = PG.connect({:dbname => "to_do_test"}) #set as "to_do" after testing

get('/') do
  erb(:index)
end

get('/lists/new') do
  erb(:list_form)
end

post('/lists') do
  name = params.fetch("name")
  lists = List.new({:name => name, :id => nil})
  list.save()
  erb(:list_success)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

get('/lists/:id') do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post('tasks') do
  description = params.fetch('description')
  list_id = params.fetch('list_id').to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:task_success)
end
