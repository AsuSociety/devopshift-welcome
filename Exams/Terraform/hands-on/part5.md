Task 5: Debugging and Fixing Terraform Issues
Given a misconfigured Terraform file, identify and fix the following errors:
Invalid provider configuration
Incorrect security group rules
Missing IAM permissions for Terraform to create resources

<div dir="rtl">
תשובה-

במידה וקיבלנו קובץ Terraform שגוי ואנו רוצים לאתר את הבעיות נעבוד באופן הבא-
ראשית נתחיל בהפעלת terraform validate בשביל לבדוק אם יש שגיאות תחביר ובנוסף נריץ terraform plan לזיהוי בעיות תצורה.
במידה ויש תצורת ספק לא חוקית (invalid provider), נוודא שהספק הנכון צוין בבלוק הספק עם הגרסה הנדרשת ואישורי האימות.
אם אנחנו משתמשים ב-AWS, נאמת את מפתח הגישה, המפתח הסודי וה-region ב-~/.aws/credentials או במשתני סביבה.
אם יש לנו כללי קבוצת אבטחה שגויים, קודם כל נסקור את כללי הכניסה והיציאה (ingress/egress) כדי לוודא שהם מאפשרים תעבורה מיועדת. לאחר מכן נודא כי החסימות CIDR, פורטים ופרוטוקולים אכן תואמים למדיניות הגישה הרצויה.
לבסוף, אם ל-Terraform אין מספיק הרשאות ליצירת משאבים, נעדכן את מדיניות ה-IAM שלו כדי לאפשר פעולות נדרשות (כמו למשל, ec2:CreateSecurityGroup בשביל קבוצות אבטחה). אם עדיין מתרחשות שגיאות, נפיעל את Terraform במצב debug
(TF_LOG=DEBUG terraform apply) על מנת שנקבל את הפרטים בקבצי log מסודרים. לאחר שסיימנו לסדר הכל נריץ - terraform plan על מנת לוודא שאכן הכל תקין לקראת ההרצה :)

</div>
