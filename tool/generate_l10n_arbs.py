#!/usr/bin/env python3
"""Generate Hindi and Gujarati ARB files from app_en.arb."""

from __future__ import annotations

import json
import site
import subprocess
import sys
from pathlib import Path
from typing import Any, Dict

ROOT = Path(__file__).resolve().parents[1]
EN_PATH = ROOT / "lib" / "l10n" / "app_en.arb"
HI_PATH = ROOT / "lib" / "l10n" / "app_hi.arb"
GU_PATH = ROOT / "lib" / "l10n" / "app_gu.arb"
LOCAL_PY_DEPS = ROOT / "tool" / ".pydeps"

PROTECTED_TERMS = [
    "Sabalpara Parivar",
    "Sabalpara",
    "OTP",
    "Google",
]


def ensure_translator() -> Any:
    try:
        from deep_translator import GoogleTranslator

        return GoogleTranslator
    except ImportError:
        LOCAL_PY_DEPS.mkdir(parents=True, exist_ok=True)
        subprocess.check_call(
            [
                sys.executable,
                "-m",
                "pip",
                "install",
                "--target",
                str(LOCAL_PY_DEPS),
                "deep-translator",
            ]
        )
        site.addsitedir(str(LOCAL_PY_DEPS))
        from deep_translator import GoogleTranslator

        return GoogleTranslator


def mask_terms(text: str) -> tuple[str, Dict[str, str]]:
    masked = text
    token_map: Dict[str, str] = {}
    for idx, term in enumerate(PROTECTED_TERMS):
        token = f"__TERM_{idx}__"
        if term in masked:
            masked = masked.replace(term, token)
            token_map[token] = term
    return masked, token_map


def unmask_terms(text: str, token_map: Dict[str, str]) -> str:
    result = text
    for token, term in token_map.items():
        result = result.replace(token, term)
    return result


def translate_text(translator: Any, text: str) -> str:
    if not isinstance(text, str) or not text.strip():
        return text

    masked_text, token_map = mask_terms(text)
    translated = translator.translate(masked_text)
    translated = unmask_terms(translated, token_map)
    return translated


def build_locale_arb(en_data: Dict[str, Any], locale: str, target_lang: str) -> Dict[str, Any]:
    GoogleTranslator = ensure_translator()
    translator = GoogleTranslator(source="en", target=target_lang)

    output: Dict[str, Any] = {"@@locale": locale}

    for key, value in en_data.items():
        if key == "@@locale":
            continue
        if key.startswith("@"):
            output[key] = value
            continue
        if isinstance(value, str):
            output[key] = translate_text(translator, value)
        else:
            output[key] = value

    return output


def save_arb(path: Path, data: Dict[str, Any]) -> None:
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def validate_keys(en_data: Dict[str, Any], out_data: Dict[str, Any]) -> tuple[int, int]:
    en_keys = set(en_data.keys())
    out_keys = set(out_data.keys())
    missing = en_keys - out_keys
    if missing:
        raise ValueError(f"Missing keys in output: {sorted(missing)}")
    return len(en_keys), len(out_data)


def main() -> None:
    if not EN_PATH.exists():
        raise FileNotFoundError(f"Source ARB file not found: {EN_PATH}")

    en_data: Dict[str, Any] = json.loads(EN_PATH.read_text(encoding="utf-8"))

    hi_data = build_locale_arb(en_data, locale="hi", target_lang="hi")
    gu_data = build_locale_arb(en_data, locale="gu", target_lang="gu")

    save_arb(HI_PATH, hi_data)
    save_arb(GU_PATH, gu_data)

    en_count, hi_count = validate_keys(en_data, hi_data)
    _, gu_count = validate_keys(en_data, gu_data)

    print(f"Source: {EN_PATH}")
    print(f"Generated: {HI_PATH} (keys: {hi_count}, locale: hi)")
    print(f"Generated: {GU_PATH} (keys: {gu_count}, locale: gu)")
    print(f"All source keys preserved: {en_count}")


if __name__ == "__main__":
    main()
