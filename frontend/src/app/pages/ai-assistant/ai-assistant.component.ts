import { Component, OnInit, ElementRef, ViewChild, AfterViewChecked } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';
import { AiService, AiResponse } from '../../core/services/ai.service';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

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
  loadingMessage = 'Thinking...';
  private loadingMessages = [
    'Thinking...',
    'Analyzing network metrics...',
    'Querying UniGov database...',
    'Reviewing policy context...',
    'Generating strategic insights...'
  ];
  private loadingInterval: any;

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

  messages: Array<{role: 'user'|'ai', text: string, safeText?: SafeHtml, sources?: any[], table?: any[], recommendation?: string}> = [
    {
      role: 'ai',
      text: 'Hello! I am your UniGov Strategic Assistant. I have access to the UniGov institutional database and indexed policy documents. How can I help you today?'
    }
  ];

  constructor(private auth: AuthService, private aiService: AiService, private sanitizer: DomSanitizer) {
    this.messages.forEach(m => m.safeText = this.formatMessage(m.text));
  }

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
    this.messages.push({ 
      role: 'user', 
      text: prompt,
      safeText: this.formatMessage(prompt)
    });
    this.userInput = '';
    this.isTyping = true;
    this.startLoadingAnimation();

    // Call AI Service
    this.aiService.ask(prompt).subscribe({
      next: (resp: AiResponse) => {
        this.isTyping = false;
        this.stopLoadingAnimation();
        this.messages.push({ 
          role: 'ai', 
          text: resp.result,
          safeText: this.formatMessage(resp.result),
          sources: resp.sources
        });
      },
      error: (err) => {
        this.isTyping = false;
        this.stopLoadingAnimation();
        const errorText = 'Sorry, I encountered an error connecting to the AI brain. Please make sure the backend is running.';
        this.messages.push({ 
          role: 'ai', 
          text: errorText,
          safeText: this.formatMessage(errorText)
        });
        console.error('AI Error:', err);
      }
    });
  }

  private startLoadingAnimation(): void {
    let index = 0;
    this.loadingMessage = this.loadingMessages[0];
    this.loadingInterval = setInterval(() => {
      index = (index + 1) % this.loadingMessages.length;
      this.loadingMessage = this.loadingMessages[index];
    }, 2000);
  }

  private stopLoadingAnimation(): void {
    if (this.loadingInterval) {
      clearInterval(this.loadingInterval);
    }
  }

  formatMessage(text: string): SafeHtml {
    if (!text) return '';

    let formatted = text;

    // 1. Basic Markdown-like formatting
    formatted = formatted.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    formatted = formatted.replace(/\*(.*?)\*/g, '<em>$1</em>');

    // 2. Symbol Replacement (Meaningful text)
    const symbols: {[key: string]: string} = {
      '->': '→',
      '=>': '⇒',
      'sigma': 'Σ',
      'delta': 'Δ',
      'gamma': 'Γ',
      'alpha': 'α',
      'beta': 'β',
      'pi': 'π',
      'sum': 'Σ',
      'avg': 'x̄',
      '>=': '≥',
      '<=': '≤',
      '!=': '≠',
      '\\^2': '²',
      '\\^3': '³',
      '\\^n': 'ⁿ'
    };

    Object.keys(symbols).forEach(key => {
      const regex = new RegExp(key, 'gi');
      formatted = formatted.replace(regex, symbols[key]);
    });

    // 3. Equation detection (simple heuristic: contains = and some math operators)
    const lines = formatted.split('\n');
    const processedLines = lines.map(line => {
      if (line.includes('=') && (line.match(/[+\-*/ΣΔπ]/) || line.match(/[a-zA-Z]\d/))) {
        return `<div class="equation-block">${line}</div>`;
      }
      return line;
    });
    
    formatted = processedLines.join('<br>');

    return this.sanitizer.bypassSecurityTrustHtml(formatted);
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
