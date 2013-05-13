var files = [    
    'components/graphics/lib/layers/canvas/CanvasRectLayer',
    'components/graphics/lib/layers/dom/DomRectLayer',
];
var onLoad = function (Layer, Layer2) {
    viewport = new Layer.prototype.viewportClass({
        size: {
            x:400,
            y:400
        },
        css: {
            outline:'1px solid black',
            position:'relative'
        }
    });
    viewport2 = new Layer2.prototype.viewportClass({
        size: {
            x:400,
            y:400
        },
        css: {
            outline:'1px solid red',
            position:'relative'
        }
    });
    
    l = new Layer({    	
    	size:{
    		x:100,
    		y:100
    	},
        color: 'green'
    });
    l2 = new Layer2({     
        size:{
            x:100,
            y:100
        },
        color: 'green'
    });
    viewport.redraw();
    viewport2.redraw();
}
require(files, onLoad);