require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録' do
    context '新規登録できる場合' do
      it 'ニックネーム、メールアドレス、パスワード、パスワード（確認用）、名字、名前、名字のフリガナ、名前のフリガナ、生年月日がすべて存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'ニックネームが空で登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空で登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'パスワードが空で登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワード（確認用）が空で登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '名字が空で登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it '名前が空で登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名字のフリガナが空で登録できない' do
        @user.furigana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name can't be blank")
      end

      it '名前のフリガナが空で登録できない' do
        @user.furigana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name can't be blank")
      end

      it '生年月日が空で登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'メールアドレスに@が含まれず登録できない' do
        @user.email = 'useremail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it '既存ユーザーのメールアドレスと重複して登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'パスワードとパスワード（確認用）が不一致で登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードが5文字以下で登録できない' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードが129文字以上で登録できない' do
        @user.password = 'jcLom2cYV1qY0LwILrUpOdxngkyIt2lqWKwEIys6xL8QU5UD5FNIUVr8fEKkwXEgseOHguHw0mkw37tTTE73YHrncoJwxROTg5WJ8s0TP2u4Sx1Ioox0idDTAYSLn3TCU'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'パスワードが半角英字のみで登録できない' do
        @user.password = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'パスワードが半角数字のみで登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'パスワードに半角英数字以外の文字が入っていて登録できない' do
        @user.password = '123abcあいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it '名字に全角以外の文字が入っていて登録できない' do
        @user.family_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end

      it '名前に全角以外の文字が入っていて登録できない' do
        @user.first_name = 'Olivia'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it '名字のフリガナに全角カタカナ以外の文字が入っていて登録できない' do
        @user.furigana_family_name = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Furigana family name 全角カタカナを使用してください')
      end

      it '名前のフリガナに全角カタカナ以外の文字が入っていて登録できない' do
        @user.furigana_first_name = 'あやの'
        @user.valid?
        expect(@user.errors.full_messages).to include('Furigana first name 全角カタカナを使用してください')
      end
    end
  end
end
