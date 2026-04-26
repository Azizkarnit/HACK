import { Component, OnInit, ElementRef, ViewChild, AfterViewChecked } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';
import { AiService, AiResponse } from '../../core/services/ai.service';

@Component({
  selector: 'app-ai-assistant',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './ai-assistant.component.html',
  styleUrls: ['./ai-assistant.component.scss']
})
export class AiAssistantComponent implements OnInit, AfterViewChecked {
  @ViewChild('chatContainer') private chatContainer!: ElementRef;

  role: string | null = null;
  userInput = '';
  isTyping = false;

  suggestedChips = [
    'Enrollment at ISG Tunis',
    'Dropout rate for ESCT',
    'List all institutions',
    'Success rate at INSAT'
  ];

  contextDocs = [
    { name: 'ESG_Policy_2024.pdf', indexed: true },
    { name: 'Budget_Report_Q3.pdf', indexed: true },
    { name: 'Academic_Strategy.pdf', indexed: true },
    { name: 'HR_Charter_2023.pdf', indexed: true },
  ];

  suggestedQuestions = [
    "What are today's critical alerts?",
    'Show me the worst-performing institution',
    'Forecast dropout rate for next semester',
    'Compare budget execution across all institutions',
    'What is the ESG status of ISSAT Manouba?',
    'Generate a monthly summary report'
  ];

  messages: Array<{role: 'user'|'ai', text: string, sources?: any[], table?: any[], recommendation?: string}> = [
    {
      role: 'ai',
      text: 'Hello! I am your U-OS Strategic Assistant. I have access to the UCAR institutional database and indexed policy documents. How can I help you today?'
    }
  ];

  constructor(private auth: AuthService, private aiService: AiService) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
  }

  ngAfterViewChecked() {
    this.scrollToBottom();
  }

  sendMessage(): void {
    const prompt = this.userInput.trim();
    if (!prompt || this.isTyping) return;

    // Add user message
    this.messages.push({ role: 'user', text: prompt });
    this.userInput = '';
    this.isTyping = true;

    // Call AI Service
    this.aiService.ask(prompt).subscribe({
      next: (resp: AiResponse) => {
        this.isTyping = false;
        this.messages.push({ 
          role: 'ai', 
          text: resp.result,
          sources: resp.sources
        });
      },
      error: (err) => {
        this.isTyping = false;
        this.messages.push({ 
          role: 'ai', 
          text: 'Sorry, I encountered an error connecting to the AI brain. Please make sure the backend is running.' 
        });
        console.error('AI Error:', err);
      }
    });
  }

  onChipClick(text: string): void {
    this.userInput = text;
    this.sendMessage();
  }

  clearChat(): void {
    if (confirm('Clear chat history?')) {
      this.messages = [
        {
          role: 'ai',
          text: 'Chat cleared. How else can I help you?'
        }
      ];
    }
  }

  private scrollToBottom(): void {
    try {
      this.chatContainer.nativeElement.scrollTop = this.chatContainer.nativeElement.scrollHeight;
    } catch (err) {}
  }
}
