defmodule Cineaste.Library.RelationshipType do
  use Ash.Type.Enum,
    values: [
      daughter: [label: "Daughter"],
      father: [label: "Father"],
      father_in_law: [label: "Father-in-Law"],
      granddaughter: [label: "Granddaughter"],
      grandfather: [label: "Grandfather"],
      grandson: [label: "Grandson"],
      mother: [label: "Mother"],
      nephew: [label: "Nephew"],
      son: [label: "Son"],
      son_in_law: [label: "Son-in-Law"],
      spouse: [label: "Spouse"],
      uncle: [label: "Uncle"]
    ]
end
