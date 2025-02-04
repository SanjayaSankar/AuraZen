async function generateDietPlan() {
    const goal = document.getElementById('goal').value;
    const response = await fetch('https://api.openai.com/v1/engines/text-davinci-002/completions', {
        method: 'POST',
        headers: {
            'Authorization': 'Bearer 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',
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            prompt: `Generate a diet plan for ${goal} goals and other preferences...`,
            max_tokens: 150,
        }),
    });

    const data = await response.json();
    const dietPlan = data.choices[0].text;

    document.getElementById('diet-plan').innerHTML = `<h2>Your Custom Diet Plan:</h2><p>${dietPlan}</p>`;
}
