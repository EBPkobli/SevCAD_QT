Qt.include("three.js")
Qt.include("TransformControls.js")

var camera, scene, renderer;
var cube;
var control;
var canvasSelf;

function initializeGL(canvas , eventSource) {

    canvasSelf = canvas
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(75, canvas.width / canvas.height, 0.1, 1000);
    camera.position.z = 5;
    camera.position.x = 0;
    camera.position.y = 0;

    var material = new THREE.MeshBasicMaterial({ color: 0xaa1111,
                                                   shading: THREE.SmoothShading
                                               });
    var cubeGeometry = new THREE.BoxGeometry(1, 1, 1);
    cube = new THREE.Mesh(cubeGeometry, material);
    cube.rotation.set(0.785, 0.785, 0.0);
    cube.position.set(0,0,0);
    scene.add(cube);

    control = new THREE.TransformControls( camera, canvas, eventSource );
    scene.add(control);

    control.attach( cube );
    scene.add( control );

    control.setSpace( "local" );

    eventSource.mouseMove.connect(this.onDocumentMouseMove);

    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio });
    renderer.setSize(canvas.width, canvas.height);

}
var mouseX,mouseY;
this.onDocumentMouseMove = function( x, y ) {
    mouseX = x - canvasSelf.width / 2;
    mouseY = y - canvasSelf.height / 2;
}

function resizeGL(canvas) {
    camera.aspect = canvas.width / canvas.height;
    camera.updateProjectionMatrix();

    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setSize(canvas.width, canvas.height);
}

function paintGL(canvas) {

    camera.lookAt(0,0,0);
    camera.updateProjectionMatrix();
    renderer.render(scene, camera);
}
