// Import and register all your controllers from the import map under controllers/*

import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Register custom controllers
import CartNoticeController from "./cart_notice_controller"
import ConsoleMessageController from "./console_message_controller"

application.register("cart-notice", CartNoticeController)
application.register("console-message", ConsoleMessageController)
