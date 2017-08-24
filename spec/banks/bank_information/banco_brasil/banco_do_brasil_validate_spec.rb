require 'spec_helper'

describe BancoDoBrasil do
  describe '.validate' do
    let(:bank) { described_class.new }

    context 'when agency check digit is valid' do
      context 'when account check digit is valid' do
        let(:validated) { bank.validate('1584', '9', '210169', '6') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when account check digit is not valid' do
        let(:validated) { bank.validate('1584', '9', '210169', 'X') }

        it 'has invalid check digits' do
          expect(validated[:valid]).to be false
        end
      end

      context 'when agency check digit is X' do
        let(:validated) { bank.validate('1852', 'X', '210169', '6') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when agency check digit is 0' do
        let(:validated) { bank.validate('3494', '0', '210169', '6') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end
    end

    context 'when account check digit is valid' do
      context 'when agency check digit is valid' do
        let(:validated) { bank.validate('1584', '9', '210169', '6') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when agency check digit is not valid' do
        let(:validated) { bank.validate('1584', 'X', '210169', '6') }

        it 'has invalid check digits' do
          expect(validated[:valid]).to be false
        end
      end

      context 'when account check digit is X' do
        let(:validated) { bank.validate('1584', '9', '10089934', 'X') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end

      context 'when agency check digit is 0' do
        let(:validated) { bank.validate('1584', '9', '10089939', '0') }

        it 'has valid check digits' do
          expect(validated[:valid]).to be true
        end
      end
    end
  end
end
