require 'spec_helper'

describe BancoDoBrasil do
  describe '.validate' do
    let(:bank) { described_class.new }

    context 'when agency check digit is valid' do
      context 'when account check digit is valid' do
        let(:validated) { bank.validate('1234', '3', '12321', '8') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when account check digit is not valid' do
        let(:validated) { bank.validate('1234', '9', '12321', 'X') }

        it 'has invalid check digits' do
          expect(validated[:valid]).to be false
        end
      end

      context 'when agency check digit is X' do
        let(:validated) { bank.validate('1236', 'X', '12321', '8') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when agency check digit is 0' do
        let(:validated) { bank.validate('2135', '0', '12321', '8') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end
    end

    context 'when account check digit is valid' do
      context 'when agency check digit is valid' do
        let(:validated) { bank.validate('1234', '3', '12321', '8') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when agency check digit is not valid' do
        let(:validated) { bank.validate('1234', 'X', '12321', '8') }

        it 'has invalid check digits' do
          expect(validated[:valid]).to be false
        end
      end

      context 'when account check digit is X' do
        let(:validated) { bank.validate('1234', '3', '112773', 'X') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when account check digit is 0' do
        let(:validated) { bank.validate('1234', '3', '12325', '0') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end
    end
  end
end
