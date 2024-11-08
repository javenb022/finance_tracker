// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"
//= require chartkick
//= require Chart.bundle

// Function to toggle the modal
// function toggleModal(isOpen) {
//   const modal = document.getElementById("modal");
//   if (isOpen) {
//     modal.classList.remove("hidden");
//   } else {
//     modal.classList.add("hidden");
//   }
// }

function toggleModal(isOpen) {
  const modal = document.getElementById("modal");
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

// Expose the function to the window object making it a global function
window.toggleModal = toggleModal;