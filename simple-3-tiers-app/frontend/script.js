document.addEventListener("DOMContentLoaded", async () => {
    const messageElement = document.querySelector(".backend-message");
    const visitsCounterElement = document.querySelector(".visits-counter");

    try {
        const response = await fetch(`/api/app`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
        });
        const data = await response.json();

        visitsCounterElement.textContent = data.data;
        messageElement.textContent = 'Backend connected successfully!';
    } catch (error) { messageElement.textContent = "Failed to connect to backend"; }
});