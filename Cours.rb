require "pry"

#greet
class User
  def greet
    puts "Bonjour, monde !"
  end
end #fin de ma classe

binding.pry
puts "end of file"


#say_hello_to_someone
class User
  def greet
    puts "Bonjour, monde !"
  end
  def say_hello_to_someone(first_name)
    puts "Bonjour, #{first_name} !"
  end
end

binding.pry
puts "end of file"

#show_itself
class User
  def show_itself
    print "Voici l'instance : "
    puts self
  end

end

binding.pry
puts "end of file"

#email
class User

  def update_email(email_to_update)
    @email = email_to_update
  end

  def read_email
    puts @email
  end

end

binding.pry
puts "end of file"

#attr_writer
class User
  attr_writer :mastercard #à mettre en en-tête de ta classe

  def read_mastercard
    return @mastercard
  end
end

binding.pry
puts "end of file"

#attr_reader
class User
  attr_reader :birthdate

  def update_birthdate(birthdate_to_update)
    @birthdate = birthdate_to_update
  end
end

binding.pry
puts "end of file"

#attr_accessor
class User
  attr_accessor :email
end

binding.pry
puts "end of file"

#initialize
class User
  attr_accessor :email

  def initialize(email_to_save)
    @email = email_to_save
    puts "Email : Bienvenue !!"
  end
end

#variable de classe
class User
  attr_accessor :email
  @@user_count = 0 # on initialise la variable de classe qui sera un compteur du nombre d'instance

  def initialize(email_to_save)
    @email = email_to_save
    @@user_count = @@user_count + 1 # un utilisateur vient d'être créé : on ajoute donc 1 au compteur
  end
end

#user_counter
class User
  attr_accessor :email
  @@user_count = 0 # on initialise la variable de classe qui sera un compteur du nombre d'instance

  def initialize(email_to_save)
    @email = email_to_save
    @@user_count = @@user_count + 1 # un utilisateur vient d'être créé : on ajoute donc 1 au compteur
  end

  def self.count
  	return @@user_count
  end
end

binding.pry
puts "end of file"

#illustration de private method
class User
  def truc_public
    # on peut faire julie.truc_public
  end

  private #Toutes les méthodes en dessous de cette balise seront privées. A mettre en bas donc !

  def truc_private
    # impossible de faire julie.truc_private
  end

end

############################################################################################################################################
#Voici 3 astuces pour expliquer la philosophie de l'objet :                                                                                #
#                                                                                                                                          #       
#    le Principe de Responsabilité Unique : une classe ne doit répondre qu'à une fonction et une fonction unique.                          #
#    Par exemple pour notre scrappeur fou de la semaine dernière, s'il constituait un seul et même programme,                              #
#    il aurait eu trois classes (et un fichier par classe) :                                                                               #
#        CryptoScrapper                                                                                                                    #
#        TownHallScrapper                                                                                                                  #
#        RepresentativeScrapper                                                                                                            #   
#        Voir même une classe Menu qui permet de lancer un petit menu dans le terminal et appelle,                                         #
#        en fonction de ce que l'utilisateur choisit de faire, une des 3 classes fonctionnelles ci-dessus pour scrapper quelque chose.     #
#    Les méthodes ne doivent pas faire plus de 10 lignes. L'objectif est d'avoir des méthodes simples, courtes, facilement compréhensibles.# 
#    Si tu dépasses, découpe-la en deux.                                                                                                   #
#    Pas plus de 4 paramètres en entrée d'une méthode. Si tu dépasses, découpe-la en deux.                                                 #
#                                                                                                                                          #        
#Si tu suis ces règles, tu devrais être un champion de la POO et n'avoir aucun soucis pour briller pendant un test technique.              #
############################################################################################################################################

#Tout ce qu'il faut savoir pour bien aborder une semaine d'orienté objet
class User
  attr_accessor :email, :encrypted_password
  @@user_count = 0

  def initialize(email_to_save)
    @email = email_to_save
    @@user_count = @@user_count + 1
  end

  def change_password(new_password)
    @encrypted_password = encrypt(new_password)
  end

  def show_itself
    puts self
  end

  def self.count
    return @@user_count
  end

  private

  def encrypt(string_to_encrypt)
    return "##ENCRYPTED##"
  end

end
#Recap du cours
Une classe se déclare avec class TaClasse.
Une instance correspond à un objet précis de ta classe (l'utilisatrice Julie pour ta classe User).

Les méthodes d'instances permettent d'exécuter des méthodes sur des instances de classe (la méthode change_password ci-dessus est une méthode d'instance).
Dans le code d'une méthode, il est possible d'appeler l'instance concernée par une méthode d'instance avec self.
Les variables d'instance ont un @ et concernent une instance précise de ta classe (@email est une variable d'instance).
Il est possible d'appeler et de modifier des variables d'instance grâce à attr_accessor.

Les méthodes de classe concernent la classe de manière globale (self.count est une méthode de classe car, 
	pour compter les instances de la classe User, nous voulons faire User.count et non pas julie.count qui n'aurait pas de sens).
Il est possible de modifier la méthode new et d'y ajouter du code grâce à initialize.
Il existe aussi des variables de classe qui concernent la classe de manière globale et qui s'écrivent avec @@.
On les définit après les attr_ (@@user_count est une variable de classe dans l'exemple ci-haut).

Enfin, définir des méthodes comme "privées" permet d'organiser ton code tout en évitant de pouvoir les appeler sur une instance, par exemple julie.ta_méthode_privée (.encrypt est une méthode privée, car je n'ai pas envie de faire julie.encrypt).

#Voici un exemple d'un fichier de tests
require_relative '../lib/user'

describe User do

  before(:each) do
  	# ligne trouvée ici : https://geminstallthat.wordpress.com/2008/08/11/reloading-classes-in-rspec/
  	# qui permet de remettre à zéro la classe. Pratique pour la méthode count, mais pas obligatoire.
    Object.send(:remove_const, 'User')
    load 'user.rb'
  end

	describe 'initializer' do

		it 'creates an user' do
      user = User.new("email@email.com")
      expect(user.class).to eq(User)
		end

		it 'saves @email as instance variable' do
			email = "email@email.com"
			user = User.new(email)
			expect(user.email).to eq(email)
		end

		it 'adds one to the @@count global variable' do
			count = User.count
			user = User.new("email@email.com")
			expect(User.count).to eq(count + 1)
		end
	end



	describe 'instance methods' do

		describe 'change_password' do
			it "changes password to ##ENCRYPTED##" do
				user = User.new("email@email.com")
				password = "some string"
				user.change_password(password)
				expect(user.password).to eq("##ENCRYPTED##")
			end
		end

		describe 'show_itself' do
			it "shows itself" do
				user = User.new("email@email.com")
				user.show_itself
				expect do
					user.show_itself
				end.to output("#{user}\n").to_stdout
				# OK celle là est super hard, mais en même temps c'est pas des méthodes que l'on utilise souvent. Solution trouvée ici : https://stackoverflow.com/a/38377720
			end
		end

	end

	describe 'instance variables' do

		describe '@email' do

			it 'can be read' do 
				email = "email@email.com"
				user = User.new(email)
				expect(user.email).to eq(email)
			end

			it 'can be written' do 
				email = "email@email.com"
				user = User.new(email)
				email_2 = "email_2@email.com"
				user.email = email_2
				expect(user.email).not_to eq(email)
				expect(user.email).to eq(email_2)
			end

		end

	end

	describe 'class methods' do

		describe 'self.count' do
			it 'shows the number of users' do 
				user_1 = User.new("email1@email.com")
				user_2 = User.new("email2@email.com")
				user_3 = User.new("email3@email.com")
				expect(User.count).to eq(3)
			end
		end

	end

end