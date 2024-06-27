local player = VojinLIB:create_class("LocalPlayer")

function player:is_online()
    local is_signed_in = self:is_signed_in()

    if Global.game_settings.single_player then
        is_signed_in = false
    end

    return is_signed_in
end

function player:is_signed_in()
    local is_signed_in = managers.network.account:signin_state() == "signed in"

    if SystemInfo:matchmaking() == Idstring("MM_EPIC") and not EpicMM:logged_on() then
        is_signed_in = false
    end

    return is_signed_in
end