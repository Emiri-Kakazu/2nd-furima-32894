# README

## usersテーブル

| Column                 | Type       | Options     |
| ---------------------- | ---------- | ----------  |
| nickname               | string     | null: false |
| email                  | string     | null: false |
| encrypted_password     | string     | null: false |
| password _confirmation | string     | null: false |
| family_name            | string     | null: false |
| first_name             | string     | null: false |
| furigana_family_name   | string     | null: false |
| furigana_first_name    | string     | null: false |
| birthday               | date       | null: false |

### Association
- has_many :items
- has_many :purchases


## itemsテーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| image_item             | string     | null: false                    |
| item_name              | string     | null: false                    |
| description            | text       | null: false                    |
| category               | string     | null: false                    |
| condition              | string     | null: false                    |
| first_name             | string     | null: false                    |
| pay_for_shipping       | string     | null: false                    |
| ship_from              | string     | null: false                    |
| days_to_ship           | int        | null: false                    |
| price                  | int        | null: false                    |
| user_id                | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase


## purchasesテーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| credit_card_number     | int        | null: false                    |
| postal_code            | string     | null: false                    |
| prefecture             | string     | null: false                    |
| municipalities         | string     | null: false                    |
| street_number          | string     | null: false                    |
| telephone_number       | string     | null: false                    |
| user_id                | references | null: false, foreign_key: true |
| item_id                | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
