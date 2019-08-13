module ApplicationHelper
  def link_to_add_field name, form, association, **args
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |b|
      render(association.to_s.singularize + "_fields", f: b)
    end

    link_to(name, "#", class: "btn btn-default" + " " + args[:class],
      data: {id: id, fields: "'#{fields}'"})
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def show_correct_answers test_answer
    Answer.where(id: test_answer.correct_answer.split(',')
      .map(&:to_i)).pluck :content
  end

  def stack_bar_filter_options
    {this_year: 0, this_month: 1}.map do |k, v|
      [k = k.to_s.humanize, v]
    end
  end
end
