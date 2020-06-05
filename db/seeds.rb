# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Candidate.create([{email:'aaa@candidate.com', password:'12345678' },
                  {email:'bbb@candidate.com', password:'12345678' },
                  {email:'ccc@candidate.com', password:'12345678' },
                  {email:'ddd@candidate.com', password:'12345678' },
                  {email:'eee@candidate.com', password:'12345678' },
                  {email:'fff@candidate.com', password:'12345678' }])

Headhunter.create([{email:'aaa@headhunter.com', password:'12345678' },
                   {email:'bbb@headhunter.com', password:'12345678' },
                   {email:'ccc@headhunter.com', password:'12345678' },
                   {email:'ddd@headhunter.com', password:'12345678' },
                   {email:'eee@headhunter.com', password:'12345678' } ])

# Profile.create([{full_name:'aaa Silva', social_name: 'AAA',  birth_date: '11/08/1992', formation: 'ADS', description: 'Fatec-SP', experience: 'Nenhuma', candidate: Candidate.find(2)},
#                 {full_name:'bbb Silva', social_name: 'BBB',  birth_date: '17/12/1991', formation: 'ADS', description: 'Fatec-SP', experience: '1 ano', candidate: Candidate.find(1)},
#                 {full_name:'ccc Silva', social_name: 'CCC',  birth_date: '05/11/1996', formation: 'ADS', description: 'Fatec-SP', experience: '2 anos', candidate: Candidate.find(3)},
#                 {full_name:'ddd Silva', social_name: 'DDD',  birth_date: '29/05/1998', formation: 'ADS', description: 'Fatec-SP', experience: '3 anos', candidate: Candidate.find(4)},
#                 {full_name:'eee Silva', social_name: 'EEE',  birth_date: '27/02/1994', formation: 'ADS', description: 'Fatec-SP', experience: '4 anos', candidate: Candidate.find(5)}])

profile1 = Profile.new(full_name:'aaa Silva', social_name: 'AAA',  birth_date: '11/08/1992', formation: 'ADS', description: 'Fatec-SP', experience: 'Nenhuma', candidate: Candidate.find(2))
profile2 = Profile.new(full_name:'bbb Silva', social_name: 'BBB',  birth_date: '17/12/1991', formation: 'ADS', description: 'Fatec-SP', experience: '1 ano', candidate: Candidate.find(1))
profile3 = Profile.new(full_name:'ccc Silva', social_name: 'CCC',  birth_date: '05/11/1996', formation: 'ADS', description: 'Fatec-SP', experience: '2 anos', candidate: Candidate.find(3))
profile4 = Profile.new(full_name:'ddd Silva', social_name: 'DDD',  birth_date: '29/05/1998', formation: 'ADS', description: 'Fatec-SP', experience: '3 anos', candidate: Candidate.find(4))
profile5 = Profile.new(full_name:'eee Silva', social_name: 'EEE',  birth_date: '27/02/1994', formation: 'ADS', description: 'Fatec-SP', experience: '4 anos', candidate: Candidate.find(5))
profile1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg')), filename: 'perfil.jpg')
profile2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg')), filename: 'perfil.jpg')
profile3.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg')), filename: 'perfil.jpg')
profile4.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg')), filename: 'perfil.jpg')
profile5.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg')), filename: 'perfil.jpg')
profile1.save
profile2.save
profile3.save
profile4.save
profile5.save

Level.create([{name:'Estágio'},
              {name:'Junior'},
              {name:'Pleno'},
              {name:'Senior'},
              {name:'Diretor'}])

Vacancy.create([{title: 'Desenvolverdor Estagiário', job_description: 'Dev da squad', skills: 'nenhuma', salary: 1000, level: Level.find(1), registration_date: 10.days.from_now, address: 'Av. Paulista, 1234, SP', status: 0, headhunter: Headhunter.find(1) },
                 {title: 'Desenvolverdor Junior', job_description: 'Dev squad', skills: '1 ano de experiência', salary: 1600, level: Level.find(2), registration_date: 10.days.from_now, address: 'Av. Paulista, 1234, SP', status: 0, headhunter: Headhunter.find(2) },
                 {title: 'Desenvolverdor Pleno', job_description: 'Dev da squad', skills: '2 anos de experiência', salary: 2500, level: Level.find(3), registration_date: 10.days.from_now, address: 'Av. Paulista, 1234, SP', status: 0, headhunter: Headhunter.find(3) },
                 {title: 'Desenvolverdor Senior', job_description: 'Lider de squad', skills: '5 anos de experiência', salary: 4000, level: Level.find(4), registration_date: 10.days.from_now, address: 'Av. Paulista, 1234, SP', status: 5, headhunter: Headhunter.find(4) },
                 {title: 'Diretor', job_description: 'Administrar setor de T.I.', skills: '9 anos de experiência', salary: 7000, level: Level.find(5), registration_date: 10.days.from_now, address: 'Av. Paulista, 1234, SP', status: 5, headhunter: Headhunter.find(5) }])

ApplyVacancy.create([{ profile: Profile.find(1), vacancy: Vacancy.find(1), apply_message: 'Sou determinado e acredito que me encaixo no seu perfil' },
                     { profile: Profile.find(2), vacancy: Vacancy.find(2), apply_message: 'Sou determinado e acredito que me encaixo no seu perfil' },
                     { profile: Profile.find(3), vacancy: Vacancy.find(3), apply_message: 'Sou determinado e acredito que me encaixo no seu perfil' },
                     { profile: Profile.find(4), vacancy: Vacancy.find(1), apply_message: 'Sou determinado e acredito que me encaixo no seu perfil' },
                     { profile: Profile.find(5), vacancy: Vacancy.find(2), apply_message: 'Sou determinado e acredito que me encaixo no seu perfil' }])

Comment.create([{text: 'Perfil interessante', headhunter: Headhunter.find(2), profile: Profile.find(2)},
                {text: 'Perfil interessante', headhunter: Headhunter.find(3), profile: Profile.find(3)},])

StarProfile.create([{headhunter: Headhunter.find(2), profile: Profile.find(2)},
                    {headhunter: Headhunter.find(3), profile: Profile.find(3)}])

RejectApplyVacancy.create([{feedback: 'Não atende ao que foi pedido', headhunter: Headhunter.find(1), apply_vacancy: ApplyVacancy.find(4)},
                           {feedback: 'Não atende ao que foi pedido', headhunter: Headhunter.find(2), apply_vacancy: ApplyVacancy.find(5)}])

Proposal.create([{start_date: 5.days.from_now, apply_vacancy: ApplyVacancy.find(1), salary: 1000, benefits: 'VA e VR', job_functions: 'Treinamento e tarefas na descrição da vaga', headhunter: Headhunter.find(1)},
                 {start_date: 5.days.from_now, apply_vacancy: ApplyVacancy.find(2), salary: 1600, benefits: 'VA e VR', job_functions: 'Treinamento e tarefas na descrição da vaga', headhunter: Headhunter.find(2)}])
