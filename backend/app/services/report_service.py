from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
import io
import pandas as pd
from datetime import datetime

class ReportService:
    @staticmethod
    def generate_pdf_report(title: str, data: list):
        buffer = io.BytesIO()
        doc = SimpleDocTemplate(buffer, pagesize=letter)
        styles = getSampleStyleSheet()
        elements = []

        # Title
        elements.append(Paragraph(f"UCAR - {title}", styles['Title']))
        elements.append(Paragraph(f"Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}", styles['Italic']))
        elements.append(Spacer(1, 12))

        # Data Table
        if data:
            # Create table header from dict keys
            header = [k.replace('_', ' ').title() for k in data[0].keys()]
            raw_keys = list(data[0].keys())
            
            # Wrap data in Paragraphs to prevent bleeding off page
            table_data = [header]
            for row in data:
                wrapped_row = []
                for k in raw_keys:
                    val = str(row.get(k, ""))
                    # Use a smaller font style for table content
                    wrapped_row.append(Paragraph(val, styles['Normal']))
                table_data.append(wrapped_row)

            # Auto-calculate column widths (rough estimate for 7.5 inches usable width)
            col_width = 540 / len(header)
            
            t = Table(table_data, colWidths=[col_width] * len(header))
            t.setStyle(TableStyle([
                ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
                ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
                ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
                ('VALIGN', (0, 0), (-1, -1), 'TOP'),
                ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
                ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
                ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
                ('GRID', (0, 0), (-1, -1), 1, colors.black)
            ]))
            elements.append(t)
        else:
            elements.append(Paragraph("No data available for this selection.", styles['Normal']))

        doc.build(elements)
        buffer.seek(0)
        return buffer

    @staticmethod
    def generate_excel_report(data: list):
        buffer = io.BytesIO()
        df = pd.DataFrame(data)
        if df.empty:
             df = pd.DataFrame([{"Message": "No data available for this report"}])
             
        with pd.ExcelWriter(buffer, engine='openpyxl') as writer:
            df.to_excel(writer, index=False, sheet_name='UCAR Report')
        buffer.seek(0)
        return buffer

report_service = ReportService()
