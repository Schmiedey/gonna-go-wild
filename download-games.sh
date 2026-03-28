#!/bin/bash
# ============================================================
# WILD KRATTS FLASH GAMES DOWNLOADER
# Downloads all .swf game files from the Internet Archive
# ============================================================

GAMES_DIR="$(dirname "$0")/games"
BASE_URL="https://archive.org/download/wild-kratts-flash-games-pbs-kids"

mkdir -p "$GAMES_DIR"

echo "========================================"
echo "  GONNA GO WILD - Game Downloader"
echo "  Downloading from Internet Archive..."
echo "========================================"
echo ""

# All actual SWF files from the archive
FILES=(
    # Main Games
    "CheetahGame.swf"
    "RoundUp.swf"
    "KangarooGame.swf"
    "DracoGame.swf"
    "BatGame.swf"
    "SlitherRun.swf"
    "RemoraGame.swf"
    "CrocHatch.swf"
    "FireflyGame.swf"
    "FrogFish.swf"
    "CaracalGame.swf"
    "SquirrelGame.swf"
    "Webtastic.swf"
    "DolphinDive.swf"

    # Habitats
    "SavannahHabitat.swf"
    "AustraliaHabitat.swf"
    "RainforestHabitat.swf"
    "ReefHabitat.swf"
    "BorealHabitat.swf"
    "OceanHabitat.swf"
    "DesertHabitat.swf"
    "AvatarRoom.swf"

    # Shell & Extras
    "Tortuga.swf"
    "WKShell.swf"
    "main.swf"
    "Creaturepedia.swf"
    "HabitatLoader.swf"
    "Supergame.swf"
    "Supergame_data.swf"
    "container.swf"
    "game_intro.swf"
    "supergame_intro.swf"
    "dolphinDive_Intro.swf"
)

TOTAL=${#FILES[@]}
COUNT=0
SUCCESS=0
FAIL=0

for file in "${FILES[@]}"; do
    COUNT=$((COUNT + 1))
    echo "[$COUNT/$TOTAL] Downloading $file..."

    if curl -sL --fail -o "$GAMES_DIR/$file" "$BASE_URL/$file"; then
        SIZE=$(ls -lh "$GAMES_DIR/$file" | awk '{print $5}')
        echo "         Done ($SIZE)"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "         FAILED"
        rm -f "$GAMES_DIR/$file"
        FAIL=$((FAIL + 1))
    fi
done

echo ""
echo "========================================"
echo "  DOWNLOAD COMPLETE"
echo "  Success: $SUCCESS / $TOTAL"
if [ $FAIL -gt 0 ]; then
    echo "  Failed:  $FAIL"
fi
echo "  Games saved to: $GAMES_DIR"
echo "========================================"
