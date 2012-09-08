module Coke

	class CrossCompiler
		def initialize
			@parser = Parser.new
		end

		def compile(code)
			@parser.parse(code).to_objc(nil)
		end
	end

	class Nodes
		# This method is the "interpreter" part of our language. All nodes know how to to_objc
		# itself and returns the result of its to_objcuation by implementing the "to_objc" method.
		# The "context" variable is the environment in which the node is to_objcuated (local
		# variables, current class, etc.).
		def to_objc(context)
			return_value = nil
			nodes.each do |node|
				return_value = node.to_objc(context)
			end
			# The last value to_objcuated in a method is the return value. Or nil if none.
			return_value
		end

		def to_objc_returning(context)
			src = ""
			return_value = nil
			nodes.each do |node|
				src << "return " if node == nodes.last
				src << node.to_objc(context)
			end
			# The last value to_objcuated in a method is the return value. Or nil if none.
			src
		end
	end

	class NumberNode
		def to_objc(context)
			# Here we access the Runtime, which we'll see in the next section, to create a new
			# instance of the Number class.
			"@(#{value})" #Runtime["Number"].new_with_value(value)
		end
	end

	class StringNode
		def to_objc(context)
			"@\"#{value}\"" #Runtime["String"].new_with_value(value)
		end
	end

	class TrueNode
		def to_objc(context)
			"YES" #Runtime["true"]
		end
	end

	class FalseNode
		def to_objc(context)
			"NO" #Runtime["false"]
		end
	end

	class NilNode
		def to_objc(context)
			"null" #Runtime["nil"]
		end
	end

	class CallNode
		def to_objc(context)
			# If there's no receiver and the method name is the name of a local variable, then
			# it's a local variable access. This trick allows us to skip the () when calling a
			# method.
			if receiver.nil? && arguments.empty? # && context.locals[method]
				# context.locals[method]
				method #{}"[self #{method}]"

			# Method call
			else
				if receiver
					# value = receiver.to_objc(context)
					"[#{receiver} #{method}]"
				else
					# In case there's no receiver we default to self, calling "print" is like
					# "self.print".
					# value = context.current_self
					"[self #{method}]"
				end

				# to_objc_arguments = arguments.map { |arg| arg.to_objc(context) }
				# value.call(method, to_objc_arguments)
			end
		end
	end

	class GetConstantNode
		def to_objc(context)
			context[name]
		end
	end

	class SetConstantNode
		def to_objc(context)
			context[name] = value.to_objc(context)
		end
	end

	class SetLocalNode
		def to_objc(context)
			context.locals[name] = value.to_objc(context)
		end
	end

	class DefNode
		def to_objc(context)
			# Defining a method is adding a method to the current class.
			# method = AwesomeMethod.new(params, body)
			# context.current_class.runtime_methods[name] = method
			"-(id)#{name}{#{body.to_objc_returning(context)}}"
		end
	end

	class ClassNode
		def to_objc(context)
			# Try to locate the class. Allows reopening classes to add methods.
			awesome_class = context[name]

			unless awesome_class # Class doesn't exist yet
				awesome_class = AwesomeClass.new
				# Register the class as a constant in the runtime.
				context[name] = awesome_class
			end

			# to_objcuate the body of the class in its context. Providing a custom context allows
			# to control where methods are added when defined with the def keyword. In this
			# case, we add them to the newly created class.
			class_context = Context.new(awesome_class, awesome_class)

			body.to_objc(class_context)

			awesome_class
		end
	end

	class IfNode
		def to_objc(context)
			# We turn the condition node into a Ruby value to use Ruby's "if" control
			# structure.
			if condition.to_objc(context).ruby_value
				body.to_objc(context)
			end
		end
	end

end