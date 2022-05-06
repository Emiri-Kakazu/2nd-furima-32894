# README

## usersテーブル

| Column                 | Type       | Options     |
| ---------------------- | ---------- | ----------  |
| nickname               | string     | null: false |
| email                  | string     | null: false |
| encrypted_password     | string     | null: false |
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
| item_name              | string     | null: false                    |
| description            | string     | null: false                    |
| category _id           | int        | null: false                    |
| condition _id          | int        | null: false                    |
| pay_for_shipping _id   | int        | null: false                    |
| ship_from _id          | int        | null: false                    |
| days_to_ship _id       | int        | null: false                    |
| price                  | int        | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase


## purchasesテーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| user                   | references | null: false, foreign_key: true |
| item                   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル
| Column                 | Type       | Options                        |
| postal_code            | string     | null: false                    |
| prefecture             | string     | null: false                    |
| municipalities         | string     | null: false                    |
| street_number          | string     | null: false                    |
| telephone_number       | string     | null: false                    |

### Association
- belongs_to :purchase