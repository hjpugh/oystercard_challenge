require 'journey_log'
require 'date'

def date
  Date.today.strftime('%F').split('-').reverse.join('-')
end

describe JourneyLog do
  let(:mock_station1) { double :station, station_id: :AA, zone: 1 }
  let(:mock_station2) { double :station, station_id: :BB, zone: 2 }

  describe '#start' do
    it 'sets the @in instance variable to entry station' do
      subject.start_log(mock_station1)
      expect(subject.in).to eq :AA
    end
  end

  describe '#log' do
    it 'holds a list of previous journeys' do
      subject.start_log(mock_station1)
      subject.finish_log(mock_station2)
      subject.start_log(mock_station2)
      subject.finish_log(mock_station1)
      expect(subject.log.empty?).to be false 
    end

    describe '#start_log' do
      it 'tells the journey to start & adds incomplete info to log' do
        subject.start_log(mock_station2)
        expect(subject.log.empty?).to be false
      end

      it 'sets @in to the station_id' do
        subject.start_log(mock_station1)
        expect(subject.in).to eq :AA
      end
    end

    describe '#finish_log' do
      it 'sets @out to the station_id' do
        subject.start_log(mock_station1)
        subject.finish_log(mock_station2)
        expect(subject.out).to eq :BB
      end

      it 'returns the current journey info to the log' do
        subject.start_log(mock_station1)
        subject.finish_log(mock_station2)
        subject.start_log(mock_station2)
        subject.finish_log(mock_station1)
        expect(subject.log.empty?).to be false
      end
    end
  end
end