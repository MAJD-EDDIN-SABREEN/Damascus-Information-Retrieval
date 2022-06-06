Damascus Information Retrieval It is a project for a search engine in Python and flutter web
 using a NLTK library and flask API
توصيف خطوات المشروع :

الخطوة الأولى (pre_processing)  :

في هذه المرحلة قمنا بتقسيم dataset الى مجموعة من documents عن طريق
 regular expression وقمنا بحذف الاحرف الخاصة مثل (.$#)  وحذف stop words 
ومن ثم قمنا بتجذير الكلمات stemming و تحويل الأفعال غير النظامية إلى أفعال نظامية ومن ثم قمنا بانشاء dictionary يحتوي على key وهو كلمة و value وهي عدد document التي وردت فيها هذه الكلمة وبالمثل لملف querys
الخطوة الثانية indexing)) :
في هذه المرحلة قمنا باستخدام خوارزمية tf_idf حيث tf هو تكرار الكلمة في document واحدة و IDF هو عدد كل DOCUMENT إلى عدد DOCUMENT التي وردت فيها هذه الكلمة وtf_idf هو حاصل ضرب tf ب idf وفي نهاية هذه المرحلة قمنا بإنشاء dictionary فيه الكلمة وبأي document  موجودة وحاصل tf_idf وبالمثل لملف querys 
الخطوة الثالثة (matching)   :
في هذه المرحلة قمنا باخذ أبعاد querys وأبعاد documents الناتجة عن مرحلة indexing وقمنا بعملية المطابقة عن طريق قانون cosine similarity وفي النهاية قمنا بإنشاء dictionary يحتوي على رقم query رقم document نسبة التطابق 
الخطوة الرابعة evalution  :
في هذه المرحلة قمنا بتقييم النتائج التي حصلنا عليه وحساب precision و recall لكل query  و mean average precision(MAP) و Mean Reciprocal Rank(MRR) و precision@10
بنية النظام :
بنية النظام هي model view controller تم استخدام flask API لاعطاء لكل service 
Route خاص بها حيث أن لدينا 4 services وهما :
1-pre processing
2-Indexing 
3-research 
4-evalution 
وتم تصميم الواجهات باستخدام flutter web وتمت عملية التواصل بين search UI و API 
باستخدام بروتوكول HTTP 
الميزة الإضافية :
Query refinement(query suggestion,query autocompletion) 
تم تحقيق ذلك من خلال front_end 
ليس لهذه الميزة أثر على نتائج التقييم 
