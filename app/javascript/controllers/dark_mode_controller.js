import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
    switch(e) {
        if (document.documentElement.classList.contains('dark')) {
            document.documentElement.classList.remove('dark')
        } else {
            document.documentElement.classList.add('dark');
        }
    }
}
