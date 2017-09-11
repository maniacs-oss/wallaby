module Wallaby
  class ActiveRecord
    class ModelDecorator
      class FieldsBuilder
        # To build the metadata for associations
        class AssociationBuilder
          def update(metadata, reflection)
            type = reflection.macro
            metadata[:is_association] = true
            metadata[:is_through] = through?(reflection)
            metadata[:has_scope] = scope?(reflection)
            metadata[:foreign_key] = foreign_key_for(reflection, type)
          end

          private

          def foreign_key_for(reflection, type)
            if :belongs_to == type || reflection.polymorphic?
              reflection.foreign_key
            elsif reflection.collection?
              # @see https://github.com/rails/rails/blob/92703a9ea5d8b96f30e0b706b801c9185ef14f0e/activerecord/lib/active_record/associations/builder/collection_association.rb#L50
              reflection.name.to_s.singularize << '_ids'
            else
              reflection.association_foreign_key
            end
          end

          def through?(reflection)
            reflection.is_a? ::ActiveRecord::Reflection::ThroughReflection
          end

          def scope?(reflection)
            reflection.scope.present?
          end
        end
      end
    end
  end
end