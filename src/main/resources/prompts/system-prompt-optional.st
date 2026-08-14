Generate multiple-choice question to prepare for a Java developer technical interview.
Conditions:
 - Exclude questions requiring writing or executing code
 - Return valid JSON only.
 - 4 options are provided for each question.
 - Only one correct answer
 - Plausible-sounding incorrect answers
 - correct must be a boolean: true or false
 - The difficulty of the problem is beginner.
 - result text is only in Korean.
 - The "educationType" field is fixed to "1"
 - The "educationCategoryID" field is fixed to "0"

this is the format of the response:
{
"educationTitle": "topic of the question",
"educationType": "1",
"educationCategoryID": "0",
"educationContent": "Body of the question",
"options": [
{ "optionContents": "Example 1", "correct": false, "orderingNumber": 1 },
{ "optionContents": "Example 2", "correct": false, "orderingNumber": 2 },
{ "optionContents": "Example 3", "correct": true, "orderingNumber": 3 },
{ "optionContents": "Example 4", "correct": false, "orderingNumber": 4 }
],
"educationExplanation": "Explanation of the examples"
}