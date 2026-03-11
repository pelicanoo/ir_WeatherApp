app = angular.module 'weather-data-app', []

track_wetness_str = [
        "Unknown",
        "dry (1/7)",
        "mostly dry (2/7)",
        "very lightly wet (3/7)",
        "lightly wet (4/7)",
        "moderately wet (5/7)",
        "very wet (6/7)",
        "extremely wet (7/7)",
    ]

app.service 'iRService', ($rootScope) ->
    ir = new IRacing ['TrackWetness', 'Precipitation', 'Skies', 'SessionInfo', 'TrackTemp', 'AirTemp', 'RelativeHumidity'], [], 10

    ir.onConnect = ->        
        
        ir.data.CustomLastPrecipitation = 0
        ir.data.CustomPrecipitationState = 0
        ir.data.CustomPrecipitationStr = '0.0%'

        ir.data.CustomLastHumidity = 0
        ir.data.CustomHumidityState = 0
        ir.data.CustomHumidityStr = '0.0%'

        ir.data.CustomLastTrackState = 0
        ir.data.CustomTrackStateState = 0
        ir.data.CustomTrackStateStr = 'N/A'

        ir.data.CustomLastTrackTemp = 0
        ir.data.CustomTrackTempState = 0
        ir.data.CustomTrackTempStr = '0.0°C'

        ir.data.CustomLastAirTemp = 0
        ir.data.CustomAirTempState = 0
        ir.data.CustomAirTempStr = '0.0°C'

        ir.data.CustomLastTrackWetness = undefined
        ir.data.CustomTrackWetnessState = 0
        ir.data.CustomTrackWetnessStr = 'Unknown'

        $rootScope.$apply()
        console.log 'connected'

    ir.onDisconnect = ->
        console.log 'disconnected'

    ir.onUpdate = (keys) ->
        $rootScope.$apply()

    return ir

app.controller 'WeatherCtrl', ($scope, iRService, $timeout) ->
    $scope.ir = ir = iRService.data

    $scope.$watch 'ir.TrackWetness', onTrackWetness = (w) ->
        
        if w != undefined
            if ir.CustomLastTrackWetness == undefined
                ir.CustomLastTrackWetness = w
            else
                if w > ir.CustomLastTrackWetness
                    ir.CustomTrackWetnessState = 1
                    $timeout (-> ir.CustomTrackWetnessState = 0), 7000
                else if w < ir.CustomLastTrackWetness
                    ir.CustomTrackWetnessState = 2
                    $timeout (-> ir.CustomTrackWetnessState = 0), 7000
            
            ir.CustomTrackWetnessStr = track_wetness_str[w]
            ir.CustomLastTrackWetness = w

    $scope.$watch 'ir.Precipitation', onPrecipitation = (p) ->
        if p != undefined 

            if p == 0
                ir.CustomPrecipitationState = 0
            else if p > ir.CustomLastPrecipitation
                ir.CustomPrecipitationState = 1
            else if p < ir.CustomLastPrecipitation
                ir.CustomPrecipitationState = 2
        
            ir.CustomPrecipitationStr = (p * 100).toFixed(1) + '%'
            ir.CustomLastPrecipitation = p

    $scope.$watch 'ir.RelativeHumidity', onHumidity = (h) ->
        if h != undefined 

            if h == 0
                ir.CustomHumidityState = 0
            else if h > ir.CustomLastHumidity
                ir.CustomHumidityState = 1
            else if h < ir.CustomLastHumidity
                ir.CustomHumidityState = 2
        
            ir.CustomHumidityStr = (h * 100).toFixed(1) + '%'
            ir.CustomLastHumidity = h

    $scope.$watch 'ir.SessionInfo.Sessions[0].SessionTrackRubberState', onTrackState = (state) ->
        if state != undefined 

            if ir.CustomLastTrackState == undefined
                ir.CustomLastTrackState = state
            else
                if state > ir.CustomLastTrackState
                    ir.CustomTrackStateState = 1
                    $timeout (-> ir.CustomTrackStateState = 0), 1000
                else if state < ir.CustomLastTrackState
                    ir.CustomTrackStateState = 2
                    $timeout (-> ir.CustomTrackStateState = 0), 1000
            
            ir.CustomTrackStateStr = state
            ir.CustomLastTrackState = state

    $scope.$watch 'ir.TrackTemp', onTrackTemp = (t) ->
        if t != undefined 

            if t == 0
                ir.CustomTrackTempState = 0
            else if t > ir.CustomLastTrackTemp
                ir.CustomTrackTempState = 1
            else if t < ir.CustomLastTrackTemp
                ir.CustomTrackTempState = 2
        
            ir.CustomTrackTempStr = t.toFixed(1) + '°C'
            ir.CustomLastTrackTemp = t

    $scope.$watch 'ir.AirTemp', onAirTemp = (t) ->
        if t != undefined 

            if t == 0
                ir.CustomAirTempState = 0
            else if t > ir.CustomLastAirTemp
                ir.CustomAirTempState = 1
            else if t < ir.CustomLastAirTemp
                ir.CustomAirTempState = 2
        
            ir.CustomAirTempStr = t.toFixed(1) + '°C'
            ir.CustomLastAirTemp = t
        

angular.bootstrap document, [app.name]