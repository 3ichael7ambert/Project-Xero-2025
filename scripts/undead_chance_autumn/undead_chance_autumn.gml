// --- Chance ramps 0% on Sep 22 -> 100% on Oct 31 ---
function undead_chance_autumn() {
	
    var now = date_current_datetime();
    var yr   = date_get_year(now);

    // Start at Sep 22 00:00, end at Oct 31 23:59:59
    var start = date_create_datetime(yr, 9, 22, 0, 0, 0);
    var finish = date_create_datetime(yr, 10, 31, 23, 59, 59);

    // Convert to 0..1 (dates are real numbers in days)
    var t = (now - start) / (finish - start);
    return clamp(t, 0, 1); // before Sep 22 => 0, after Oct 31 => 1
	
}


// -------- Helpers --------
function __us_thanksgiving_date(_y) {
    // Thanksgiving = 4th Thursday of November (Nov 22..28)
    var d22 = date_create_datetime(_y, 11, 22, 0, 0, 0);
    var w   = date_get_weekday(d22);   // 1=Sun .. 7=Sat
    var THU = 5;
    var delta = ((THU - w) + 7) mod 7; // days to next Thursday
    return date_inc_day(d22, delta);
}

function __chr_prob_now() {
    var now = date_current_datetime();
    var yr   = date_get_year(now);

    // Key anchors
    var thanksgiving   = __us_thanksgiving_date(yr);
    var day_after_tg   = date_inc_day(thanksgiving, 1);                // start ramp (0%)
    var xmas_day_end   = date_create_datetime(yr, 12, 25, 23, 59, 59);  // 100% here
    var dec26_start    = date_create_datetime(yr, 12, 26, 0, 0, 0);     // 50% here
    var dec31_end      = date_create_datetime(yr, 12, 31, 23, 59, 59);  // 0% here

    // Before ramp starts -> 0
    if (now < day_after_tg) return 0;

    // Up-ramp: day after TG (0%) -> Dec 25 (100%)
    if (now <= xmas_day_end) {
        var t = (now - day_after_tg) / (xmas_day_end - day_after_tg); // 0..1
        return clamp(t, 0, 1);
    }

    // Down-ramp: Dec 26 (50%) -> Dec 31 (0%)
    if (now <= dec31_end) {
        var t2 = (now - dec26_start) / (dec31_end - dec26_start); // 0..1 across 12/26-12/31
        var p  = 0.5 * (1 - clamp(t2, 0, 1));                     // 0.5 -> 0
        return p;
    }

    // After Dec 31 -> 0
    return 0;
}
