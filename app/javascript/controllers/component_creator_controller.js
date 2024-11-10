import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["name", "properties"]
  
  async create(event) {
    event.preventDefault()
    
    const name = this.nameTarget.value
    const properties = this.getProperties()
    
    try {
      const response = await fetch('/components/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({ name, properties })
      })
      
      if (response.ok) {
        // Refresh component library
        window.location.reload()
      } else {
        console.error('Failed to create component')
      }
    } catch (error) {
      console.error('Error creating component:', error)
    }
  }
  
  getProperties() {
    const properties = {}
    this.propertiesTargets.forEach(prop => {
      const name = prop.querySelector('[data-property-name]').value
      const type = prop.querySelector('[data-property-type]').value
      if (name) {
        properties[name] = type
      }
    })
    return properties
  }
} 