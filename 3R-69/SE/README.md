# Practical 1

## Aim
To identify a suitable real-world case study and clearly define the problem statement.

## Objectives
* To select a relevant, modern software engineering case study involving AI integration.
* To understand the operational workflow of bridging local Large Language Models (LLMs) with messaging platforms.
* To clearly define the problem that the "OpenClaw WhatsApp Bot" intends to solve.
* To outline the scope of the system in a real-world context.

## Theory: OpenClaw AI Gateway
OpenClaw is a local AI assistant and gateway designed to bridge the gap between offline, privacy-focused AI models (such as those managed by Ollama) and popular messaging platforms like WhatsApp.

In a traditional setup, AI models run in isolation on a local machine (e.g., using `qwen3-coder` or `llama3`). Users interact with them via a terminal or a dedicated local UI. However, this isolates the AI's capabilities from real-world communication channels where daily interactions occur.

The OpenClaw Integration serves as middleware—a "connector" software—that listens to incoming messages from a platform (WhatsApp), processes them using the local AI model, and sends the generated response back to the user. This creates a "WhatsApp Bot" that is powered entirely by local hardware, ensuring data privacy and zero reliance on cloud APIs.

## Problem Statement
In the current digital landscape, businesses and individuals face significant challenges in managing communication efficiency while maintaining data privacy. The specific problems that necessitate the development of the OpenClaw WhatsApp Bot are:

1. **Disconnection of Local AI:** Powerful open-source AI models (via Ollama) exist on local machines but lack a native interface to interact with mobile messaging apps like WhatsApp.
2. **Privacy Concerns with Cloud Bots:** Existing WhatsApp bots often rely on cloud-based AI (like OpenAI or Gemini APIs), which requires sending private chat data to third-party servers. There is a lack of tools that allow users to deploy private, self-hosted bots.
3. **Manual Response Latency:** Individuals and small businesses struggle to respond to high volumes of WhatsApp messages manually in real-time.
4. **Integration Complexity:** Connecting a raw LLM (Large Language Model) to the WhatsApp API requires complex coding for session management, message queuing, and API handling.

**The Solution:** The OpenClaw system solves this by providing a pre-built gateway that automates the connection between the Ollama local server and the WhatsApp infrastructure, enabling an automated, private, and intelligent response system.

## Scope of the Case Study
This practical focuses on the "Work in Progress" module of OpenClaw:
* **Input:** Text messages received via WhatsApp.
* **Processing:** The OpenClaw gateway routing the query to a local Ollama model.
* **Output:** The generated text response sent back to the WhatsApp chat.

## Conclusion
The OpenClaw WhatsApp Bot has been identified as a suitable real-world case study. It presents a clear software engineering challenge: integrating heterogeneous systems (Local AI and External Messaging APIs) to solve the problem of privacy-focused, automated communication. This defines the foundation for further requirement analysis and system design.

---

# Practical 2

## Aim
To identify and document the functional and non-functional requirements of the selected case study.

## Objectives
* To understand the operational workflow of the OpenClaw WhatsApp integration.
* To identify core system functionalities required for a local AI bot.
* To classify system requirements into functional and non-functional categories.
* To document requirements clearly and systematically for the bot development process.

## Theory: OpenClaw WhatsApp Bot
The OpenClaw WhatsApp Bot is a middleware application that connects a local Large Language Model (LLM), such as Llama 3 running via Ollama, to the WhatsApp messaging platform. Unlike traditional cloud-based bots, this system processes data locally to ensure privacy.

## Requirement Analysis
Requirement analysis for this system focuses on bridging two distinct environments: the stateless nature of the local AI model and the session-based, real-time nature of WhatsApp messaging. It involves identifying what the bot must do (e.g., receive, process, and reply to messages) and how it must perform (e.g., response speed, data privacy, and uptime).

### Functional Requirements
Functional requirements describe the specific behaviors and functions the bot system must support to operate effectively.

**List of Functional Requirements:**
* **Message Reception:** The system shall actively listen for and intercept incoming text messages from the connected WhatsApp account.
* **Context Management:** The system shall maintain a conversation history (context window) for each user to ensure the AI understands follow-up questions.
* **Local LLM Integration:** The system shall successfully forward user queries to the local Ollama instance (e.g., querying the `qwen3-coder` or `llama3` model).
* **Response Generation:** The system shall retrieve the text generated by the local AI model and format it for WhatsApp.
* **Message Transmission:** The system shall automatically send the formatted AI response back to the specific user chat on WhatsApp.
* **Command Handling:** The system shall recognize and execute specific slash commands (e.g., `/reset` to clear memory or `/help` for instructions).
* **Multi-Chat Support:** The system shall handle multiple conversation threads simultaneously without mixing user contexts.
* **Error Handling:** The system shall send a default error message if the local Ollama server is offline or fails to generate a response.
* **Media Handling (Future Scope):** The system shall identify if an incoming message contains media (images/audio) and either process it or gracefully decline if unsupported.
* **Session Persistence:** The system shall automatically restore the connection to WhatsApp if the session is temporarily interrupted.

### Non-Functional Requirements
Non-functional requirements specify the quality attributes, constraints, and performance standards of the bot.

**List of Non-Functional Requirements:**
* **Privacy (Crucial):** The system shall ensure that no message data is sent to external cloud servers; all processing must remain on the local hardware.
* **Performance (Latency):** The system shall generate and send a response within a reasonable timeframe (e.g., under 5-10 seconds), dependent on local hardware capabilities.
* **Reliability:** The system shall maintain a stable connection to the WhatsApp gateway (OpenClaw) without frequent disconnects.
* **Scalability:** The system shall be able to handle a moderate increase in concurrent chat sessions without crashing the local server.
* **Resource Efficiency:** The system shall manage RAM and CPU usage effectively to prevent slowing down the host machine during token generation.
* **Availability:** The system shall be designed to run 24/7 to ensure responses are available at any time.
* **Maintainability:** The code structure shall allow for easy swapping of underlying AI models (e.g., switching from Llama 3 to Mistral) via configuration files.
* **Security:** The system shall not expose the local network or API ports to unauthorized external access.
* **Portability:** The system shall be deployable on various operating systems (Windows, Linux, macOS) that support Docker or Node.js.
* **Usability:** The bot interactions shall be natural and conversational, mimicking human-like responses rather than robotic outputs.

## Conclusion
The identification and documentation of these requirements provide a blueprint for the "OpenClaw WhatsApp Bot." By clearly defining the functional needs (integration and context management) and non-functional constraints (privacy and latency), we establish a solid foundation for the development and testing phases of the project.

---

# Practical 3

## Aim
To draw the use case diagram for the case study and write detailed specifications for each use case.

## Objectives
* To identify the primary and secondary actors involved in the OpenClaw WhatsApp Bot system.
* To visualize the functional requirements of the system using a Use Case Diagram.
* To define the relationships (include/extend) between different use cases.
* To write detailed specifications (flow of events) for critical use cases.

## 1. Use Case Diagram
The diagram below illustrates the interactions between the User (WhatsApp User), the System (OpenClaw Gateway), and the Local AI Model (Ollama).

**Actors:**
* **WhatsApp User (Primary):** The person sending messages via the WhatsApp mobile app.
* **OpenClaw Gateway (System):** The middleware that manages the connection and logic.
* **Local LLM / Ollama (Secondary):** The background AI service (e.g., Llama 3) that generates the intelligence.

## 2. Use Case Specifications
Below are the detailed specifications for the core use cases identified in the diagram.

### Use Case 1: Send Message
* **Use Case ID:** UC-01
* **Actor:** WhatsApp User
* **Description:** The user sends a text query to the bot via the WhatsApp interface.
* **Pre-conditions:** The user must have a valid WhatsApp account and an active internet connection. The OpenClaw gateway must be running.
* **Post-conditions:** The message is received by the OpenClaw system and queued for processing.
* **Flow of Events:**
  1. User opens the WhatsApp chat with the bot.
  2. User types a query (e.g., "Write a Python script for sorting").
  3. User hits the "Send" button.
  4. WhatsApp server delivers the message to the OpenClaw webhook.

### Use Case 2: Process Message (with AI Generation)
* **Use Case ID:** UC-02
* **Actor:** OpenClaw Gateway, Local AI (Ollama)
* **Description:** The system processes the incoming text, retrieves context, and generates a response using the local AI model.
* **Pre-conditions:** A message has been successfully received (UC-01).
* **Post-conditions:** A response is generated and ready to be sent.
* **Flow of Events:**
  1. System sanitizes the input (removes unsupported characters).
  2. System retrieves the conversation history (Context) for this specific user.
  3. System constructs a prompt (Input + Context) and sends it to the Local AI (Ollama).
  4. Local AI processes the prompt and streams back the generated text.
  5. System formats the text (e.g., adding bolding/code blocks) for WhatsApp.
* **Alternative Flow (Error):**
  * If the Local AI is offline, the system triggers UC-07 (Handle Error) and returns a "Service Unavailable" message.

### Use Case 3: Execute Command
* **Use Case ID:** UC-08
* **Actor:** WhatsApp User, System Admin
* **Description:** The user or admin sends a special slash command to control the bot's behavior.
* **Pre-conditions:** The message must start with a designated character (e.g., `/`).
* **Post-conditions:** The requested system action is performed (e.g., memory cleared).
* **Flow of Events:**
  1. User sends a command like `/reset` or `/help`.
  2. System detects the command prefix.
  3. System parses the command.
  4. If `/reset`: System clears the conversation history database for that user.
  5. If `/help`: System returns a pre-defined help text string.
  6. System sends the confirmation message back to the user.

## Conclusion
The Use Case Diagram effectively maps the interactions required for the OpenClaw WhatsApp Bot. The specifications clarify the internal logic, specifically how the `<<include>>` relationship binds message reception to AI processing, and how `<<extend>>` handles errors and special commands.

---

# Practical 4

## Aim
To identify analysis classes and design the class diagram for the case study.

## Objectives
* To identify the core analysis classes (Boundary, Control, and Entity classes) for the OpenClaw system.
* To define the attributes (data) and operations (methods) for each class.
* To establish the relationships (associations, dependencies, generalizations) between classes.
* To design a comprehensive Class Diagram representing the system structure.

## Theory: Analysis Classes
A Class Diagram is a static structure diagram that describes the structure of a system by showing the system's classes, their attributes, operations (or methods), and the relationships among objects.
* **Boundary Classes:** Handle communication between the system and external actors (e.g., `WhatsAppInterface`).
* **Control Classes:** Handle the business logic and coordination (e.g., `MessageController`).
* **Entity Classes:** Represents the data or information held by the system (e.g., `User`, `ChatSession`).

## Identification of Classes
Based on the OpenClaw WhatsApp Bot requirements, we identified the following classes:
* **WhatsAppGateway (Boundary):** The interface that connects to the WhatsApp API. It listens for incoming webhooks and pushes outgoing replies.
* **BotController (Control):** The central brain. It receives raw data, decides if it's a command or a chat, and routes it accordingly.
* **OllamaService (Control/Service):** Manages the connection to the local AI model. It handles the API calls to the local Ollama instance.
* **User (Entity):** Represents the person chatting with the bot. Stores details like `phoneNumber` and `preferences`.
* **Conversation (Entity):** Stores the history of messages for a specific session. This is critical for the AI to understand context.
* **Message (Entity):** A single unit of communication containing `content`, `timestamp`, and `senderID`.

## Class Relationships
* `User` has a 1-to-many association with `Conversation` (One user can have multiple chat threads, though usually one active thread).
* `Conversation` is composed of many `Message`s.
* `BotController` uses `WhatsAppGateway` to send/receive data.
* `BotController` depends on `OllamaService` to generate intelligent responses.

## Conclusion
In this practical, we successfully identified the core analysis classes required for the OpenClaw WhatsApp Bot, categorizing them into Boundary (e.g., WhatsAppGateway), Control (e.g., BotController, OllamaService), and Entity (e.g., User, Conversation) classes. By designing the Class Diagram, we mapped out the static structure of the system, defining the specific attributes, operations, and relationships between these objects. This blueprint provides a clear object-oriented foundation for the subsequent implementation phase.

---

# Practical 5

## Aim
To draw sequence diagrams representing interactions between system objects for selected use cases.

## Objectives
* To identify the participating objects (Actors, Boundary, Control, and Entity) for specific use cases.
* To model the dynamic behavior of the OpenClaw WhatsApp Bot by mapping the flow of messages over time.
* To represent synchronous calls, asynchronous signals, and return messages between lifelines.
* To construct a detailed Sequence Diagram for the "Process Message" use case.

## Theory: Sequence Diagrams
A Sequence Diagram is an interaction diagram that details how operations are carried out. It captures the interaction between objects in the context of a collaboration.
* **Lifelines:** Represent the individual participants (objects) in the interaction.
* **Messages:** Arrows represent communication between objects (e.g., method calls `processIncoming()` or return values).
* **Time Ordering:** Time progresses vertically from top to bottom.

## Selected Use Case: Process Incoming Message
This sequence diagram illustrates the flow when a user sends a message to the bot, and the bot uses the local AI to generate a reply.

**Participating Objects:**
* **User (Actor):** The initiator.
* **WhatsAppGateway (Boundary):** The interface receiving the webhook.
* **BotController (Control):** The main logic coordinator.
* **Conversation (Entity):** Stores the chat history.
* **OllamaService (Service):** The connection to the local AI model.

**Sequence of Events (Flow):**
1. The User sends a text message via WhatsApp.
2. The WhatsAppGateway receives the webhook and calls `processIncoming(msg)` on the BotController.
3. The BotController calls `appendMessage(msg)` on the Conversation object to save the user's input.
4. The BotController requests a response by calling `generateResponse(history)` on the OllamaService.
5. The OllamaService processes the prompt and returns the `generatedText` to the controller.
6. The BotController formats the response and calls `sendMessage(text)` on the WhatsAppGateway.
7. The WhatsAppGateway pushes the final reply back to the User.

**Sequence Diagram Representation:**
*(Note: In your practical file, you would draw the diagram corresponding to the flow above. Below is the text description of the visual elements.)*
* **Lifelines:** Vertical dashed lines drop down from `User`, `WhatsAppGateway`, `BotController`, `Conversation`, and `OllamaService`.
* **Message 1:** Arrow from `User` to `WhatsAppGateway` labeled `send("Hello bot")`.
* **Message 2:** Arrow from `WhatsAppGateway` to `BotController` labeled `processIncoming("Hello bot")`.
* **Message 3:** Arrow from `BotController` to `Conversation` labeled `saveMessage()`.
* **Message 4:** Arrow from `BotController` to `OllamaService` labeled `generateResponse()`.
* **Self-Call/Activation bar** on `OllamaService` indicates processing time.
* **Return Message:** Dashed arrow from `OllamaService` to `BotController` labeled `return "Hello Human"`.
* **Message 5:** Arrow from `BotController` to `WhatsAppGateway` labeled `sendReply("Hello Human")`.
* **Message 6:** Arrow from `WhatsAppGateway` to `User` labeled `delivery`.

## Conclusion
The Sequence Diagram successfully maps the dynamic view of the "Process Message" use case. It highlights the critical role of the BotController in coordinating between the storage (Conversation) and the intelligence (OllamaService) before interacting with the external interface (WhatsAppGateway). This visualization helps in identifying potential bottlenecks, such as the latency in the AI generation step.

---

# Practical 6

## Aim
To draw activity diagrams to model the workflow and control flow of the system.

## Objectives
* To understand the operational flow of the OpenClaw WhatsApp Bot from message reception to response.
* To identify sequential and parallel activities within the system.
* To model decision points (e.g., distinguishing between commands and standard chat).
* To construct a detailed Activity Diagram representing the system's control flow.

## Theory: Activity Diagrams
An Activity Diagram is a behavioral diagram that portrays the control flow from a start point to a finish point, showing the various decision paths that exist while the activity is being executed. It is essentially an advanced flowchart that supports parallel processing.
* **Action State:** Represents a step in the process (e.g., "Sanitize Input").
* **Decision Node:** A diamond shape representing a branch in the flow (e.g., "Is Command?").
* **Fork/Join:** Horizontal bars used to represent parallel processing (e.g., saving logs while generating a response).

## Activity Workflow (OpenClaw Bot)
The diagram models the lifecycle of a single incoming message:
1. **Start:** The workflow begins when the WhatsApp Gateway receives a webhook.
2. **Validation:** The system checks if the input is valid text. If not, it sends an error and ends.
3. **Command Check (Decision):** The system checks if the message starts with a slash (`/`).
   * **If Yes:** It routes to the Command Handler (e.g., clear history).
   * **If No:** It proceeds to the AI Chat Handler.
4. **Context Retrieval:** The system fetches the user's previous chat history from the database.
5. **AI Processing:** The system sends the Context + New Message to the local Ollama model.
6. **Response Generation:** The Local AI generates a text response.
7. **Delivery:** The system pushes the formatted text back to the WhatsApp user.
8. **End:** The workflow concludes.

**Activity Diagram Layout:**
*(You can draw this in Draw.io using "Activity" shapes. Below is the text representation of the flow.)*

`[Start Node] --> [Receive Message]`
`[Receive Message] --> <Decision: Is Valid?>`
`No --> [Send Error] --> [End Node]`
`Yes --> <Decision: Is Command?>`
`<Decision: Is Command?>`
`Yes (starts with /) --> [Execute Command] --> [Send System Notification] --> [End Node]`
`No --> [Retrieve Chat History]`
`[Retrieve Chat History] --> [Construct AI Prompt]`
`[Construct AI Prompt] --> [Query Ollama Model]`
`[Query Ollama Model] --> [Receive Generated Text]`
`[Receive Generated Text] --> [Format Message]`
`[Format Message] --> [Send WhatsApp Reply]`
`[Send WhatsApp Reply] --> [End Node]`

## Conclusion
In this practical, we successfully modeled the workflow of the OpenClaw WhatsApp Bot using an Activity Diagram. This visualization clarifies the decision logic (Command vs. Chat) and the sequential steps required to process user input, providing a clear roadmap for implementing the system's control flow.

---

# Practical 7

## Aim
To draw state diagrams representing the states and state transitions of important system objects.

## Objectives
* To identify the key objects in the OpenClaw WhatsApp Bot that undergo significant state changes.
* To model the lifecycle of a Chat Session object.
* To define the events (triggers) that cause transitions between states (e.g., "Receive Message" or "Timeout").
* To construct a State Diagram that visualizes the behavior of the system over time.

## Theory: State Diagrams
A State Diagram (or State Machine Diagram) describes the behavior of a single object by showing the sequence of states it goes through during its lifetime in response to events.
* **State:** A condition or situation in the life of an object (e.g., Idle, Processing, Waiting).
* **Transition:** A relationship between two states indicating that an object will perform certain actions and enter a second state when a specific event occurs.
* **Initial/Final State:** The starting and ending points of the object's lifecycle.

## Selected Object: Chat Session
For this case study, we will model the Chat Session object. A session represents the active interaction between a specific user and the bot.

**States Identified:**
* **Idle:** The default state. The bot is waiting for a user message.
* **Receiving:** The bot has detected an incoming webhook but hasn't processed it yet.
* **Processing (Thinking):** The local AI (Ollama) is generating a response.
* **Sending:** The response is being formatted and pushed to WhatsApp.
* **Error:** The system encountered a failure (e.g., AI offline).
* **Archived:** The session is closed or saved after a timeout.

**Transitions (Events):**
* User sends message → Transitions from Idle to Receiving.
* Validation passed → Transitions from Receiving to Processing.
* AI generation complete → Transitions from Processing to Sending.
* Message sent → Transitions from Sending back to Idle.
* Connection fail → Transitions from Processing to Error.
* Session timeout (30 mins) → Transitions from Idle to Archived.

**State Diagram Layout:**
*(You can draw this in Draw.io using "State Machine" shapes. Below is the text representation.)*

`[Start Point] --> [Idle]`
`[Idle] --(User Message)--> [Receiving]`
`[Receiving] --(Valid Input)--> [Processing]`
`[Processing] --(Generate Text)--> [Sending]`
`[Sending] --(Delivery Success)--> [Idle]`
`[Processing] --(AI Offline)--> [Error]`
`[Error] --(Retry/Reset)--> [Idle]`
`[Idle] --(Timeout > 30m)--> [Archived]`
`[Archived] --> [End Point]`

## Conclusion
In this practical, we successfully modeled the dynamic behavior of the OpenClaw Chat Session using a State Diagram. This visualization helps in understanding how the system handles different phases of communication, ensuring that edge cases like timeouts and errors are managed correctly within the object's lifecycle.

---

# Practical 8

## Aim
To draw the deployment diagram showing the physical architecture and deployment of software components.

## Objectives
* To identify the hardware nodes (devices and servers) required for the OpenClaw WhatsApp Bot.
* To map the software artifacts (OpenClaw, Ollama, WhatsApp) to their respective execution environments.
* To specify the communication protocols (HTTPS, Webhooks, API calls) between nodes.
* To visualize the physical deployment topology of the system.

## Theory: Deployment Diagrams
A Deployment Diagram models the physical architecture of a computer system. It describes the configuration of processing nodes and the execution of software components (artifacts) on those nodes.
* **Nodes:** Physical hardware (e.g., Server, Smartphone) or execution environments (e.g., Docker Container).
* **Artifacts:** Software files or executables (e.g., `.jar`, `script.py`, database).
* **Communication Paths:** Associations between nodes indicating how they communicate (e.g., TCP/IP, HTTPS).

## Deployment Architecture (OpenClaw Bot)
The system is distributed across three main environments: the User's Device, the Cloud (WhatsApp Servers), and the Local Server (Host Machine).

### 1. Node: End User Device (Mobile)
* **Type:** Hardware (Smartphone - Android/iOS).
* **Artifact:** WhatsApp Mobile App.
* **Function:** The interface where the user sends messages.

### 2. Node: WhatsApp Cloud Server
* **Type:** Cloud Infrastructure.
* **Artifact:** WhatsApp Business API.
* **Function:** Acts as the intermediary, receiving messages from the phone and forwarding them via webhook to our local server.

### 3. Node: Local Host Server (Your PC/Server)
* **Type:** Hardware (PC/Laptop).
* **Environment:** Docker Container / OS Runtime.
* **Artifacts:**
  * **OpenClaw Gateway:** The middleware listener (listening on port `3000/8080`).
  * **Ollama Service:** The AI engine (listening on port `11434`).
  * **Model File:** The specific LLM weights (e.g., `llama3.gguf`).

## Communication Specifications
* **User Device ↔ WhatsApp Cloud:** Communicates via HTTPS/4G/5G (Encrypted).
* **WhatsApp Cloud ↔ Local Host:** Communicates via Webhook (HTTPS). *Note: In a local setup, this often requires a tunneling service like Ngrok to expose the local port.*
* **OpenClaw ↔ Ollama:** Communicates via Localhost API (HTTP) on internal ports.

## Conclusion
In this practical, we successfully designed the Deployment Diagram for the OpenClaw WhatsApp Bot. This visualization clarifies the physical separation between the cloud-based messaging infrastructure and the privacy-focused local AI processing, highlighting the need for secure webhook connections and efficient local resource management.
