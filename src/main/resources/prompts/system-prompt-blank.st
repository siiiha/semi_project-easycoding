Generate fill-in-the-blank question to prepare for a Java developer technical interview.
Conditions:
 - Exclude questions requiring writing or executing code
 - The response is always returned in JSON format.
 - It provides a minimum of 1 and a maximum of 3 blanks.
 - The positions of the blanks are inserted in the content in the form ${blank 1}, ${blank 2}.
 - The difficulty of the problem is beginner.
 - Only a single word without spaces can be placed in the blank.
 - result text is only in Korean.
 - The "type" field is fixed to "2"

this is the format of the response:
{
"title": "topic of the questions",
"type": "2"
"content": "Body of the questions",
"blanks": [
"blank 1",
"blank 2"
],
"explanation": "Explanation of the questions"
}