class Spot < ActiveRecord::Base
	geocoded_by :adresse   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates
	before_save :set_vitesse
	belongs_to :user

	def set_vitesse
		forecast = ForecastIO.forecast(latitude, longitude)
		self.vitesse = forecast.currently.windSpeed * 1.609344
	end

	def tableauvitesse
		forecast = ForecastIO.forecast(latitude, longitude)
		tab = []
		(0..7).each do |i|
			tab << forecast.daily.data[i].windSpeed * 1.609344
		end
		tab
	end

	def tableauheure
		forecast = ForecastIO.forecast(latitude, longitude)
		tabh = []
		(1..48).each do |i|
			tabh << forecast.hourly.data[i].windSpeed
		end
		tabh
	end

	def tabpluie
		forecast = ForecastIO.forecast(latitude, longitude)
		pluietab = []
		(1..48).each do |p|
			pluietab << forecast.hourly.data[p].precipIntensity * 25.4
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

end
