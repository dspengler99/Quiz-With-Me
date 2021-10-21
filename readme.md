# Quiz With Me

Das Projekt **Quiz With Me** entsteht im Rahmen der Veranstaltung **Swift-Programmierung unter iOS** im Sommersemester 2021 an der Technischen Hochschule Mittelhessen. Das Projekt stellt dabei die Prüfungsleistung des Moduls dar.

## Entwickler-Team
* Egzon Jusufi
* Daniel Spengler

## Verwendete Fragen
Welche Fragen wir in unserer App bisher zur Verfügung gestellt haben, ist unter [Material/fragen.md](Material/fragen.md) zu sehen.

## Dokumentation
Die nachfolgenden Abschnitte umfassen die Anforderungen der Dozenten, welche im zugehörigen Moodle-Kurs angegeben wurden. Außerdem sind unter Umständen weitere Abschnitte enthalten.

### Verwendung der App
Um die Anwendung verwenden zu können, muss mittels [Google Firebase](https://firebase.google.com/) ein Projekt erstellt werden, in welchem die Authentifizierung mittels E-Mail und Passwort aktiviert wird, sowie der Firestore-Speicher. Die für das Projekt zur verfügung gestellte `GoogleService-Info.plist` muss anschließend in das Verzeichnis **Quiz _With Me** im Projektordner eingefügt werden. Die Collections sollten fast alle beim erstmaligen Bedarf selbst angelegt werden. Die Ausnahme bildet hier **general**. Diese Collection muss manuell angelegt werden. Weiterhin muss für diese Collection ein Dokument angelegt werden, welches die beiden Felder **userIDs** und **questionIDs** enthält. Beide Felder müssen dabei ein Array vom Typ String sein. Weiterhin muss die zugehörige ID des Dokuments kopiert werden und in `DataManager.swift` als Wert für die zugehörige Variable eingefügt werden. Hat man das zugehörige Xcode-Projekt geöffnet, so befindet sich diese Datei in der Gruppe `FirebaseManagement`.

### Projektbeschreibung und Anforderungen
Ziel des Projekts war es eine Quiz-App zu entwickeln, in welcher zwei menschliche Spiele (also kein Computer-Gegner) gegeneinander spielen können. Dabei umfasst jedes Spiel eine große Runde, welche aus 10 Fragen besteht. Dabei kann sich jeder Spieler aussuchen, wann er die Fragen beantwortet und wie viele am Stück er beantwortet.

Es folgt eine Liste der intigrierten Features:
* **Login / Registrierung:** Für die Spiele benötigen wir logischerweise Nutzer. Hierfür kann sich ein Spieler in der App mittels E-Mail-Adresse, Nutzernamen und Passwort registrieren. Dabei wird geprüft, ob die Registrierung erfolgreich war oder nicht. Auch ein Check auf doppelte Nutzernamen wurde integriert. Für den Login bei der App sind die Mail-Adresse und das Passwort von Nöten.
* **Startseite:** Auf der Startseite hat der Nutzer die Möglichkeit neue Spiele zu beginnen, bzw. vorhandene Spiele fortzusetzen. Dabei aktuallisiert sich die Seite, wenn neue Spiele begonnen werden, oder die Seite neu geladen wird (Dies passiert durch einen Wechsel der Seiten).
* **Profil:** Auf der Profilseite sieht ein Nutzer seinen eigenen Namen, seine Mail-Adresse und eine Übersicht über seine abgeschlossenen Spiele. Die Möglichkeit zum ausloggen, wird dabei durch eine Navigationsleiste gegeben, welche ausgeklappt werden kann.
* ***Spielübersicht:** Die Spielübersicht stellt eine Seite dar, welche Informationen zu einem ausgewählten Spiel anzeigt. Dabei werden vom eigenen Nutzer der Fortschritt und die Punkte angezeigt und vom Gegner lediglich der Fortschritt. Weiterhin gibt es hier einen Button, um das Spiel fortzusetzen. Dieser existiert nicht, wenn das Spiel vom eigenen Nutzer bereits beendet wurde. Stattdessen wird dann ein entsprechender Text angezeigt.
* **Spiel:** Der Kern des Spiels besteht aus einer Anzeige der aktuellen Frage. Wählt man nun eine Antwort für die Frage aus, so wird angezeigt, ob die Antwort richtig oder falsch war. Nach einer Sekunde wird dabei dann zur nächsten Frage gewechselt. Hat man die letzte Frage beantwortet, so wird zurück zur Spielübersicht gewechselt. Für die Beantwortung einer Frage existiert dabei kein Zeitlimit. Außerdem kann man das Spiel zu jeder Zeit unterbrechen und zur Startseite zurückkehren. Der aktuelle Fortschritt bleibt dabei gespeichert, so dass bereits beantwortete Fragen nicht erneut beantwortet werden müssen.
* **Spielergebnisse anzeigen:** Auf der Startseite wird im Fall, dass es beendete Spiele gibt, ein Dialog angezeigt, welcher die Informationen für ein Spiel anzeigt. Dabei erhält man die Info, wer wie viele Punkte hatte und wie das Spiel ausgegangen ist. Mit Klick auf "Ok" werden die Spiele des Spielers erneut durchsucht, um zu schauen, ob es weitere beendete Spiele gibt. Ist dies nicht der Fall, so wird die oben beschriebene Startseite angezeigt.
* **Spiel erstellen:** Bei Erstellung eines Spiels wird ein Spiel mit einem zufälligen Gegner gestartet. Dabei ist ausgeschlossen, dass man gegen sich selbst spielen kann. Wir verhindern allerdings nicht, dass es mehrere Spiele gegen den gleichen Spieler gibt.
* **Navigation:** Die Navigation zwischen Startseite, Profil und Ausloggen wird durch eine Seitenleiste ermöglicht, welche ausgeklappt und eingeklappt werden kann.
* **Ausloggen:** Mittels eines Buttons kann ein Nutzer sich in der Navigationsleiste wieder ausloggen. Dabei wird dieser nach Erfolg auf die Login-Seite weitergeleitet.

### Vorgehensweise / Softwareentwicklungsprozess
Größtenteils erfolgte Die Entwicklung in Einzelarbeit. Dabei wurden die Aufgaben, welche erledigt werden sollten, vorher in einem Meeting abgesprochen. Dabei gab es insgesamt zwei Meetings pro Woche:
* **Montags:** Hier wurden Aufgaben für die neue Woche verteilt und Ergebnisse besprochen, welche über das Wochenende zustande gekommen sind. Dabei konnten hier natürlich auch Probleme und Fragen besprochen werden.
* **Freitags:** Hier wurden die Ergebnisse der Woche vorgestellt und es wurden neue Features in Pair-Programming erarbeitet. Außerdem konnten hier auch wieder Fragen und Probleme geklärt werden.

Die Kommunikation erfolgte neben den Meetings über WhatsApp. Für die Meetings selbst wurde **Big Blue Button** verwendet.

Als Plattform für den Quellcode haben wir auf **Github** gesetzt. Dabei haben wir Automationen und weitere Features verwendet, um die Arbeit zu erleichtern:

#### Project-Board
Github stellt ein sog. **Project-Board** zur Verfügung. Diesem kann man eigene Spalten hinzufügen. In unserem Fall gab es die folgenden Spalten:
* **TODO:** Hier stehen Aufgaben, welche zu erledigen sind.
* **In Progress:** Hier werden Aufgaben hinverschoben, wenn gerade an diesen gearbeitet wird.
* **Review:** Ein fertiges Feature wird auf diese Spalte verschoben, sodass klar ist, dass dieses Feature ein Review erhalten soll.
* **Done:** Wenn die Aufgabe komplett abgeschlossen ist (inkl. Review), so wird die Aufgabe auf diese Spalte verschoben.

Durch auswählen des Projekts in der Erstellung eines Issues, wurden erstellte Issues dabei direkt auf die Spalte TODO des Boards verschoben. Somit müssen Aufgaben also nicht doppelt erstellt werden.

#### Automationen
Weiterhin haben wir das Board so automatisiert, dass gewisse Aktionen automatisch durchgeführt wurden:
* **Erstellen eines Branches:** Wenn eine Aufgabe von TODO auf In Progress verschoben wird, so wird ein neuer Branch für dieses Issue erstellt. Somit konnte jedes Mitglied einfach an eigenen Branches arbeiten, welche nicht zuerst manuell erstellt werden müssen.
* **Automatische Pull-Requests:** Wenn eine Aufgabe von der Spalte TODO auf Review verschoben wurde, so wird automatisch ein Pull-Request erstellt. Der Reviewer kann diesen Pull-Request dann einfach durchgehen und mit einem Klick (wenn es keine Konflikte gibt) in den Main-Branch mergen.

Es sei dabei angemerkt, dass ein Skript, welches diese Automationen durchführt bereits größtenteils vorhanden war. Dieses stammt aus einem Software-Technik-Projekt aus dem Sommersemester und ist unter [https://github.com/SWTP-SS20-Kammer-2/Data-Analytics/blob/master/.github/workflows/projects-bord-automatisation.yml](https://github.com/SWTP-SS20-Kammer-2/Data-Analytics/blob/master/.github/workflows/projects-bord-automatisation.yml) zu finden.

### Verwendete Third-Party-Frameworks

#### Firebase (Firestore und Authentication Service)
Bei Firebase handelt es sich um ein Backend-System von Google. Dieses stellt verschiedene Funktionen bereit und kann in vielen Programmiersprachen verwendet werden. Unter anderem ist hier eine Realtime-Datenbank und ein Authentication Service enthalten.

Firebase wurde in unserem Projekt verwendet, um Nutzer zu authentifizieren und Daten zu speichern. Bei Registrierung eines Nutzers wurde dabei nicht nur im Authentication Service ein Eintrag angelegt, sondern auch in der Firestore-Datenbank selbst, um Nutzernamen und weitere Informationen zu speichern. Um die Verbindung der beiden Services zu gewährleisten enthält das User-Dokument in der Datenbank als Feld die UID aus der Authentifizierung. Insgesamt enthält Firestore die folgenden Collections:
* **users:** Hier werden die Nutzer abgespeichert. Dabei werden Nutzername, begonnene Spiele (anhand von IDs), gewonnene Spiele, verlorene Spiele und die Nutzer-ID gespeichert.
* **games:** Hier werden alle Informationen für Spiele gespeichert. Diese Informationen umfassen die beiden Nutzernamen der Spieler, den Fortschritt beider Nutzer, die Punkte beider Nutzer und die enthaltenen Fragen anhand von IDs.
* **questions:** Diese Collection enthält die Fragen, die zugehörigen Antworten als Array und die richtige Antwort als String. Diese wird dabei nicht als Index gespeichert, damit auch bei durchgemischten Arrays die richtige Antwort noch bestimmt werden kann. Diese muss dabei gleich geschrieben sein, wie die Antwort im Array der möglichen Antworten.
* **General:** Hier existiert nur ein Dokument. Dieses speichert die IDs aller registrierten Nutzer und aller existierenden Fragen. Diese Daten werden im Spiel oder in der Spielerstellung verwendet. Bei der Erstellung eines Spiels wollten wir dabei nicht alle Nutzer laden, sondern lediglich die Nutzer-IDs, um Traffic und RAM zu sparen. Die Fragen-IDs werden im Spiel verwendet, damit für die ERstellung eines Spiels nicht erst alle Fragen samt allen Daten geladen werden müssen. Im Spiel selbst werden dann von der App die benötigten Fragen über die IDs abgefragt.

#### PromiseKit
Bei [PromiseKit](https://github.com/mxcl/PromiseKit) handelt es sich um ein Framework, welches Promises in Swift implementiert. Mittels Promises kann man garantierten, dass eine asynchrone Methode einen Wert zurückgeben wird. Eine Methode, die eine Methode aufruft, welche ein Promise zurückgibt, kann dann auf diese Antwort warten und erst dann weiteren Code ausführen. Dies ist für uns sehr nützlich, da wir bei der Spielerstellung unterschiedliche Daten hintereinander aus der Datenbank laden müssen. Hierbei könnte man jeder Methode, welche Firebase-Operationen durchführt theoretisch alternativ eine Completion-Closure übergeben. Bei diesem Vorgehen ist allerdings das Problem, dass hier bei mehreren, voneinander abhängigen, Operationen eine sehr tiefe Verschachtelung entsteht. Dies fanden wir nicht wirklich sinnvoll und leserlich.

Mittels Promises kannn eine Verschachtelung verhindert werden, da aus einem Promise (then-Funktion) ein Promise zurückgegeben werden kann. Am äußeren Block kann dann ein weiterer Block mittels `.then` angefügt werden. Somit verringert man zwar nicht die Anzahl von Klammern oder Zeilen, allerdings entsteht keine extrem tiefe Verschachtelung.

##### Beispiel: Spielerstellung
```swift
...
_ = getUserIDs().then { (response: [String]?) -> Promise in
    if response == nil {
        throw DataManagerError.gameCreationFailed("Failed to get all userIDs from the DB.")
    }
    userIDs = response!
                
    if let ownID = Auth.auth().currentUser?.uid {
        ownUID = ownID
    } else {
        throw DataManagerError.gameCreationFailed("Method was called, though no user is signed in.")
    }
    let ownIndex = userIDs.firstIndex(of: ownUID)
    if ownIndex == nil {
        throw DataManagerError.gameCreationFailed("Own userID was not included in all userIDs.")
    }
    var choosenIndex: Int = Int.random(in: 0..<userIDs.count)
    while(ownIndex == choosenIndex) {
                        choosenIndex = Int.random(in: 0..<userIDs.count)
                    }
    othersUID = userIDs[choosenIndex]
    return self.getUser(uid: ownUID)
}.then { (response: QuizUser?) -> Promise in
    if response == nil {
        throw DataManagerError.gameCreationFailed("Couldn't get own user.")
    }
    ...
```

Dieses Beispiel entstammt dabei aus der Methode `createNewGame`.

### Eigene Navigationsstruktur
Wir wollten für unser Projekt keinen NavigationView von Swift direkt verwenden, da wir diesen als nicht gut anpassbar empfunden haben. Zumindest ist hier nicht viel dokumentiert. Um trotzdem die Navigation zwischen verschiedenen Views zu ermöglichen, haben wir für uns das Konzept des **ViewState** eingeführt. Hierbei handelt es sich um ein Enum mit den verschiedenen States:

```Swift
enum ViewState {
    case LOGIN, REGISTER, HOME, PROFILE, FRIENDSLIST, GAMEOVERVIEW, GAME
}
```

Es gibt einen Main-View, welcher in einem Switch-Case-Statement überprüft, welchen Wert der ViewState besitzt. Dabei besitzt dieser View eine Instanz von `ViewState` als State. Den Sub-Views wird diese Variable als Binding übergeben. Diese können die Variable dann bei bestimmten Aktionen ändern, zum Beispiel bei klicken eines Buttons.

#### Ausschnitt: MainView
```swift
struct Main: View {
    @State var viewState: ViewState
    ...
    
    var body: some View {
        switch(viewState) {
        case .LOGIN, .REGISTER:
            LoginRegisterScreen(viewState: $viewState)
        case .HOME:
            QuizMainScreen(viewState: $viewState, selectedGame: $selectedGame)
        ...
```

### Wozu Promisses?
Im Grunde wurde diese Frage bei der Aufzählung der verwendeten Frameworks geklärt: Wir vermeiden durch die Verwendung von Promises verschachtelte Callbacks. Dadurch wird unser Code leserlicher und somit auch verständlicher.

### Unverwendeter Code / Einschränkungen
Im Projekt gibt es einige wenige Teile Code, welche Features bereitstellen sollten, die es nicht mehr in die App selbst geschafft haben. Dabei handelt es sich namentlich um die Freundesliste (Friendslist) und eine Ladeanimation, welche im Ordner **HelperView** zu finden ist.

Außerdem haben wir es zeitlich nicht mehr geschafft, verlorene und oder gewonnene Spiele automatisch neu zu laden. Wenn also auf gewonnene oder verlorene Spiele geprüft werden soll, muss die Startseite einmal verlassen werden und erneut geöffnet werden (beispielsweise durch Wechsel zum Profil oder zur Spielübersicht). Ein anderer Weg ist es, ein neues Spiel zu starten. Dabei wird die Anzeige für beendete Spiele ebenfalls aktualisiert.

Wir bitten bei diesen Einschränkungen darum, darauf zu achten, dass die gesamte App für vier Entwickler ausgelegt war und wir im Verlaufe des Projekts leider nur zwei Entwickler waren, da es Schwierigkeiten im Team gab.

### Projekt-Fazit: Egzon Jusufi
Nach anfänglichen Schwierigkeiten innerhalb der Gruppe (zu Beginn eine 4er Gruppe, später als 2er Gruppe) lief die Arbeit als Team sehr strukturiert ab. So fanden wir uns zwei mal die Woche zusammen. Montags schauten wir uns unsere Ergebnisse der vergangenen Woche an, sprachen über Probleme die aufkamen und verteilten neue Aufgaben für die Woche. Freitags fand unser zweites Meeting statt, bei dem wir in Pair-Prgramming-Arbeit komplexere Funktionen entwickelten. 
Wie es in der Softwareentwicklung so üblich ist, stießen wir auf Probleme welche frustrierend waren und uns länger grübeln ließen. Nichtsdestotrotz fanden wir auch hier gemeinsam immer eine Lösung. Zudem machte es uns die Entwicklungsumgebung XCode auch nicht immer einfach wenn sie sporadisch Errors anzeigte, obwohl am Vortag noch alles in Ordnung war. Ein für uns 'beliebtes' Beispiel war die Rückgabe einer View anhand einer Bedingung (`if(Bedingung) {View} else {View}`) innerhalb einer Group. Hier erkannte XCode nicht immer, dass auf alle Fälle eine View zurückgegeben wird. Das Hinzufügen und wieder wegnehmen einer `EmptyView()` löste dieses Problem.

Die Arbeit als Team würde ich als sehr harmonisch und zielführend beschreiben. Die Ziele die wir uns gesetzt haben, haben wir auch erreicht. Die Vorlesung selbst war kurz und verfolgte eher den Ansatz "learning by doing" welchen ich gut fand. Für mich war es insgesammt ein ziemlich guter Einstieg in der Entwicklung mit Swift und hat mir eine Menge Spaß gemacht.

### Projekt-Fazit: Daniel Spengler
Insgesamt hat mir das Projekt größtenteils Spaß bereitet. Es gab aber natürlich auch frustrierende Phasen. So erinnere ich mich an die Spielerstellung, da es viel Recherche benötigt hat, wie man die Verschachtelung von Callbacks verhindern kann. Insgesamt sind hier viele Stunden verwendet worden. Auch war dies frustrierend, da zu Beginn gar nicht klar war, dass Firebase asynchron läuft. Dadurch hat die Problemanalyse ebenfalls länger gedauert. Auch das Einbinden unserer erklärten Navigationsstruktur war nicht einfach. Zumindest nicht, wenn es um die Ideenfindung geht. Sieht man von diesen Schwierigkeiten und frustrierenden Momenten ab, so blicke ich auf eine spannende Zeit zurück, in welcher ich viel gelernt habe und definitiv eine Entwicklung in meinen Fähigkeiten bezüglich Swift erlebt habe.

Die Vorlesungen insgesamt fand ich ebenfalls als Einstieg gut. Hier hätte mir als "Pflichtprogramm" ein Einstieg in die asynchrone Programmierung allerdings auch geholfen, da so dass Projekt schneller voran gegangen wäre und mehr Features hätten implementiert werden können. Gleichzeitig ist dieser Aspekt nicht nur wichtig für unser spezielles Projekt, sondern scheint in Swift und iOS allgemein besonders wichtig zu sein. Neben diesem Aspekt fand ich die Veranstaltung jedoch durchweg positiv und gerade das Projekt hat an vielen Stellen sehr viel spaß gemacht.

### Quellen
* 17.12.2018, „Avoiding Callback Hell in Swift“: [https://swiftrocks.com/avoiding-callback-hell-in-swift](https://swiftrocks.com/avoiding-callback-hell-in-swift)
* SWTP-SS20-Kammer-2 (Projekt-Repository): https://github.com/SWTP-SS20-Kammer-2/Data-Analytics
* Ladeanimation: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
