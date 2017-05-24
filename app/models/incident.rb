# == Schema Information
#
# Table name: incidents
#
#  id            :integer          not null, primary key
#  student_id    :integer
#  user_id       :integer
#  local         :integer
#  description   :text
#  date_incident :date
#  soluction     :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Incident < ApplicationRecord
  include SearchCop

  validates :student, :user, :local, :description, :date_incident, presence: true

  enum local: [:ifms, :ufms]

  belongs_to :student
  belongs_to :user

  # Delegates
  delegate :name, :to => :student, prefix: true

  # Atributos para busca com SearchCop
  search_scope :search do
    attributes :student => "student.name"
  end

  # Retorna um vetor com os atributos que serão utilizados para a
  # busca nas listagens de ocorrencias
  #
  # @return [Array] contendo os atributos para a busca
  def self.ordenation_attributes
    [["ID",'id'], ["Estudante",'student_name'], ["local",'local'], ["Data",'date_incident']]
  end
end
