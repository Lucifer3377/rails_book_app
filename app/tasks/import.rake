require 'csv'
namespace :import do
    desc "Import users from csv"
    task users: :environment do
        filename = File.join Rails.root, "users.csv"
        CSV.foreach(filename, headers: true) do |row|
            p row
        end
    end
end