require 'parslet'
require 'parslet/convenience' # parse_with_debug

Parser = import('scheduled-format/parser/parser')
Transformer = import('scheduled-format/parser/transformer')
TaskList = import('scheduled-format/task_list')

# {include:file:doc/formats/scheduled.md}
# The entry point method for parsing this format.
#
# @param string [String] string in the scheduled task list format
# @return [TaskList, nil]
#
# @example
#   scheduled_format = import('scheduled-format')
#
#   task_list = scheduled_format.parse <<-EOF.gsub(/^\s*/, '')
#     Tomorrow
#     - Buy milk. #errands
#     - [9:20] Call with Mike.
#
#     Prague
#     - Pick up my shoes. #errands
#   EOF
# @since 0.2
def exports.parse(string_or_io)
  string = string_or_io.respond_to?(:read) ? string_or_io.read : string_or_io
  tree = Parser.new.parse_with_debug(string)
  nodes = Transformer.new.apply(tree)
  TaskList.new(nodes.empty? ? Array.new : nodes)
end

export task: import('scheduled-format/task'),
       task_list: TaskList,
       task_group: import('scheduled-format/task_group')
