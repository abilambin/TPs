# cibles qui ne sont pas des fichiers (évite conflit avec les éventuels fichiers de même nom)
.PHONY: clean, test, docs

# variables à redéfinir pour chaque applications
SOURCES= DNS/*.java UDP/*.java
			
# nom du fichier jar généré 				
JAR_NAME= appli.jar 

# nom du manifeste utilisé pour création jar
MANIFEST= manifest-ex

# les packages utilisés
PACKAGES= DNS UDP

# les répertoires utilisés
DIR= DNS UDP

# le classpath à utiliser
CLASSPATH = .

# toutes les tâches
all: clean test docs jar 	

#structurer l'environnement de travail 
init:
	mkdir classes
	mkdir test
	mkdir docs
	mkdir src

#compilation des sources	
compile: 
	cd src ; javac -classpath $(CLASSPATH) $(SOURCES) -d ../classes

#création du jar
jar: 
	cd classes; jar cvfm ../$(JAR_NAME) ../$(MANIFEST) $(DIR)

#génération de la doc	
docs:
	cd src; javadoc $(PACKAGES) -d ../docs

#exécution	par 'make args="val" run'
run:
	java -jar $(JAR_NAME) ${args}

# génération des tests	
test: compile
	javac -classpath test-1.7.jar test/*.java
	
#exécution des tests en supposant les noms de classe de tests = XXXTest
%Test:
	java -jar test-1.7.jar $@
	
#nettoyage classes docs .jar et '.class' des tests
clean:
	rm -f -r classes; mkdir classes
	rm -f -r docs ; mkdir docs
	cd test ; rm -f *.class
