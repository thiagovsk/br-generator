require 'spec_helper'

describe BancoDoBrasil do
  describe '.generate' do
    let(:bank) { described_class.new }

    context 'when agency is 1584 and account is 00210169' do
      before do
        allow(bank.bank_util).to receive(:generate_agency_number)
          .and_return('1584')
        allow(bank.bank_util).to receive(:generate_account_number)
          .and_return('210169')
      end

      let(:generated) { bank.generate }

      it 'has agency check number equals to 9' do
        expect(generated[:agency_check_number]).to eq('9')
      end

      it 'has account check number equals to 6' do
        expect(generated[:account_check_number]).to eq('6')
      end
    end
  end
end
