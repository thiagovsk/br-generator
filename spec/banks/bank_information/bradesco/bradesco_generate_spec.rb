require 'spec_helper'

describe Bradesco do
  describe '.generate' do
    let(:bank) { described_class.new }

    context 'when agency is 1112 and account is 1111112' do
      before do
        allow(bank.bank_util).to receive(:generate_agency_number)
                                 .and_return('1112')
        allow(bank.bank_util).to receive(:generate_account_number)
                                 .and_return('1111112')
      end

      let(:generated) { bank.generate }

      it 'has agency check number equals to 6' do
        expect(generated[:agency_check_number]).to eq('6')
      end

      it 'has account check number equals to 2' do
        expect(generated[:account_check_number]).to eq('2')
      end
    end

    context 'when check numbers should be P' do
      before do
        allow(bank.bank_util).to receive(:generate_agency_number)
                                 .and_return('1124')
        allow(bank.bank_util).to receive(:generate_account_number)
                                 .and_return('1111119')
      end

      let(:generated) { bank.generate }

      it 'has agency check number equals to P' do
        expect(generated[:agency_check_number]).to eq('P')
      end

      it 'has account check number equals to P' do
        expect(generated[:account_check_number]).to eq('P')
      end
    end

    context 'when checks number should be 0' do
      before do
        allow(bank.bank_util).to receive(:generate_agency_number)
                                 .and_return('1115')
        allow(bank.bank_util).to receive(:generate_account_number)
                                 .and_return('1111113e')
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
