function package_init(package)
    package:declare_package_id("com.discord.Konstinople#7692.player.Man")
    package:set_special_description("Before he was Mega, he was Man")
    package:set_speed(1.0)
    package:set_attack(1)
    package:set_charged_attack(10)
    package:set_icon_texture(Engine.load_texture(_folderpath.."icon.png"))
    package:set_preview_texture(Engine.load_texture(_folderpath.."preview.png"))
    package:set_overworld_animation_path(_folderpath.."overworld.animation")
    package:set_overworld_texture_path(_folderpath.."overworld.png")
    package:set_mugshot_texture_path(_folderpath.."mug.png")
    package:set_mugshot_animation_path(_folderpath.."mug.animation")
end

function player_init(player)
    player:set_name("Test") --name of navi
    player:set_health(1500) --set health
    player:set_element(Element.Summon) --element
    player:set_height(80.0)

    local base_texture = Engine.load_texture(_folderpath.."battle.png")
    local base_animation_path = _folderpath.."battle.animation"
    local base_charge_color = Color.new(57, 198, 243, 255)

    player:set_animation(base_animation_path)
    player:set_texture(base_texture)
    player:set_fully_charged_color(base_charge_color)
    player:set_charge_position(0, -20)

    player.normal_attack_func = function()
        return Battle.Buster.new(player, false, player:get_attack_level())
    end

    player.charged_attack_func = function()
        return Battle.Buster.new(player, true, player:get_attack_level() * 10)
    end

    -- simple megaman form
    local mega = player:create_form()
    mega:set_mugshot_texture_path(_folderpath.."forms/mega_entry.png")

    mega.on_activate_func = function()
        -- use megaman assets
        player:set_animation(_folderpath.."forms/mega.animation")
        player:set_texture(Engine.load_texture(_folderpath.."forms/mega.png"))
        player:set_fully_charged_color(Color.new(243, 57, 198, 255))

        -- buff attack
        player:set_attack_level(5) -- max attack level
        player:set_charge_level(5) -- max charge level
    end

    mega.on_deactivate_func = function()
        player:set_animation(base_animation_path)
        player:set_texture(base_texture)
        player:set_fully_charged_color(base_charge_color)
        -- attack/charge stats are automatically reverted by the engine
    end
     
    -- forms also have a normal_attack_func, charged_attack_func, and special_attack_func
    -- however, megaman does not have different abilities than man, so we'll just exclude these
    -- so the engine will fallback to what is defined on the player
end
