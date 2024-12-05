// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"
//= require chartkick
//= require Chart.bundle

function toggleAccountModal(isOpen) {
  const modal = document.getElementById("account-modal");
  if (isOpen) {
    modal.classList.remove("hidden", "opacity-0");
    modal.classList.add("opacity-100");
    document.body.classList.add("overflow-hidden");
  } else {
    modal.classList.remove("opacity-100");
    modal.classList.add("opacity-0", "hidden");
    document.body.classList.remove("overflow-hidden");
  }
}

function toggleTransactionModal(isOpen) {
  const modal = document.getElementById("transaction-modal");
  if (isOpen) {
    modal.classList.remove("hidden", "opacity-0");
    modal.classList.add("opacity-100");
    document.body.classList.add("overflow-hidden");
  } else {
    modal.classList.remove("opacity-100");
    modal.classList.add("opacity-0", "hidden");
    document.body.classList.remove("overflow-hidden");
  }
}

document.addEventListener("input", function (event) {
  if (event.target.matches("input[type='number']")) {
      const maxLength = event.target.dataset.maxLength;
      if (maxLength && event.target.value.length > maxLength) {
          event.target.value = event.target.value.slice(0, maxLength);
      }
  }
});

// "turbo:load" is to reload the page after one of the modal forms is submitted
document.addEventListener("turbo:load", () => {
  const dateInput = document.getElementById("date_input");

  if (!dateInput) return;

  dateInput.addEventListener("input", (e) => {
    let input = e.target.value.replace(/\D/g, ""); // Remove non-numeric characters

    // Limit to 8 digits (MMDDYYYY)
    input = input.slice(0, 8);

    // Format as MM/DD/YYYY
    if (input.length >= 2) input = input.slice(0, 2) + '/' + input.slice(2);
    if (input.length >= 5) input = input.slice(0, 5) + '/' + input.slice(5);

    e.target.value = input;

    // Validate the date format and value
    if (input.length === 10) { // MM/DD/YYYY
      const [month, day, year] = input.split("/").map(Number);
      if (!isValidDate(month, day, year)) {
        e.target.setCustomValidity("Please enter a valid date (MM/DD/YYYY).");
      } else {
        e.target.setCustomValidity(""); // Reset validity if the date is valid
      }
    } else {
      e.target.setCustomValidity("");
    }
  });

  function isValidDate(month, day, year) {
    // Check if year, month, and day are valid
    const date = new Date(year, month - 1, day); // JavaScript Date month is 0-indexed
    return (
      date.getFullYear() === year &&
      date.getMonth() === month - 1 &&
      date.getDate() === day
    );
  }
});

// Expose the function to the window object making it a global function
window.toggleAccountModal = toggleAccountModal;
window.toggleTransactionModal = toggleTransactionModal;