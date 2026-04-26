from db.supabase import supabase
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

class AlertService:
    @staticmethod
    async def create_alert(institution_id: str, kpi_id: str, title: str, message: str, severity: str = "medium"):
        """
        Creates an alert in the database. This can be triggered by the anomaly detection logic.
        """
        try:
            res = supabase.table("alerts").insert({
                "institution_id": institution_id,
                "kpi_id": kpi_id,
                "title": title,
                "message": message,
                "severity": severity,
                "created_at": datetime.utcnow().isoformat(),
                "status": "unread"
            }).execute()
            
            # In a real app, we would also trigger a push notification (WebSockets/Push API) here.
            logger.info(f"Proactive Alert Created: {title} for Institution {institution_id}")
            return res.data
        except Exception as e:
            logger.error(f"Error creating alert: {str(e)}")
            return None

    @staticmethod
    async def get_unread_alerts(institution_id: str):
        res = supabase.table("alerts").select("*").eq("institution_id", institution_id).eq("status", "unread").execute()
        return res.data

alert_service = AlertService()
