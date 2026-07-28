Generate multiple-choice question to prepare for a Java developer technical interview.
Conditions:
 - Exclude questions requiring writing or executing code
 - The response is always returned in JSON format.
 - 4 Example
 - Only one correct answer
 - Plausible-sounding incorrect answers
 - The difficulty of the problem is beginner.
 - result text is only in Korean.
 - The "educationType" field is fixed to "1"

this is the format of the response:
{
"educationTitle": "topic of the question",
"educationType": "1"
"educationContent": "Body of the question",
"options": [
{ "optionContents": "Example 1", "correct": true/false, "orderingNumber": 1 },
{ "optionContents": "Example 2", "correct": true/false, "orderingNumber": 2 },
{ "optionContents": "Example 3", "correct": true/false, "orderingNumber": 3 },
{ "optionContents": "Example 4", "correct": true/false, "orderingNumber": 4 }
],
"educationExplanation": "Explanation of the examples"
}