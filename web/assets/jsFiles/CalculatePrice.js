/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
let selectedVehicleType = '';

function selectVehicle(vehicleType) {
    // Highlight the selected vehicle
    const options = document.querySelectorAll('.vehicle-option');
    options.forEach(option => {
        option.classList.remove('selected');
    });
    event.currentTarget.classList.add('selected');
    
    // Update the hidden input
    document.getElementById('vehicleType').value = vehicleType;
    selectedVehicleType = vehicleType;
    
    // Recalculate price if both locations are selected
    calculatePrice();
}

// Function to calculate price
function calculatePrice() {
    const pickupLocationId = document.getElementById('pickupLocation').value;
    const dropLocationId = document.getElementById('dropLocation').value;
    
    if (pickupLocationId && dropLocationId && selectedVehicleType) {
        // Create XMLHttpRequest object
        const xhr = new XMLHttpRequest();
        
        // Configure the request
        xhr.open('GET', 'calculatePrice?fromLocationID=' + pickupLocationId + 
                '&toLocationID=' + dropLocationId + 
                '&vehicleType=' + selectedVehicleType, true);
        
        // Set up the callback function
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // Update the price section with the response
                document.querySelector('.price-section').innerHTML = xhr.responseText;
            }
        };
        
        // Send the request
        xhr.send();
    }
}

// Add event listeners to the location dropdowns
document.getElementById('pickupLocation').addEventListener('change', calculatePrice);
document.getElementById('dropLocation').addEventListener('change', calculatePrice);

// Add validation function
function validateForm() {
    let isValid = true;
    
    // Check if a vehicle type is selected
    if (!document.getElementById('vehicleType').value) {
        alert('Please select a vehicle type');
        isValid = false;
        return;
    }
    
    // Check the name field
    const name = document.getElementById('name').value;
    if (!name) {
        document.getElementById('nameError').innerText = 'Name is required';
        isValid = false;
    } else {
        document.getElementById('nameError').innerText = '';
    }
    
    // Check the mobile field
    const mobile = document.getElementById('mobile').value;
    if (!mobile) {
        document.getElementById('mobileError').innerText = 'Mobile number is required';
        isValid = false;
    } else if (!/^[0-9]{10}$/.test(mobile)) {
        document.getElementById('mobileError').innerText = 'Invalid mobile number';
        isValid = false;
    } else {
        document.getElementById('mobileError').innerText = '';
    }
    
    // Check date and time
    const date = document.getElementById('date').value;
    const time = document.getElementById('time').value;
    
    if (!date) {
        document.getElementById('dateError').innerText = 'Date is required';
        isValid = false;
    } else {
        document.getElementById('dateError').innerText = '';
    }
    
    if (!time) {
        document.getElementById('timeError').innerText = 'Time is required';
        isValid = false;
    } else {
        document.getElementById('timeError').innerText = '';
    }
    
    // Check pickup and drop locations
    const pickup = document.getElementById('pickupLocation').value;
    const drop = document.getElementById('dropLocation').value;
    
    if (!pickup) {
        document.getElementById('pickupError').innerText = 'Pickup location is required';
        isValid = false;
    } else {
        document.getElementById('pickupError').innerText = '';
    }
    
    if (!drop) {
        document.getElementById('dropError').innerText = 'Drop location is required';
        isValid = false;
    } else {
        document.getElementById('dropError').innerText = '';
    }
    
    // Check if pickup and drop are the same
    if (pickup && drop && pickup === drop) {
        document.getElementById('dropError').innerText = 'Pickup and drop locations cannot be the same';
        isValid = false;
    }
    
    // Check address
    const address = document.getElementById('address').value;
    if (!address) {
        document.getElementById('addressError').innerText = 'Address is required';
        isValid = false;
    } else {
        document.getElementById('addressError').innerText = '';
    }
    
    if (isValid) {
        // If all validations pass, submit the form
        document.getElementById('bookingForm').submit();
    }
}

