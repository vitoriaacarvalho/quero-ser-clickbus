# Installation 
$ git clone https://github.com/vitoriaacarvalho/quero-ser-clickbus.git

# Requirements
  <ul>
     <li>JAVA 17</li>
     <li>Spring 2.7.4</li>
  </ul>
  
  <strong>dependencies: </strong>
    <ol>
       <li type="1">Spring web</li>
       <li>Jpa</li>
       <li>H2</li>
       <li>Swagger</li>
       <li>Swagger-ui</li>
    </ol>
    
    
  # Endpoints
  <h3>Inital endpoint: localhost:8080/place [there's no content here]</h3>
  <h4>Request Mappings:</h4>
    <ul>
       <li><strong>Creating a place (POST):</strong> initial endpoint + "/save"</li>
       <li><strong>Editing a place (PUT): </strong>initial endpoint + "/update/{slug}" </li>
       <li><strong>Getting a specific place (GET): </strong>initial endpoint + "/{slug}"</li>
       <li><strong>Listing places and filtering them by name (GET): </strong>initial endpoint + "/all-filtered-by-name"</li>
    </ul>
    
  # Testing environment
  $ docker pull vitoriacarvalho/clickbus
  
  # My Youtube Video 
  https://www.youtube.com/watch?v=04P5InNLYY8
