import { Application } from "@hotwired/stimulus";

const application = Application.start();

application.debug = false;
window.Stimulus = application;

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);
