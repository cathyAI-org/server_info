# Implementation Ideas

## Unified Prompt Assembly (prompt-composer)

### Architecture

```
Client (WebUI/Bot)
    ↓
prompt-composer (8110)
    ↓
[Character API] [Identity API] [catcord-memory]
    ↓
Complete Prompt Bundle
```

### Core Function

```python
def build_prompt_bundle(
    character_id: str,
    user_id: str,
    conversation_history: list[dict],
    max_context_tokens: int = 2048
) -> dict:
    """
    Assemble complete prompt bundle for LLM inference.
    
    Returns:
        {
            "system_prompt": str,
            "character_card": dict,
            "identity": dict,
            "memories": list[dict],
            "conversation": list[dict],
            "metadata": dict
        }
    """
    # Fetch character card
    character = fetch_character(character_id)
    
    # Fetch user identity
    identity = fetch_identity(user_id)
    
    # Retrieve relevant memories
    memories = fetch_relevant_memories(user_id, character_id, conversation_history)
    
    # Trim conversation to token budget
    trimmed_history = trim_to_token_limit(conversation_history, max_context_tokens)
    
    # Assemble system prompt
    system_prompt = assemble_system_prompt(character, identity, memories)
    
    return {
        "system_prompt": system_prompt,
        "character_card": character,
        "identity": identity,
        "memories": memories,
        "conversation": trimmed_history,
        "metadata": {
            "timestamp": now(),
            "token_count": estimate_tokens(system_prompt + trimmed_history)
        }
    }
```

### API Endpoint

```
POST /api/v1/prompt/build
{
    "character_id": "char_123",
    "user_id": "user_456",
    "conversation_history": [...],
    "max_context_tokens": 2048
}
```

---

## Persona Binding

### Concept

Map Matrix bot MXIDs to character IDs for automatic persona loading.

### Persona Registry

```json
{
    "personas": [
        {
            "mxid": "@irina:cathyai.local",
            "character_id": "char_irina_001",
            "display_name": "Irina",
            "avatar_url": "mxc://...",
            "role": "cleaner_bot"
        },
        {
            "mxid": "@delilah:cathyai.local",
            "character_id": "char_delilah_001",
            "display_name": "Delilah",
            "avatar_url": "mxc://...",
            "role": "news_bot"
        }
    ]
}
```

### Bot Initialization

```python
def init_bot(mxid: str):
    persona = load_persona(mxid)
    character = fetch_character(persona["character_id"])
    
    bot = MatrixBot(
        mxid=mxid,
        character=character,
        display_name=persona["display_name"],
        avatar_url=persona["avatar_url"]
    )
    
    return bot
```

---

## Memory/RAG Pipeline (catcord-memory)

### Architecture

```
Conversation → Ingestion → Embeddings → Vector DB
                                            ↓
User Query → Semantic Search ← Retrieval ← Vector DB
```

### Ingestion Pipeline

```python
def ingest_conversation(user_id, character_id, messages):
    for msg in messages:
        # Generate embedding
        embedding = embed_text(msg["content"])
        
        # Store in vector DB
        store_embedding(
            user_id=user_id,
            character_id=character_id,
            content=msg["content"],
            embedding=embedding,
            timestamp=msg["timestamp"],
            metadata=msg["metadata"]
        )
```

### Semantic Search

```python
def search_memories(user_id, character_id, query, top_k=5):
    query_embedding = embed_text(query)
    
    results = vector_db.search(
        embedding=query_embedding,
        filters={
            "user_id": user_id,
            "character_id": character_id
        },
        top_k=top_k
    )
    
    return results
```

### Memory Distillation

```python
def distill_memories(user_id, character_id, time_window="7d"):
    # Fetch recent conversations
    conversations = fetch_conversations(user_id, character_id, time_window)
    
    # Summarize with LLM
    summary = llm_summarize(conversations, prompt="Summarize key events and emotions")
    
    # Store as distilled memory
    store_distilled_memory(user_id, character_id, summary)
```

### Vector Database

- **Current:** Chroma (lightweight, easy deployment)
- **Future:** Qdrant (production-ready, scalable)

---

## Bot Command Parser

### !remove Command

```python
async def handle_message(room, event):
    if event.body.strip() == "!remove":
        # Check if reply
        if "m.relates_to" in event.content:
            target_event_id = event.content["m.relates_to"]["m.in_reply_to"]["event_id"]
            
            # Delete target message
            await client.room_redact(room.room_id, target_event_id, reason="User requested removal")
            
            # Delete command message
            await client.room_redact(room.room_id, event.event_id, reason="Command processed")
```

### Other Commands

- `!help` - List available commands
- `!status` - Bot health and uptime
- `!persona [name]` - Switch character (admin only)
- `!memory [query]` - Search bot's memory

---

## Public/Private Views (Character API)

### Public Endpoint (No Auth)

```
GET /api/v1/characters/{id}/public

Response:
{
    "id": "char_123",
    "name": "Irina",
    "avatar_url": "https://...",
    "tagline": "Your friendly cleaner bot",
    "public_bio": "I keep things tidy!"
}
```

### Private Endpoint (API Key Required)

```
GET /api/v1/characters/{id}
Headers: X-API-Key: [key]

Response:
{
    "id": "char_123",
    "name": "Irina",
    "personality": "...",
    "example_dialogues": [...],
    "system_prompt": "...",
    "private_notes": "..."
}
```

### ETag Caching

```python
@app.get("/api/v1/characters/{id}")
def get_character(id: str, if_none_match: str = Header(None)):
    character = fetch_character(id)
    etag = generate_etag(character)
    
    if if_none_match == etag:
        return Response(status_code=304)  # Not Modified
    
    return Response(
        content=character,
        headers={"ETag": etag}
    )
```

---

## Diary Generation

### Daily Summary Pipeline

```python
def generate_daily_diary(user_id, character_id, date):
    # Fetch all conversations for the day
    conversations = fetch_conversations_by_date(user_id, character_id, date)
    
    # Analyze emotional tone
    emotions = analyze_emotions(conversations)
    
    # Extract key topics
    topics = extract_topics(conversations)
    
    # Generate summary with LLM
    summary = llm_generate(
        prompt=f"Summarize this day's conversations:\n{conversations}",
        max_tokens=500
    )
    
    # Store diary entry
    diary_entry = {
        "user_id": user_id,
        "character_id": character_id,
        "date": date,
        "summary": summary,
        "emotions": emotions,
        "topics": topics,
        "message_count": len(conversations)
    }
    
    store_diary_entry(diary_entry)
    
    return diary_entry
```

### Scheduled Execution

```bash
# Systemd timer or cron
0 1 * * * python generate_diary.py --date yesterday
```

---

## Systemd Service Management

### Service Template

```ini
[Unit]
Description=Cleaner Bot (Irina)
After=network.target docker.service

[Service]
Type=simple
WorkingDirectory=/opt/cathyai/bots/cleaner
EnvironmentFile=/opt/cathyai/bots/cleaner/.env
ExecStart=/usr/bin/python3 bot.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

### Timer Template

```ini
[Unit]
Description=Daily Diary Generation Timer

[Timer]
OnCalendar=daily
OnCalendar=01:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

---

## AI Orchestration (ai-orchestrator)

### Multi-Model Routing

```python
async def route_request(prompt: str, preferences: dict):
    # Analyze request
    analysis = analyze_prompt(prompt)
    
    # Route based on requirements
    if analysis["requires_speed"]:
        return await npu_svc_inference(prompt)
    elif analysis["requires_quality"]:
        return await ollama_inference(prompt, model="llama3:70b")
    else:
        return await ollama_inference(prompt, model="llama3:8b")
```

### Load Balancing

```python
async def balanced_inference(prompt: str):
    # Check node availability
    nodes = get_available_nodes()
    
    # Select least loaded
    node = min(nodes, key=lambda n: n.current_load)
    
    # Execute inference
    return await node.inference(prompt)
```

---

*These implementation ideas are living documents and evolve with development.*
