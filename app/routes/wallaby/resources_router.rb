class Wallaby::ResourcesRouter
  def call env
    params            = env['action_dispatch.request.path_parameters']
    target_controller = find_controller params[:resources]
    target_action     = params[:action]
    target_controller.action(target_action).call env
  rescue AbstractController::ActionNotFound
    target_controller.action(:not_found).call env
  end

  protected
  def find_controller resources_name
    Wallaby::ResourcesController.subclasses.find do |klass|
      klass.resources_name == resources_name
    end or Wallaby::ResourcesController
  end
end
