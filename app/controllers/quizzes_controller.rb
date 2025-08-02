class QuizzesController < ApplicationController
  before_action :require_login
  before_action :set_quiz, only: %i[show edit update destroy]

  def index
    @quizzes = current_user.quizzes
  end

  def new
    question_count = params[:question_count].to_i
    question_count = 1 if question_count < 1
    question_count = 10 if question_count > 10

    @quiz = current_user.quizzes.build

    question_count.times do
        question = @quiz.questions.build
        4.times { question.options.build }
    end
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)
    if @quiz.save
      redirect_to quizzes_path, notice: "Quiz created!"
    else
      render :new
    end
  end

  def edit
    @quiz = current_user.quizzes.find(params[:id])
  end

  def update
    @quiz = current_user.quizzes.find(params[:id])
    if @quiz.update(quiz_params)
        redirect_to quizzes_path, notice: "Quiz updated successfully!"
    else
        render :edit
    end
  end

  def destroy
    @quiz.destroy
    redirect_to quizzes_path, notice: "Quiz deleted!"
  end

  def show
    @quiz = Quiz.find(params[:id])
  end


  private

  def set_quiz
    @quiz = current_user.quizzes.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:title, :description,
    questions_attributes: [:id, :content, :_destroy,
      options_attributes: [:id, :content, :correct, :_destroy]])
  end
end
