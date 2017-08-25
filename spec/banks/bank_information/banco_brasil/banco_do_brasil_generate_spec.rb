require 'spec_helper'

describe BancoDoBrasil do
  describe '.generate' do
    let(:bank) { described_class.new }

    context 'when agency is 1234 and account is 12321' do
      before do
        allow(bank.bank_util).to receive(:generate_agency_number)
          .and_return('1234')
        allow(bank.bank_util).to receive(:generate_account_number)
          .and_return('12321')
      end

      let(:generated) { bank.generate }

      it 'has agency check number equals to 3' do
        expect(generated[:agency_check_number]).to eq('3')
      end

      it 'has account check number equals to 8' do
        expect(generated[:account_check_number]).to eq('8')
      end
    end

    context 'when check numbers should be X' do
      before do
        allow(bank.bank_util).to receive(:generate_agency_number)
          .and_return('1236')
        allow(bank.bank_util).to receive(:generate_account_number)
          .and_return('112773')
      end

      let(:generated) { bank.generate }

      it 'has agency check number equals to X' do
        expect(generated[:agency_check_number]).to eq('X')
      end

      it 'has account check number equals to X' do
        expect(generated[:account_check_number]).to eq('X')
      end
    end

    context 'when checks number should be 0' do
      before do
        allow(bank.bank_util).to receive(:generate_agency_number)
          .and_return('2135')
        allow(bank.bank_util).to receive(:generate_account_number)
          .and_return('12325')
      end

      let(:generated) { bank.generate }

      it 'has agency check number equals to 0' do
        expect(generated[:agency_check_number]).to eq('0')
      end

      it 'has account check number equals to 0' do
        expect(generated[:account_check_number]).to eq('0')
      end
    end
  end
end
