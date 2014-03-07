module ApplicationHelper

  def decorated_user
    @decorated_user ||=  current_user ? current_user.decorate : nil
  end

  def new_link_to(title, path, params = {})
    params[:class] = "btn btn-default"
    link_to path, params do
      content_tag(:i, '', :class => 'glyphicon glyphicon-plus') + ' ' + title
    end
  end
  def show_link_to(path, params = {})
    params[:title] = I18n.t('common.show')
    params[:class] = "btn btn-default"
    link_to path, params do
      content_tag(:i, '', :class => '') + ' ' + content_tag(:span, I18n.t('common.show'), :class => "visible-desktop" )
    end
  end

  def edit_link_to(path, params = {})
    params[:title] = I18n.t('common.edit')
    params[:class] = "btn btn-default"
    link_to path, params do
      content_tag(:i, '', :class => 'glyphicon glyphicon-edit', ) + ' ' + content_tag(:span, I18n.t('common.edit'), :class => "visible-desktop" )
    end
  end
  def back_link_to(path, params = {})
    link_to path, params do
      I18n.t('common.back')
    end
  end
  def destroy_link_to(path, params = {})
    default = {:method => :delete,
               :data  => { :confirm => I18n.t('common.are_you_sure') },
               :title => I18n.t('common.delete'),
               :class => "btn btn-danger"}
    new_params = default.merge params
    link_to path, new_params do
      content_tag(:i, '', :class => 'glyphicon glyphicon-remove') + ' ' + content_tag(:span, I18n.t('common.delete'), :class => "visible-desktop")
    end
  end
end
