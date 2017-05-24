# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string
#  course_id  :integer
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ApplicationRecord
  mount_uploader :photo, StudentUploader
  include SearchCop

  delegate :name, to: :course, prefix: true
  delegate :initial, to: :course, prefix: true

  # Validações
  validates :name, :course, presence: true

  # Associações
  belongs_to :course

  # Atributos para busca com SearchCop
  search_scope :search do
    attributes :name
    attributes :course => "course.name"
  end

  # Retorna um vetor contendo os nomes e seus respectivos IDs
  #
  # @return [Array] contendo nomes e seus IDs
  def self.get_all
    order('name asc').collect {|p| [ p.name, p.id ] }
  end

  # Retorna um vetor com os atributos que serão utilizados para a
  # busca nas listagens dos estudantes
  #
  # @return [Array] contendo os atributos para a busca
  def self.ordenation_attributes
    [["ID",'id'], ["Nome",'name']]
  end
end
