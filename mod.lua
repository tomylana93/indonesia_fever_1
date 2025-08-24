local ffu = require "filefilterutil"
local osutil = require "osutil"

function data()
    return {
        info = {
            name = _("modName"),
            description = _("modDesc"),
            authors = {{
                name = "StealtFlanker",
                role = 'CREATOR'
            }},
            minorVersion = 0,
            severityAdd = "WARNING",
            severityRemove = "CRITICAL",
            visible = true,
            params = {{
                key = "earnAchievementsWithMods",
                name = _("modFeat1"),
                values = {"Disabled", "Enabled"},
                tooltip = _("modFeatDesc1"),
                defaultIndex = 1
            }, {
                key = "noAnimals",
                name = _("modFeat2"),
                values = {"Disabled", "Enabled"},
                tooltip = _("modFeatDesc2"),
                defaultIndex = 0
            }}
        },
        options = {
            nameList = {{"indonesia", _("modCountry")}}
        },
        runFn = function(settings, modParams)
            local params = modParams[getCurrentModId()]
            local earnAchievementsWithMods = {false, true}
            game.config.earnAchievementsWithMods = earnAchievementsWithMods[params["earnAchievementsWithMods"] + 1]

            game.config.gui.layers.contourLines = {
                numLevels = 6,
                baseTerrainColor = {0.8, 0.8, 0.8, 1},
                baseEntityColor = {1.0, 1.0, 1.0, 1.0},
                terrainMinColor = {.82, .82, .82, 1.0},
                terrainMaxColor = {.235, .54, .25, 1.0},
                waterColor = {.47, .64, .76, 1.0},
                contours = {{
                    id = "majorContour",
                    name = _("Major contour (100 m)"),
                    color = {.05, .05, .05, .5},
                    level = 100.0,
                    width = 2.5,
                    fadeDist = -1.0
                }, {
                    id = "minorContour",
                    name = _("Minor contour (50 m)"),
                    color = {.05, .05, .05, .5},
                    level = 50.0,
                    width = 1.75,
                    fadeDist = -1.0
                }, {
                    id = "intermediateContour",
                    name = _("Intermediate contour (10 m)"),
                    color = {.1, .075, .0, .3},
                    level = 10.0,
                    width = 1,
                    fadeDist = 12000.0
                }, {
                    id = "detailContour",
                    name = _("Detail contour (1 m)"),
                    color = {.1, .075, .0, .3 * 0.3},
                    level = 1.0,
                    width = .5,
                    fadeDist = 4000.0
                }}
            }

            -- Remove animals if 'noAnimals' setting is enabled
            if params["noAnimals"] == 1 then
                addModifier("loadModel", function(fileName, data)
                    if data.metadata and data.metadata.animal then
                        if data.metadata.animal.config then
                            data.metadata.animal.config.density = 0
                            data.metadata.animal.config.targetDistance = 0
                            data.metadata.animal.config.fish = true
                        end
                        if data.metadata.animal.suitableAreas and data.metadata.animal.suitableAreas.scores then
                            for key, value in pairs(data.metadata.animal.suitableAreas.scores) do
                                data.metadata.animal.suitableAreas.scores[key] = -1000
                            end
                        end
                    end
                    return data
                end)
            end

        end,
        postRunFn = function(settings, params)
            local trackNames = api.res.trackTypeRep.getAll()
            local globalTrackData = {}
            for _, name in ipairs(trackNames) do
                local track = api.res.trackTypeRep.get(api.res.trackTypeRep.find(name))
                if track and track.name then
                    table.insert(globalTrackData, {
                        fileName = name,
                        name = track.name,
                        availability = track.availability or {
                            yearFrom = 0,
                            yearTo = 0
                        }
                    })
                end
            end

            table.sort(globalTrackData, function(a, b)
                local yearFromA = (a.availability and a.availability.yearFrom) or 0
                local yearFromB = (b.availability and b.availability.yearFrom) or 0
                return yearFromA < yearFromB
            end)

            api.tf_mod_track_data = globalTrackData
        end
    }
end

