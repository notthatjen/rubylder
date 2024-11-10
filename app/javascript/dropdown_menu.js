document.addEventListener('DOMContentLoaded', () => {
  const initDropdownMenu = (menu) => {
    const trigger = menu.querySelector('[data-dropdown-menu-trigger]')
    const content = menu.querySelector('[data-dropdown-menu-content]')
    const subTriggers = menu.querySelectorAll('[data-dropdown-menu-sub-trigger]')
    const subContents = menu.querySelectorAll('[data-dropdown-menu-sub-content]')
    const items = menu.querySelectorAll('[data-dropdown-menu-item]')

    // Move content to body
    document.body.appendChild(content)
    subContents.forEach(subContent => document.body.appendChild(subContent))

    const updatePosition = (element, anchor, offset = { x: 0, y: 10 }) => {
      const rect = anchor.getBoundingClientRect()
      const elementRect = element.getBoundingClientRect()

      // Calculate available space
      const viewportHeight = window.innerHeight
      const viewportWidth = window.innerWidth

      // Position vertically
      let top = rect.bottom + offset.y
      if (top + elementRect.height > viewportHeight) {
        top = rect.top - elementRect.height - offset.y
      }

      // Position horizontally
      let left = rect.left + offset.x
      if (left + elementRect.width > viewportWidth) {
        left = rect.right - elementRect.width - offset.x
      }

      element.style.top = `${top}px`
      element.style.left = `${left}px`
    }

    const close = () => {
      menu.dataset.state = 'closed'
      trigger.dataset.state = 'closed'
      content.dataset.state = 'closed'
      trigger.setAttribute('aria-expanded', 'false')
      subTriggers.forEach(subTrigger => subTrigger.dataset.state = 'closed')
      subContents.forEach(subContent => subContent.dataset.state = 'closed')
    }

    const open = () => {
      menu.dataset.state = 'open'
      trigger.dataset.state = 'open'
      content.dataset.state = 'open'
      trigger.setAttribute('aria-expanded', 'true')
      updatePosition(content, trigger)
    }

    // Handle keyboard navigation on the content element
    content.addEventListener('keydown', (event) => {
      const focusedElement = document.activeElement
      const itemsList = Array.from(items)
      const currentIndex = itemsList.indexOf(focusedElement)
      console.log(items)
      switch (event.key) {
        case 'ArrowDown':
          event.preventDefault()
          if (currentIndex < items.length - 1) {
            items[currentIndex + 1].focus()
          }
          break
        case 'ArrowUp':
          event.preventDefault()
          if (currentIndex > 0) {
            items[currentIndex - 1].focus()
          } else {
            trigger.focus()
          }
          break
        case 'ArrowRight':
          if (focusedElement.hasAttribute('data-dropdown-menu-sub-trigger')) {
            event.preventDefault()
            const subContent = menu.querySelector(`[data-dropdown-menu-sub-content][data-state="closed"]`)
            if (subContent) {
              focusedElement.dataset.state = 'open'
              subContent.dataset.state = 'open'
              updatePosition(subContent, focusedElement, { x: focusedElement.offsetWidth - 5, y: 0 })
              const firstSubItem = subContent.querySelector('[data-dropdown-menu-item]')
              if (firstSubItem) firstSubItem.focus()
            }
          }
          break
        case 'ArrowLeft':
          const subContent = focusedElement.closest('[data-dropdown-menu-sub-content]')
          if (subContent) {
            event.preventDefault()
            const subTrigger = menu.querySelector('[data-dropdown-menu-sub-trigger][data-state="open"]')
            if (subTrigger) {
              subTrigger.dataset.state = 'closed'
              subContent.dataset.state = 'closed'
              subTrigger.focus()
            }
          }
          break
        case 'Enter':
        case ' ':
          if (focusedElement.hasAttribute('data-dropdown-menu-sub-trigger')) {
            event.preventDefault()
            const subContent = menu.querySelector(`[data-dropdown-menu-sub-content][data-state="closed"]`)
            if (subContent) {
              focusedElement.dataset.state = 'open'
              subContent.dataset.state = 'open'
              updatePosition(subContent, focusedElement, { x: focusedElement.offsetWidth - 5, y: 0 })
              const firstSubItem = subContent.querySelector('[data-dropdown-menu-item]')
              if (firstSubItem) firstSubItem.focus()
            }
          } else {
            focusedElement.click()
            close()
            trigger.focus()
          }
          break
        case 'Escape':
          close()
          trigger.focus()
          break
        case 'Home':
          event.preventDefault()
          items[0]?.focus()
          break
        case 'End':
          event.preventDefault()
          items[items.length - 1]?.focus()
          break
        case 'PageUp':
          event.preventDefault()
          const pageUpIndex = Math.max(0, currentIndex - 5)
          items[pageUpIndex]?.focus()
          break
        case 'PageDown':
          event.preventDefault()
          const pageDownIndex = Math.min(items.length - 1, currentIndex + 5)
          items[pageDownIndex]?.focus()
          break
      }

      // Type-ahead functionality
      if (event.key.length === 1 && !event.ctrlKey && !event.altKey && !event.metaKey) {
        const char = event.key.toLowerCase()
        const itemsList = Array.from(items)
        const currentIndex = itemsList.indexOf(focusedElement)
        
        // Find the next item that starts with the typed character
        const nextItem = itemsList.find((item, index) => {
          const text = item.textContent?.toLowerCase() || ''
          return text.startsWith(char) && index > currentIndex
        }) || itemsList.find(item => {
          const text = item.textContent?.toLowerCase() || ''
          return text.startsWith(char)
        })

        if (nextItem) {
          nextItem.focus()
          event.preventDefault()
        }
      }
    })

    // Handle main menu trigger
    trigger.addEventListener('click', () => {
      const isOpen = menu.dataset.state === 'open'
      if (isOpen) {
        close()
      } else {
        open()
        // Focus first item when opening with click
        items[0]?.focus()
      }
    })

    // Handle submenus
    subTriggers.forEach((subTrigger, index) => {
      const subContent = subContents[index]
      let closeTimeout

      const openSubmenu = () => {
        clearTimeout(closeTimeout)
        subTrigger.dataset.state = 'open'
        subContent.dataset.state = 'open'
        updatePosition(subContent, subTrigger, { x: subTrigger.offsetWidth - 5, y: 0 })
      }

      const closeSubmenu = () => {
        subTrigger.dataset.state = 'closed'
        subContent.dataset.state = 'closed'
      }

      // Open submenu on hover
      subTrigger.addEventListener('mouseenter', openSubmenu)
      subContent.addEventListener('mouseenter', openSubmenu)

      // Close submenu with delay when mouse leaves
      subTrigger.addEventListener('mouseleave', () => {
        closeTimeout = setTimeout(closeSubmenu, 100)
      })
      subContent.addEventListener('mouseleave', () => {
        closeTimeout = setTimeout(closeSubmenu, 100)
      })

      // Handle click for touch devices
      subTrigger.addEventListener('click', (event) => {
        event.preventDefault()
        event.stopPropagation()
        const isOpen = subTrigger.dataset.state === 'open'
        // Close other open submenus
        subTriggers.forEach((otherTrigger, otherIndex) => {
          if (otherIndex !== index) {
            otherTrigger.dataset.state = 'closed'
            subContents[otherIndex].dataset.state = 'closed'
          }
        })

        if (isOpen) {
          closeSubmenu()
        } else {
          openSubmenu()
        }
      })
    })

    // Close when clicking outside
    document.addEventListener('click', (event) => {
      if (!menu.contains(event.target)) {
        close()
      }
    })

    // Handle item keyboard navigation
    items.forEach((item, index) => {
      item.addEventListener('keydown', (event) => {
        switch (event.key) {
          case 'ArrowDown':
            if (index < items.length - 1) {
              items[index + 1].focus()
              event.preventDefault()
            }
            break
          case 'ArrowUp':
            if (index > 0) {
              items[index - 1].focus()
            } else {
              trigger.focus()
            }
            event.preventDefault()
            break
          case 'ArrowLeft':
            const subContent = item.closest('[data-dropdown-menu-sub-content]')
            if (subContent) {
              const subTrigger = menu.querySelector(`[data-dropdown-menu-sub-trigger][data-state="open"]`)
              if (subTrigger) {
                subTrigger.focus()
                subTrigger.dataset.state = 'closed'
                subContent.dataset.state = 'closed'
                event.preventDefault()
              }
            }
            break
          case 'Tab':
            close()
            break
          case 'Enter':
          case ' ':
            item.click()
            close()
            trigger.focus()
            event.preventDefault()
            break
        }
      })
    })

    // Update positions on scroll and resize
    window.addEventListener('scroll', () => {
      if (menu.dataset.state === 'open') {
        updatePosition(content, trigger)
      }
      subTriggers.forEach((subTrigger, index) => {
        if (subTrigger.dataset.state === 'open') {
          updatePosition(subContents[index], subTrigger, { x: subTrigger.offsetWidth - 5, y: 0 })
        }
      })
    }, { passive: true })

    window.addEventListener('resize', () => {
      if (menu.dataset.state === 'open') {
        updatePosition(content, trigger)
      }
      subTriggers.forEach((subTrigger, index) => {
        if (subTrigger.dataset.state === 'open') {
          updatePosition(subContents[index], subTrigger, { x: subTrigger.offsetWidth - 5, y: 0 })
        }
      })
    })
  }

  const dropdownMenus = document.querySelectorAll('[data-dropdown-menu]')
  dropdownMenus.forEach(initDropdownMenu)
})
