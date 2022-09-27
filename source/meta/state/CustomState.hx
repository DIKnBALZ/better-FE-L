package meta.state;

import flixel.FlxState;
import meta.*;
import meta.data.*;

class CustomState extends FlxState {

        var script:HScript;

        override public function new(name:String, args:Array<Dynamic>) {
                super();
                
                script = new HScript('states/$name');
                script.setVariable("this", this);
                script.create(args);
        }

        override public function update(elapsed:Float) {
		super.update(elapsed);
		script.update(elapsed);
        }
}