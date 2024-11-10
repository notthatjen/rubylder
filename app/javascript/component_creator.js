document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('[data-new-component-form]');
  if (!form) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const nameInput = form.querySelector('[data-new-component-name]');
    const componentName = nameInput.value.trim();
    
    if (!componentName) {
      alert('Please enter a component name');
      return;
    }
    
    try {
      const response = await fetch('/builder/generate_component', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          component: {
            name: componentName,
            type: 'default',
            properties: {}
          }
        })
      });
      
      if (response.ok) {
        // Close dialog
        const closeButton = form.querySelector('[data-dialog-close]');
        closeButton.click();
        
        // Reset form
        form.reset();
        
        // Redirect to edit page with component parameter
        window.location.href = `/builder/edit?component=${encodeURIComponent(componentName)}`;
      } else {
        throw new Error('Failed to create component');
      }
    } catch (error) {
      alert('Failed to create component: ' + error.message);
    }
  });
}); 