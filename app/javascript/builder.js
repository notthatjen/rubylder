document.addEventListener('DOMContentLoaded', () => {
  initializeBuilder();
});

function initializeBuilder() {
  const canvas = document.querySelector('[data-builder-canvas]');
  const items = document.querySelectorAll('[data-builder-item]');
  const propertiesPanel = document.querySelector('[data-properties-panel]');
  
  // Initialize drag and drop
  initializeDragAndDrop(items, canvas);
  
  // Initialize properties panel
  initializePropertiesPanel(propertiesPanel);
  
  // Initialize canvas interactions
  initializeCanvasInteractions(canvas);
}

function initializeDragAndDrop(items, canvas) {
  items.forEach(item => {
    item.addEventListener('dragstart', handleDragStart);
  });
  
  canvas.addEventListener('dragover', handleDragOver);
  canvas.addEventListener('drop', handleDrop);
}

function initializePropertiesPanel(panel) {
  const addPropertyButton = panel.querySelector('[data-action="add-property"]');
  const saveButton = panel.querySelector('[data-action="save-component"]');
  
  addPropertyButton.addEventListener('click', handleAddProperty);
  saveButton.addEventListener('click', handleSaveComponent);
}

function initializeCanvasInteractions(canvas) {
  canvas.addEventListener('click', (e) => {
    const element = e.target.closest('[data-canvas-element]');
    if (element) {
      selectElement(element);
    }
  });
}

// Event Handlers
function handleDragStart(e) {
  const item = e.target;
  e.dataTransfer.setData('type', item.dataset.type);
  e.dataTransfer.setData('name', item.dataset.name);
}

function handleDragOver(e) {
  e.preventDefault();
  showDropIndicator(e.clientX, e.clientY);
}

function handleDrop(e) {
  e.preventDefault();
  const type = e.dataTransfer.getData('type');
  const name = e.dataTransfer.getData('name');
  
  addElementToCanvas(type, name, e.clientX, e.clientY);
}

// Helper Functions
function addElementToCanvas(type, name, x, y) {
  const element = createCanvasElement(type, name);
  positionElement(element, x, y);
  updateComponentTree();
}

function selectElement(element) {
  // Update properties panel with element's properties
  showElementProperties(element);
}

function updateComponentTree() {
  // Implement your updateComponentTree logic here
} 