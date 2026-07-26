# Waybar CPU Info Module

## Script

- **Location:** `~/.local/lib/hyde/cpuinfo.sh`
- **Update interval:** 5 seconds (set in `modules/cpuinfo.jsonc`)

## What It Shows

### Bar Text (default)

CPU temperature, e.g. `52°C`

### Tooltip (on hover)

- CPU model name
- Per-core temperatures (supports coretemp, k10temp, zenpower)
- CPU utilization percentage
- Current clock speed / max clock speed (MHz)

### CSS Classes

Outputs classes for color-coding based on thresholds:

- `temp-{0-5-10-...-100}` - temperature bucket (every 5°C)
- `util-{0-10-20-...-100}` - utilization bucket (every 10%)

## JSON Output Format

```json
{
  "text": "52°C",
  "tooltip": "CPU Model\nTemperature: ...\nUtilization: 34.7%\nClock Speed: .../... MHz",
  "class": ["temp-50", "util-30"],
  "percentage": 52,
  "alt": "50"
}
```

## How to Enable

1. Add the module definition to `config.jsonc`:

```jsonc
"custom/cpuinfo": {
    "exec": "cpuinfo.sh",
    "return-type": "json",
    "format": "{}",
    "interval": 5,
    "tooltip": true,
    "max-length": 1000
},
```

2. Add `"custom/cpuinfo"` to the desired modules list (`modules-left`, `modules-center`, or `modules-right`)
3. Reload waybar: `killall -SIGUSR1 waybar`

## Customization

### Show utilization instead of temperature

Edit `cpuinfo.sh` line 127, change `$temperature°C` to `$utilization%`:

```bash
# Before
{"text":"$temperature°C", "tooltip":"$tooltip_str", "class":["$temp_class","$util_class"], "percentage":$temp_pct, "alt":"$temp_bucket"}

# After
{"text":"$utilization%", "tooltip":"$tooltip_str", "class":["$temp_class","$util_class"], "percentage":$util_pct, "alt":"$util_bucket"}
```

The tooltip still shows all info (temp, utilization, clock speed) regardless of what the bar text displays.

## Notes

- Temperature ID can be set via `CPUINFO_TEMPERATURE_ID` environment variable to pick a specific sensor
- CPU model and max freq are cached in `$XDG_RUNTIME_DIR/hyde-$UID-processors`
