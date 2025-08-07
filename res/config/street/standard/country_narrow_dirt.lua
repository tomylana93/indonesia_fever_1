function data()
    return {
        numLanes = 2,
        streetWidth = 4.0,
        sidewalkWidth = 1.0,
        sidewalkHeight = .0,
        yearFrom = 0,
        yearTo = 0,
        aiLock = true,
        country = true,
        speed = 30.0,
        type = "country dirt narrow",
        name = _("Narrow country dirt road"),
        desc = _("Two-lane narrow country dirt road with a speed limit of %2%."),
        categories = {"country"},
        borderGroundTex = "street_border.lua",
        sidewalkFillGroundTex = "country_sidewalk.lua",
        materials = {
            streetPaving = {
                name = "street/country_old_small_paving.mtl",
                size = {8.0, 5.3333}
            },
            streetBorder = {
                name = "",
                size = {16.0, 2.0}
            },
            streetLane = {
                name = "street/country_old_small_lane.mtl",
                size = {8.0, 2.6667}
            },
            streetStripe = {},
            streetStripeMedian = {},
            streetTram = {
                name = "street/old_medium_tram_paving.mtl",
                size = {2.0, 2.0}
            },
            streetTramTrack = {
                name = "street/old_medium_tram_track.mtl",
                size = {2.0, 2.0}
            },
            streetBus = {},
            crossingLane = {
                name = "street/country_old_small_lane.mtl",
                size = {8.0, 2.6667}
            },
            crossingBus = {},
            crossingTram = {
                name = "street/old_medium_tram_paving.mtl",
                size = {2.0, 2.0}
            },
            crossingTramTrack = {
                name = "street/old_medium_tram_track.mtl",
                size = {2.0, 2.0}
            },
            crossingCrosswalk = {},
            sidewalkLane = {},
            sidewalkBorderInner = {
                name = "",
                size = {16.0, 1.0}
            },
            sidewalkBorderOuter = {
                name = "street/country_old_small_sidewalk_border_outer.mtl",
                size = {8.0, 1.3333}
            },
            sidewalkCurb = {},
            sidewalkWall = {}
        },
        cost = 15.0
    }
end
