include ActionDispatch::TestProcess

user = User.create({username: 'sal', password: '1',})
100.times do |n|
  type = rand(0..1)
      if type == 1
        App.create(
            {
                name: "App #{n}",
                image: File.new(File.join(Rails.root, 'spec', 'fixtures', 'images', 'commands.png')),
                app_type: 1,
                user_id: user.id
            }
        )
      else
        App.create(
            {
                name: "App #{n}",
                image: File.new(File.join(Rails.root, 'spec', 'fixtures', 'images', 'shortcuts.png')),
                app_type: 0,
                user_id: user.id
            }
        )
      end
end
