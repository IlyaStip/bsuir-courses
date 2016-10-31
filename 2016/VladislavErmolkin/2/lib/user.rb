require 'json'

class User
  attr_accessor :id, :sem_phase, :sem_start, :sem_end, :sem_process_now, :subjects

  def initialize(id)
  	@id = id
  	path = "./users/user_#{@id}.txt"
    file = File.open(path, 'a+')
    if File.zero?(path)
    	fill_attrs({})
    else
    	fill_attrs JSON.parse(file.read)
    end
    file.close
  end

  def fill_attrs(params)
  	@sem_start = params.fetch("sem_start", nil)
    @sem_end = params.fetch("sem_end", nil)
    @sem_process_now = params.fetch("sem_process_now", false)
    @sem_phase = params.fetch("sem_phase", 0)
    @subjects = params.fetch("subjects", nil)
  end

  def save
    puts 'IN SAVE_USER.'
    path = "./users/user_#{@id}.txt"
    file = File.open(path, 'w')
    file.print JSON.generate itself.to_hash
    file.close
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end


# user = User.new ({:sem_start => '1.1.1', :sem_end => '1.1.2', :subjects => ['math', 'english']})

# p user.sem_start, user.sem_end, user.subjects

