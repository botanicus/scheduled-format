# frozen_string_literal: true

class TaskList
  include Enumerable

  # List of {TaskGroup task groups}. Or more precisely objects responding to `#header` and `#tasks`.
  # @since 0.2
  attr_reader :data

  # @param [Array<TaskGroup>] data List of task groups.
  #   Or more precisely objects responding to `#header` and `#tasks`.
  # @raise [ArgumentError] if data is not an array or if its content doesn't
  #   respond to `#header` and `#tasks`.
  #
  # @example
  #   TaskGroup, TaskList = import('scheduled-format').grab(:TaskGroup, :TaskList)
  #
  #   tasks = ['Buy milk. #errands', '[9:20] Call with Mike.']
  #   group = TaskGroup.new(header: 'Tomorrow', tasks: tasks)
  #   list  = TaskList.new([group])
  # @since 0.2
  def initialize(data)
    @data = data

    unless data.is_a?(Array) && data.all? { |item| item.respond_to?(:header) && item.respond_to?(:tasks) }
      raise ArgumentError.new("Data is supposed to be an array of TaskGroup instances.")
    end
  end

  # Find a task group that matches given header.
  #
  # @return [TaskGroup, nil] matching the header.
  # @since 0.2
  #
  # @example
  #   # Using the code from the initialiser.
  #   list['Tomorrow']
  def [](header)
    @data.find do |task_group|
      task_group.header == header
    end
  end

  # Add a task group onto the task list.
  #
  # @raise [ArgumentError] if the task group is already in the list.
  # @param [TaskGroup] task_group the task group.
  # @since 0.2
  def <<(task_group)
    unless task_group.is_a?(TaskGroup)
      raise ArgumentError.new("TaskGroup expected, got #{task_group.class}.")
    end

    if self[task_group.header]
      raise ArgumentError.new("Task group with header #{task_group.header} is already on the list.")
    end

    @data << task_group
    self.sort!
  end

  def scheduled_task_groups
    @data.group_by { |tg| tg.scheduled_date.nil? }[false] || Array.new
  end

  def non_scheduled_task_groups
    @data.group_by { |tg| tg.scheduled_date.nil? }[true] || Array.new
  end

  def sort!
    @data = self.scheduled_task_groups.sort_by(&:scheduled_date) +
            self.non_scheduled_task_groups

    self
  end

  # Remove a task group from the task list.
  #
  # @param [TaskGroup] task_group the task group.
  # @since 0.2
  def delete(task_group)
    @data.delete(task_group)
  end

  # Iterate over the task groups.
  #
  # @yieldparam [TaskGroup] task_group
  # @since 0.2
  def each(&block)
    @data.each(&block)
  end

  # Return a scheduled task list formatted string.
  #
  # @since 0.2
  def to_s
    @data.map(&:to_s).join("\n")
  end

  def save(path)
    data = self.to_s
    File.open(path, 'w:utf-8') do |file|
      file.puts(data)
    end
  end
end

export { TaskList }
