# Preview all emails at http://localhost:3000/rails/mailers/reindeer
class ReindeerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reindeer/pick
  def pick
    Reindeer.pick
  end

end
