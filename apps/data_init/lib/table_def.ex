defmodule TableDef do
  def tables() do
    [
      %{
        name: Character,
        attributes: [
          :id,                # ID
          :name,              # Character name
          :account_id,        # ID of associated account
          :gender,            # Male/Female/Bi-sexual
          :race,              # Character race
          :position,          # Character's position in the world
          :attributes,        # 3 baes attributes: [Strength, Wisdom, Dexterity]
          :creation_date,     # The date of this character's creation
          :last_login_date    # The date of this character's last login
        ]
      }, %{
        name: Account,
        attributes: [
          :id,
          :email,
          :password,
          :phone,
          :last_login
        ]
      }
    ]
  end
end
