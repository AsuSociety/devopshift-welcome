# Terraform Exam Q&A

## Section 1: Q&A (20 Questions)

### Terraform Fundamentals (5 Questions)

#### What is Terraform and how does it differ from other IaC tools?

<div dir="rtl"> 
terraform הוא כלי קוד פתוח שנכתב על ידי HashiCorp לניהול, פרישה והשקת משאבי תשתית. הוא מאפשר לך לנהל תשתית על פני ספקי ענן שונים (AWS, Azure, GCP) באמצעות כלי אחד. בניגוד לכלים אחרים לניהול תשתית כקוד, terraform משתמש בגישה דקלרטיבית, שבה אתה מגדיר את מצב התשתית הרצוי, והוא מטפל אוטומטית בתהליך הגעת המערכת למצב זה.
</div>

#### Explain Terraform's declarative nature and state management.

<div dir="rtl"> 
הגישה הדקלרטיבית של terraform אומרת שאתה מגדיר את מצב התשתית הרצוי, ו-terraform מנהל את השלבים כדי להגיע למצב הזה. ניהול המצב עוקב אחר ההגדרה הנוכחית בקובץ המצב, ומאפשר ל-terraform לבצע שינויים כדי להתאים את המערכת לקונפיגורציה הרצויה.
</div>

#### What is the purpose of the Terraform provider?

<div dir="rtl"> 
ספק terraform אחראי לניהול האינטראקציות בין terraform לשירותי ענן או APIs. הוא מאפשר ל-terraform ליצור, לקרוא, לעדכן ולמחוק משאבים מפלטפורמות שונות כמו AWS, Azure או GCP.
</div>

#### How does Terraform handle dependency resolution?

<div dir="rtl"> 
terraform מנהל תלויות באמצעות הצהרות משתמעות (implicit) ומפורשות (explicit) . תלויות משתמעות מגיעות על ידי הפניות למשאבים, בעוד שתלויות מפורשות נעשות באמצעות הארגומנט depends_on.
</div>

#### What are the key components of a Terraform configuration file?

The key components of a Terraform configuration file are:

- **Providers** (cloud service integrations)
- **Resources** (infrastructure elements)
- **Variables** (input values)
- **Outputs** (exported values)
- **Modules** (reusable configurations)

---

### State Management & Backend Configuration (3 Questions)

#### Explain the difference between `terraform refresh`, `terraform plan`, and `terraform apply`.

<div dir="rtl">

- `terraform refresh` מעדכן את קובץ המצב כך שיתאם את התשתית האמיתית.

- `terraform plan` מציג את השינויים ש-terraform יעשה מבלי לבצע אותם.
- `terraform apply` מבצע את השינויים כדי להתאים את המערכת לקונפיגורציה הרצויה.
</div>

#### What is the difference between local and remote backends?

<div dir="rtl"> 
אחסון מקומי שומר את קובץ המצב של terraform על המחשב המקומי, בעוד שאחסון מרוחק שומר אותו בשירות מרוחק כמו AWS S3 או Terraform Cloud. אחסונים מרוחקים מאפשרים שיתוף פעולה ונעילת מצב, ומונעים קונפליקטים בסביבות עבודה צוותיות.</div>

#### How can you prevent state corruption when multiple engineers work on the same infrastructure?

<div dir="rtl"> 
אפשר להמנע על ידי שימוש באחסון מרוחק עם נעילת מצב, כמו AWS S3 עם DynamoDB או Terraform Cloud, כדי למנוע קונפליקטים. זה מבטיח שרק מהנדס אחד יוכל לשנות את המצב בו זמנית, ומונע מצב של corruption.
</div>

---

### Terraform Modules & Reusability (4 Questions)

#### What are the benefits of using Terraform modules?

<div dir="rtl"> 
מודולים של terraform הופכים את הקונפיגורציות לשימוש חוזר, מאורגנות וקלות לניהול. הם עוזרים לצמצם שיכפול קוד, לשפר סקלביליות, ולפשט את פריסת התשתית המורכבת.
</div>

#### Explain how to pass variables to a Terraform module.

Variables can be passed to a Terraform module using:

- `variables.tf` files
- Command-line flags (`-var`)
- Environment variables
- `.tfvars` files

These methods allow dynamic configuration without modifying the module's code.

#### What is the difference between `count` and `for_each`?

<div dir="rtl">

- `count` משמש ליצירת משאבים זהים מרובים בהתבסס על מספר כלשהו.
- `for_each` משמש ליצירת משאבים מ- array, map או list, ומאפשר לקבוע מאפיינים ייחודיים לכל משאב.
</div>

#### How do you source a module from a Git repository?

<div dir="rtl"> 
אתה יכול להוציא מודול של terraform מתוך מאגר Git באמצעות ארגומנט source כך, לדוגמה:

```hcl
source = "git::https://github.com/AsuSociety/devopshift-welcome/tree/workshop/terraform/Exams"
```

</div>

---

### Terraform with AWS (4 Questions)

#### How do you create an EC2 instance with Terraform?

Define an `aws_instance` resource in the configuration file, specifying parameters like `ami`, `instance_type`, and `key_name`. Then, run `terraform apply` to create the instance.

#### What are the required fields for defining a VPC in Terraform?

To define a VPC in Terraform, you need to specify at least the `cidr_block`. Optional fields include `enable_dns_support`, `enable_dns_hostnames`, and tags for additional customization.

#### Explain how Terraform manages IAM policies in AWS.

<div dir="rtl"> 
terraform מגדיר את מדיניות IAM של AWS בקבצי קונפיגורציה, ומבטיח אבטחה וארגון. terraform מנהל את המדיניות כקוד, מה שהופך את בקרת הגישה לשחזורית ומדרגית.
</div>

#### How do you use Terraform to provision and attach an Elastic Load Balancer?

Use the `aws_lb` resource to create an Elastic Load Balancer and the `aws_lb_target_group` to define where traffic is routed. Then, attach instances using `aws_lb_target_group_attachment` and configure listeners with `aws_lb_listener`.

---

### Debugging & Error Handling (4 Questions)

#### What does the `terraform validate` command do?

<div dir="rtl"> 
הפקודה terraform validate בודקת את הסינטקס והמבנה של קבצי הקונפיגורציה, ומוודאת שהתכנים והערכים מוגדרים כראוי. היא מאמתת את הסינטקס הבסיסי של terraform ומוודאת שההגדרות של הספקים נכונות.

</div>

#### How can you debug Terraform errors effectively?

<div dir="rtl">

בעזרת אפשור קבצי log על ידי הפקודה TF_LOG="DEBUG" ולאחר מכן בדיקת קובץ המצב של terraform למציאת בעיות. השתמש בפקודת terraform plan כדי להציג את השינויים ו-terraform apply -auto-approve לצורך בדיקת תיקונים.

</div>

#### What is Terraform’s `ignore_changes` lifecycle policy used for?

<div dir="rtl">

תכונת `ignore_changes` מונעת עדכון של תכונות מסוימות שעשויות להשתנות עם הזמן אך לא אמורות להשפיע על המשאב לאחר יצירתו. זה עוזר לשמור על יציבות בסביבות דינמיות.

</div>

#### How do you import existing AWS infrastructure into Terraform?

<div dir="rtl">

השתמש בפקודת `terraform import` עם סוג המשאב וה-ID של המשאב ב-AWS כדי להכניס תשתית קיימת ל-terraform. לאחר מכן, הגדר את המשאב בקונפיגורציה כך שיתאים למצב המיובא.

</div>
