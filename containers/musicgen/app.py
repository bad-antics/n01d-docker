"""
╔════════════════════════════════════════════════════════════════════════════════╗
║                     N01D MUSICGEN — Gradio Web UI                              ║
║          Generate music from text prompts using Meta's MusicGen                ║
╚════════════════════════════════════════════════════════════════════════════════╝
"""
import gradio as gr
import torch
import os
import datetime
from audiocraft.models import MusicGen
from audiocraft.data.audio import audio_write

# Cache models after first load
MODELS = {}

def load_model(model_size: str):
    """Load MusicGen model (cached after first use)."""
    if model_size not in MODELS:
        print(f"[N01D] Loading MusicGen {model_size}...")
        MODELS[model_size] = MusicGen.get_pretrained(f"facebook/musicgen-{model_size}")
        print(f"[N01D] MusicGen {model_size} ready ✓")
    return MODELS[model_size]

def generate_music(prompt, duration, model_size, temperature, top_k, top_p):
    """Generate music from a text prompt."""
    model = load_model(model_size)
    model.set_generation_params(
        duration=duration,
        temperature=temperature,
        top_k=int(top_k),
        top_p=top_p,
    )

    print(f"[N01D] Generating: '{prompt}' ({duration}s, {model_size})")
    wav = model.generate([prompt])

    # Save output
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    safe_name = "".join(c if c.isalnum() or c in "-_ " else "" for c in prompt[:40]).strip()
    filename = f"/app/output/{timestamp}_{safe_name}"
    audio_write(filename, wav[0].cpu(), model.sample_rate, strategy="loudness")

    output_path = f"{filename}.wav"
    print(f"[N01D] Saved: {output_path}")
    return output_path

# ═══════════════════════════════════════════════════════════════════════════════
# GRADIO INTERFACE
# ═══════════════════════════════════════════════════════════════════════════════
with gr.Blocks(
    title="N01D MusicGen",
) as app:
    gr.Markdown("# 🎵 N01D MusicGen\n**AI Music Generation — powered by Meta AudioCraft**")

    with gr.Row():
        with gr.Column(scale=3):
            prompt = gr.Textbox(
                label="Music Prompt",
                placeholder="e.g. dark synthwave with heavy bass and glitchy drums, cyberpunk atmosphere",
                lines=3,
            )
        with gr.Column(scale=1):
            model_size = gr.Dropdown(
                choices=["small", "medium", "large"],
                value="small",
                label="Model Size",
                info="small=fastest, large=best quality"
            )

    with gr.Row():
        duration = gr.Slider(minimum=5, maximum=60, value=15, step=1, label="Duration (seconds)")
        temperature = gr.Slider(minimum=0.1, maximum=2.0, value=1.0, step=0.1, label="Temperature")

    with gr.Row():
        top_k = gr.Slider(minimum=0, maximum=1000, value=250, step=10, label="Top-K")
        top_p = gr.Slider(minimum=0.0, maximum=1.0, value=0.0, step=0.05, label="Top-P")

    generate_btn = gr.Button("🎵 Generate Music", variant="primary", size="lg")
    output_audio = gr.Audio(label="Generated Music", type="filepath")

    generate_btn.click(
        fn=generate_music,
        inputs=[prompt, duration, model_size, temperature, top_k, top_p],
        outputs=output_audio,
    )

    gr.Markdown("""
    ### 💡 Prompt Ideas
    | Style | Example Prompt |
    |-------|---------------|
    | 🎸 Rock | `aggressive rock guitar riff with heavy drums and bass` |
    | 🎹 Lo-fi | `chill lo-fi hip hop beat with jazzy piano and vinyl crackle` |
    | 🎧 EDM | `high energy EDM drop with massive synths and pounding kick` |
    | 🌌 Ambient | `ethereal ambient soundscape with reverb pads and soft bells` |
    | 🏴‍☠️ Dark | `dark industrial beat with distorted bass and mechanical sounds` |
    | 🎻 Orchestral | `epic orchestral score with strings, brass, and timpani` |
    """)

app.launch(
    server_name="0.0.0.0",
    server_port=7860,
    share=False,
    theme=gr.themes.Base(primary_hue="green", neutral_hue="gray"),
    css="""
    .gradio-container { max-width: 900px !important; }
    h1 { color: #00ff41 !important; text-align: center; }
    """
)
