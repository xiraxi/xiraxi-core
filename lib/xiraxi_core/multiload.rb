
module ActiveSupport::Dependencies

  PathFoundForFiles = {}

  def search_for_file_with_dogmatix(path_suffix)
    path = search_for_file_without_dogmatix(path_suffix)
    PathFoundForFiles[path] = path_suffix if path
    path
  end

  def require_or_load_with_dogmatix(file_name)
    object = require_or_load_without_dogmatix file_name

    if path_suffix = PathFoundForFiles.delete(file_name)
      path_suffix = path_suffix + '.rb' unless path_suffix.ends_with? '.rb'
      autoload_paths.reverse.each do |root|
        path = File.join(root, path_suffix)
        next if path == file_name
        require_or_load_without_dogmatix(path) if File.file?(path)
      end
    end

    object
  end

  alias_method_chain :require_or_load, :dogmatix
  alias_method_chain :search_for_file, :dogmatix

end
