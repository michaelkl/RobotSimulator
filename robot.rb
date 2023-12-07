# Robot position and looking direction
Position = Struct.new(:d, :x, :y) do
  # Applies command to the position
  # @param command [BaseCommand]
  # @return [Position] new position
  def apply(command)
    command.(self)
  end

  def to_s
    "#{self.d.to_s.upcase}@{#{self.x}, #{self.y}}"
  end

  def inspect
    "#<#{self.class}: #{self}>"
  end
end

class BaseCommand
  # @param pos [Position] initial position
  # @return [Position]
  def self.call(pos)
    raise NotImplementedError
  end
end

# Advances the robot
class AdvanceCommand < BaseCommand
  def self.call(pos)
    case pos.d
    when :n
      Position.new(pos.d, pos.x, pos.y+1)
    when :s
      Position.new(pos.d, pos.x, pos.y-1)
    when :w
      Position.new(pos.d, pos.x-1, pos.y)
    when :e
      Position.new(pos.d, pos.x+1, pos.y)
    else
      raise ArgumentError.new("Unsupported direction #{pos.d}")
    end
  end
end

class TurnLeftCommand < BaseCommand
  def self.call(pos)
    case pos.d
    when :n
      Position.new(:w, pos.x, pos.y)
    when :s
      Position.new(:e, pos.x, pos.y)
    when :w
      Position.new(:s, pos.x, pos.y)
    when :e
      Position.new(:n, pos.x, pos.y)
    else
      raise ArgumentError.new("Unsupported direction #{pos.d}")
    end
  end
end

class TurnRightCommand < BaseCommand
  def self.call(pos)
    case pos.d
    when :n
      Position.new(:e, pos.x, pos.y)
    when :s
      Position.new(:w, pos.x, pos.y)
    when :w
      Position.new(:n, pos.x, pos.y)
    when :e
      Position.new(:s, pos.x, pos.y)
    else
      raise ArgumentError.new("Unsupported direction #{pos.d}")
    end
  end
end

# Builds commands objects by their string representation
class CommandFactory
  # @param command [String]
  def self.call(command)
    case command.downcase
    when 'a'
      AdvanceCommand
    when 'l'
      TurnLeftCommand
    when 'r'
      TurnRightCommand
    else
      raise ArgumentError.new("Unsupported command #{command}")
    end
  end
end

# Performs robot's test run
# @param pos [Position] initial position
# @param commands [String] commands sequence to perform
# @return [Position]
def move(pos, commands)
  commands.each_char
          .map { CommandFactory.(_1) }
          .reduce(pos, &:apply)
end
