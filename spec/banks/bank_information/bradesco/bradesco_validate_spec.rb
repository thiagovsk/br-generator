require 'spec_helper'

describe Bradesco do
  describe '.validate' do
    let(:bank) { described_class.new }

    context 'when agency check digit is valid' do
      context 'when account check digit is valid' do
        let(:validated) { bank.validate('1112', '6', '1111112', '2') }

        it 'has valid check digits' do
          puts validated
          expect(validated[:valid]).to be true
        end
      end

      context 'when account check digit is not valid' do
        let(:validated) { bank.validate('1112', '6', '1111112', 'X') }

        it 'has invalid check digits' do
          expect(validated[:valid]).to be false
        end
      end

      context 'when agency check digit is P' do
        let(:validated) { bank.validate('1124', 'P', '1111112', '2') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when agency check digit is 0' do
        let(:validated) { bank.validate('1115', '0', '1111112', '2') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end
    end

    context 'when account check digit is valid' do
      context 'when agency check digit is valid' do
        let(:validated) { bank.validate('1112', '6', '1111112', '2') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when agency check digit is not valid' do
        let(:validated) { bank.validate('1112', 'X', '1111112', '2') }

        it 'has invalid check digits' do
          expect(validated[:valid]).to be false
        end
      end

      context 'when account check digit is P' do
        let(:validated) { bank.validate('1112', '6', '1111119', 'P') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when account check digit is 0' do
        let(:validated) { bank.validate('1112', '6', '1111113', '0') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end
    end
  end
end
