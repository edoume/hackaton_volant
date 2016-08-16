class Spot < ActiveRecord::Base
	geocoded_by :adresse
	after_validation :geocode
	before_save :set_windspeed
	belongs_to :user
	validates_presence_of :nom, :adresse

	def set_windspeed
		self.vitesse = forecast_request.currently.windSpeed * windspeed_voncert
	end

	def tableauvitesse
		tab = []
		(0..7).each do |i|
			tab << forecast_request.daily.data[i].windSpeed * windspeed_voncert
		end
		tab
	end

	def windspeed_voncert
		1.609344
	end

	def tableauheure
		tabh = []
		(1..48).each do |i|
			tabh << forecast_request.hourly.data[i].windSpeed * windspeed_voncert
		end
		tabh
	end

	def tabpluie
		pluietab = []
		(1..48).each do |p|
			pluietab << forecast_request.hourly.data[p].precipIntensity * 25.4
		end
		pluietab
	end

	def htime
		dailyh = []
		(1..48).each do |h|
			dailyh << ((Time.now.hour + h) % 24)
		end
		dailyh
	end

	def dday
		ddaytab = []
		(0..7).each do |d|
			ddaytab << d
		end
		ddaytab
	end


	def can_fly
		vitesse >= 8 && vitesse <= 30
	end

	private

	def forecast_request
		@forecast ||= ForecastIO.forecast(latitude, longitude)
	end

end
