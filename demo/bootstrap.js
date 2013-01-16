var files = [
    'components/graphics/lib/layers/AbstractLayer',
    'components/graphics/lib/layers/dom/DomLayer'
];
var onLoad = function (AbstractLayer, DomLayer) {
    window.l = new DomLayer();
    l.redraw();
}
require(files, onLoad);