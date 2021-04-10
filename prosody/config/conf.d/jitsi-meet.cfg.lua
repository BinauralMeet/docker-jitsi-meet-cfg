admins = {
    "focus@auth.meet.jitsi",
    "jvb@auth.meet.jitsi"
}

plugin_paths = { "/prosody-plugins/", "/prosody-plugins-custom" }
http_default_host = "meet.jitsi"

cross_domain_bosh = true;
consider_bosh_secure = true;
cross_domain_websocket = true;
consider_websocket_secure = true;


VirtualHost "meet.jitsi"

    authentication = "anonymous"

    ssl = {
        key = "/config/certs/meet.jitsi.key";
        certificate = "/config/certs/meet.jitsi.crt";
    }
    speakerstats_component = "speakerstats.meet.jitsi"
    conference_duration_component = "conferenceduration.meet.jitsi"
    modules_enabled = {
        "websocket";
        "bosh";
        "pubsub";
        "ping";
        "smacks";
        "speakerstats";
        "turncredentials";
        "conference_duration";
        "muc_lobby_rooms";
        "admin_telnet";
    }
    c2s_require_encryption = false
    lobby_muc = "lobby.meet.jitsi"
    main_muc = "conference.meet.jitsi"

VirtualHost "auth.meet.jitsi"
    ssl = {
        key = "/config/certs/auth.meet.jitsi.key";
        certificate = "/config/certs/auth.meet.jitsi.crt";
    }
    authentication = "internal_hashed"


VirtualHost "recorder.meet.jitsi"
    modules_enabled = {
      "ping";
    }
    authentication = "internal_hashed"


Component "internal-muc.meet.jitsi" "muc"
    storage = "memory"
    modules_enabled = {
        "ping";
    }
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "muc.meet.jitsi" "muc"
    storage = "memory"
    modules_enabled = {
        "muc_meeting_id";
        "muc_domain_mapper";
    }
    muc_room_cache_size = 1000
    muc_room_locking = false
    muc_room_default_public_jids = true
    admins = { "focus@auth.meet.jitsi" }
    muc_room_locking = false
    muc_room_default_public_jids = true

Component "focus.meet.jitsi"
    component_secret = "12b3d467a3c125328989f1c12b5110fc"

Component "speakerstats.meet.jitsi" "speakerstats_component"
    muc_component = "muc.meet.jitsi"

Component "conferenceduration.meet.jitsi" "conference_duration_component"
    muc_component = "muc.meet.jitsi"

Component "lobby.meet.jitsi" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_locking = false
    muc_room_default_public_jids = true
