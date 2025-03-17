<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${albumitem.name}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/themes/grayscale/css/view3d.min.css" />
</head>
<body>
<div style="display: none;">
    <span class="item-path">${path}</span>
    <c:forEach var="item" items="${albumitems}">
        <span class="item-urls">${item.url}</span>
    </c:forEach>
</div>
<script async src="/themes/grayscale/js/three/es-module-shims.js"></script>
<script type="importmap">
			{
				"imports": {
					"three": "/themes/grayscale/js/three/three.module.js"
				}
			}
		</script>
<script type="module">

    import * as THREE from 'three';
    import { OrbitControls } from '/themes/grayscale/js/three/jsm/controls/OrbitControls.js';
    import { GLTFLoader } from '/themes/grayscale/js/three/jsm/loaders/GLTFLoader.js';
    import { RGBELoader } from '/themes/grayscale/js/three/jsm/loaders/RGBELoader.js';


    let renderer, scene, camera, controls;
    let itemPath = document.querySelector('.item-path').innerHTML;
    const itemUrls = document.querySelectorAll(".item-urls");
    let hdrFileName = '';
    let glbFileName = '';
    for (let i = 0; i < itemUrls.length; i++) {
        let itemUrl = itemUrls[i].innerHTML;
        var lastIndex = itemUrl.lastIndexOf('/');
        if (itemUrl.endsWith('.hdr')) {
            hdrFileName = itemUrl.substring(lastIndex + 1);
        } else if (itemUrl.endsWith('.glb')) {
            glbFileName = itemUrl.substring(lastIndex + 1);
        }
    }
    init().catch( function ( err ) {

        console.error( err );

    } );

    async function init() {

        renderer = new THREE.WebGLRenderer( { antialias: true } );
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( window.innerWidth, window.innerHeight );
        renderer.outputEncoding = THREE.sRGBEncoding;
        renderer.toneMapping = THREE.ACESFilmicToneMapping;
        document.body.appendChild( renderer.domElement );

        scene = new THREE.Scene();

        camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 0.25, 20 );
        camera.position.set( 0.35, 0.05, 0.35 );

        controls = new OrbitControls( camera, renderer.domElement );
        controls.addEventListener( 'change', render );
        controls.target.set( 0, 0.2, 0 );
        controls.update();

        const rgbeLoader = new RGBELoader().setPath( itemPath );

        const gltfLoader = new GLTFLoader().setPath( itemPath );

        const [ texture, gltf ] = await Promise.all( [
            rgbeLoader.loadAsync( hdrFileName ),
            gltfLoader.loadAsync( glbFileName ),
        ] );

        // environment

        texture.mapping = THREE.EquirectangularReflectionMapping;

        scene.background = texture;
        scene.environment = texture;

        // model

        scene.add( gltf.scene );

        render();

        window.addEventListener( 'resize', onWindowResize );

    }

    function onWindowResize() {

        camera.aspect = window.innerWidth / window.innerHeight;

        camera.updateProjectionMatrix();

        renderer.setSize( window.innerWidth, window.innerHeight );

        render();

    }

    function render() {

        renderer.render( scene, camera );

    }

</script>

</body>
</html>