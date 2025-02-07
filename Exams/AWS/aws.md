# Section 1: Multiple Choice Questions (MCQs)

## 1. AWS Core Services

**Which AWS service is used to store objects such as images, videos, and backups?**  
C) S3

**What is the purpose of an AWS Availability Zone?**  
A) It ensures high availability by distributing resources across multiple locations.

**What is the default storage class for an S3 bucket when you create it?**  
C) S3 Standard

## 2. IAM & Security

**What is the purpose of an IAM role?**  
A) It is used to assign permissions to AWS services and users.

**In AWS IAM, what is the best practice for securing your root account?**  
B) Use it only for creating IAM users and enable Multi-Factor Authentication (MFA).

## 3. Networking and Connectivity

**What is the purpose of an Internet Gateway in AWS?**  
B) To provide internet access to resources in a private subnet.

**What is the main difference between a Security Group and a Network ACL?**  
A) Security Groups operate at the instance level, while NACLs operate at the subnet level.

## 4. Storage & Databases

**Which AWS service provides a managed relational database service?**  
B) RDS

**What happens if you delete an S3 bucket with objects inside it?**  
B) The bucket is deleted, and all objects inside it are permanently removed.

## 5. AWS Billing & Pricing

**Which AWS pricing model allows you to pay only for the computing resources you use?**  
C) Pay-as-you-go

**What tool in AWS helps users monitor their spending and set budget alerts?**  
A) AWS Cost Explorer

# Section 2: Research-based AWS Questions (Using Google Only)

**What are AWS Landing Zones, and how do they help with multi-account governance?**

<div dir="rtl">אזור נחיתה (Landing Zone) הוא הגדרה מוקדמת של סביבת AWS מרובת חשבונות, המשמשת כנקודת התחלה לפריסת עומסי עבודה ואפליקציות.  
הוא מספק בסיס לניהול חשבונות, אבטחה, עיצוב רשתות ורישום לוגים.</div>

**Explain how AWS WAF protects web applications from common attacks.**

<div dir="rtl">AWS WAF מגן על יישומי אינטרנט על ידי ניטור בקשות HTTP/S לחסימת מתקפות כמו SQL Injection ו-XSS.  
הוא משתמש בתכונות כמו רשימות בקרת גישה (ACLs), חוקים וקבוצות חוקים כדי לספק אבטחה מקיפה.</div>

**What is AWS Snowball, and when should it be used?**

<div dir="rtl">AWS Snowball הוא שירות המספק מכשירים מאובטחים וקשיחים (פיזיים) שמביאים יכולות מחשוב ואחסון של AWS לסביבות קצה.  
מכשירים אלה מסייעים בהעברת נתונים אל AWS וממנו, והם מוכרים בשם Snowball או Snowball Edge.</div>

**What are the key differences between AWS Backup and manual snapshot backups?**

<div dir="rtl">צילום מצב (Snapshot) ב-AWS הוא עותק בנקודת זמן של נפח EBS עם אפשרויות אחסון ושחזור מוגבלות.  
גיבוי EC2 הוא פתרון גיבוי גמיש ומקיף יותר עבור עומסי עבודה בענן, המבטיח הגנה אמינה ושחזור מהיר.</div>

**How does AWS Shield help mitigate DDoS attacks?**

<div dir="rtl">AWS Shield מפחית אוטומטית מתקפות DDoS על ידי יצירה ופריסה של חוקים מותאמים ב-AWS WAF.  
הוא גם מספק גישה ל-AWS WAF ללא עלות נוספת להגנה מפני מתקפות DDoS בשכבת היישום באמצעות CloudFront או Application Load Balancer.</div>

**Explain the differences between AWS Transit Gateway and VPC Peering.**

<div dir="rtl">AWS Transit Gateway מפשט ניהול רשתות בקנה מידה גדול על ידי חיבור מספר VPCs ורשתות מקומיות, מה שמפחית את העומס.  
לעומת זאת, VPC Peering מקשר ישירות בין שני VPCs, אך הופך למורכב וקשה יותר לניהול בסביבות גדולות.</div>

**What is AWS Step Functions, and how does it help with workflow automation?**

<div dir="rtl">AWS Step Functions הוא שירות זרימת עבודה חזותי המסייע למפתחים להפוך תהליכים לאוטומטים, לנהל מיקרושירותים,  
ולבנות יישומים מבוזרים, כולל piplines ולמידת מכונה (ML) באמצעות שירותי AWS.</div>

**How does AWS Control Tower assist organizations in managing multiple AWS accounts?**

<div dir="rtl">AWS Control Tower מספק מסגרת ניהולית מרכזית שמפשטת את הקמת "Landing Zones", ומאפשר ניהול אבטחה, תאימות וסטנדרטים בין חשבונות AWS.  
הוא מקים ומנהל את המדיניות והמדדים בצורה אוטומטית דרך AWS Organizations ו-AWS Service Catalog.</div>

**What is the significance of AWS Outposts in hybrid cloud solutions?**

<div dir="rtl">AWS Outposts מביא את התשתיות והשירותים של AWS לסביבות מקומיות, ומספק חווית ענן היברידית אחידה.  
הוא מאפשר לארגונים להריץ שירותי AWS באופן מקומי ולשלב אותם בצורה חלקה עם ענן AWS לניהול מאוחד.</div>

**Explain the key use cases for AWS Elastic File System (EFS) compared to S3 and EBS.**

<div dir="rtl">AWS Elastic File System (EFS) מיועד למערכות קבצים משותפות, בהן מספר מופעי EC2 יכולים לגשת לאותו מידע בו זמנית.  
בניגוד ל-S3 ול-EBS, אשר מיועדים לאחסון אובייקטים ודיסקים קשיחים, EFS מספק אחסון קבצים גמיש, בו ניתן לבצע קריאות וכתיבות מקבילות ממספר מופעים בבת אחת.  
EFS תומך בפרוטוקול NFS (Network File System), שמאפשר לשירותים שונים ומחשבים שונים לשתף נתונים בצורה חלקה.  
היכולת להתרחב באופן אוטומטי בהתאם לצרכים ולבצע גיבויים באופן שקוף הופכת את EFS לפתרון מצוין לאחסון נתונים הדורשים גישה משותפת ומקבילית.</div>
