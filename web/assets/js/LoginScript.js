/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener("DOMContentLoaded", () => {
    toggleFields();
    document.querySelector("form").addEventListener("submit", cleanFormData);
});

function toggleFields() {
    const urlParams = new URLSearchParams(window.location.search);
    const userType = urlParams.get("user") || "customer"; // Default to customer
    
    document.getElementById("userType").value = userType; // Set hidden field value

    if (userType === "driver") {
        document.getElementById("customerFields").style.display = "none";
        document.getElementById("driverFields").style.display = "block";
    } else {
        document.getElementById("customerFields").style.display = "block";
        document.getElementById("driverFields").style.display = "none";
    }
}

function cleanFormData(event) {
    event.preventDefault(); // Prevent default form submission

    const form = event.target;
    const formData = new FormData(form);
    const userType = document.getElementById("userType").value;

    // Remove irrelevant fields
    if (userType === "customer") {
        ["driverName", "phoneNo", "license_number", "model", "year", "plate_number"].forEach(field => {
            formData.delete(field);
        });
    } else if (userType === "driver") {
        ["customername", "phoneNumber", "address", "nic"].forEach(field => {
            formData.delete(field);
        });
    }

    // Create a new form with only the required data
    const cleanedForm = new URLSearchParams();
    for (const [key, value] of formData.entries()) {
        if (value.trim() !== "") {
            cleanedForm.append(key, value);
        }
    }

    // Submit the form with cleaned data
    fetch(form.action, {
        method: form.method,
        body: cleanedForm,
        headers: { "Content-Type": "application/x-www-form-urlencoded" }
    }).then(response => {
        if (response.redirected) {
            window.location.href = response.url;
        } else {
            return response.text();
        }
    }).then(data => {
        console.log(data);
    }).catch(error => console.error("Error:", error));
}


