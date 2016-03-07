(def express (nodejs/require "express"))
(def serve-static (nodejs/require "serve-static"))

(defn -main []
  (let [app (express)]
    (.get app "/nope" (fn [req res] 
                              (.send res "nope")))
    (.use app (serve-static "resources/public"))
    (.listen app 3000 (fn []
                        (println "Server started on port 3000")))))
