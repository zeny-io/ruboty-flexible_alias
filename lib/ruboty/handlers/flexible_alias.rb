require 'ruboty'

module Ruboty
  module Handlers
    class FlexibleAlias < Base
      NAMESPACE = 'flexible_alias'.freeze

      on(
        /flexible alias (?<original>.+?) -> (?<alias>.+)\z/m,
        description: 'Create flexible alias message',
        name: 'create'
      )

      on(
        /list flexible alias\z/,
        description: 'List flexible alias',
        name: 'list'
      )

      on(
        /delete flexible alias (?<alias>.+)\z/m,
        description: 'Delete flexible alias',
        name: 'delete'
      )

      on(
        /flexible scoped alias (?<original>.+?) -> (?<alias>.+)\z/m,
        description: 'Create flexible alias message',
        name: 'create_scoped'
      )

      on(
        //,
        description: 'Resolve flexible alias if registered',
        name: 'resolve',
        hidden: true
      )

      def create(message)
        from = message[:original]
        to = message[:alias]
        register('*', from, to)
        message.reply("Registered alias: #{from} -> #{to}")
      end

      def create_scoped(message)
        scope = message.from
        from = message[:original]
        to = message[:alias]
        register(scope, from, to)
        message.reply("Registered alias: #{from} -> #{to}")
      end

      def delete(message)
        scope = message.from
        if (table[scope] || {}).delete(message[:alias])
          message.reply('Deleted')
        else
          if (table['*'] || {}).delete(message[:alias])
            message.reply('Deleted')
          else
            message.reply('Not found')
          end
        end
      end

      def list(message)
        message.reply(aliases(message.from), code: true)
      end

      def resolve(message)
        scope = message.from
        scoped = table[scope] || {}
        all = table['*'] || {}
        from = message.body.gsub(prefix, '')

        hit = false
        all.merge(scoped).each_pair do |pattern, transformed|
          alias_cmd = Ruboty::FlexibleAlias::Alias.new(pattern, transformed)

          next unless aliased = alias_cmd.tranfrom(from)
          robot.receive(
            message.original.merge(
              body: "#{message.body[prefix]}#{aliased}"
            )
          )
          hit = true
          break
        end

        hit
      end

      private

      def register(scope, original, transformed)
        table[scope] ||= {}
        table[scope][original] = transformed
      end

      def table
        robot.brain.data[NAMESPACE] ||= {}
      end

      def aliases(scope)
        scoped = table[scope] || {}
        all = table['*'] || {}
        flexible_table = all.merge(scoped)
        if flexible_table.empty?
          'No alias registered'
        else
          flexible_table.map { |from, to| "#{from} -> #{to}" }.join("\n")
        end
      end

      def prefix
        Ruboty::Action.prefix_pattern(robot.name)
      end
    end
  end
end
