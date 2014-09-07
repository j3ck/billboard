set :output, "#{path}/log/cron.log"
set :environment, 'development'

every 10.minutes do
  runner 'Advert.to_archive_old_adverts'
end

every 1.day, at: '00:00 am' do
  runner 'Image.destroy_images_a_without_advert_id'
end
