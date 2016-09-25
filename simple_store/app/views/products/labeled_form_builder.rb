class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field datetime_select check_box].each do |method_name|
    define_method(method_name) do |name, *args|
      @template.content_tag :div, class: "field" do
        label(name) + @template.tag(:br) + super(name, *args)
      end
    end
  end

end
