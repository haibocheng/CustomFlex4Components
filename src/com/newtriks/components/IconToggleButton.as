/** @author: Simon Bailey <simon@newtriks.com> */
package com.newtriks.components
{
    import flash.events.Event;

    import mx.controls.Image;
    import mx.events.FlexEvent;

    import spark.components.Label;
    import spark.components.supportClasses.ButtonBase;

    [Event(name="change", type="flash.events.Event")]

    [SkinState("upAndSelected")]
    [SkinState("overAndSelected")]
    [SkinState("downAndSelected")]
    [SkinState("disabledAndSelected")]

    public class IconToggleButton extends ButtonBase
    {
        [SkinPart(required="true")]
        public var iconElement:Image;

        [SkinPart(required="true")]
        public var labelElement:Label;

        public function IconToggleButton()
        {
            super();
        }

        private var _text:String;

        public function set text(value:String):void
        {
            if(_text==value) return;
            _text=value;
            if(labelElement)
            {
                labelElement.text=value;
            }
        }

        private var _toggleText:String;

        public function set toggleText(value:String):void
        {
            if(_toggleText==value) return;
            _toggleText=value;
        }

        private var _icon:Class;

        public function set icon(value:Class):void
        {
            if(_icon==value) return;
            _icon=value;
            if(iconElement)
            {
                iconElement.source=value;
            }
        }

        private var _toggleIcon:Class;

        public function set toggleIcon(value:Class):void
        {
            if(_toggleIcon==value) return;
            _toggleIcon=value;
        }

        private var _canToggle:Boolean=false;

        public function get canToggle():Boolean
        {
            return _canToggle;
        }

        public function set canToggle(value:Boolean):void
        {
            _canToggle=value;
        }

        private var _selected:Boolean;

        [Bindable]

        public function get selected():Boolean
        {
            return _selected;
        }

        public function set selected(value:Boolean):void
        {
            if(value==_selected)
                return;
            _selected=value;
            toggleContent();
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            invalidateSkinState();
        }

        protected function toggleContent():void
        {
            var source:Class=(selected)?_toggleIcon:_icon;
            var text:String=(selected)?_toggleText:_text;

            if(iconElement) iconElement.source=source;
            if(labelElement) labelElement.text=text;
        }

        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);

            switch(instance)
            {
                case iconElement:
                    iconElement.source=_icon;
                    break;
                case labelElement:
                    labelElement.text=_text;
                    break;
            }
        }

        override protected function partRemoved(partName:String, instance:Object):void
        {
            super.partRemoved(partName, instance);
        }

        override protected function getCurrentSkinState():String
        {
            if(!canToggle) return super.getCurrentSkinState();

            if(!selected)
                return super.getCurrentSkinState();
            else
                return super.getCurrentSkinState()+"AndSelected";
        }

        override protected function buttonReleased():void
        {
            super.buttonReleased();

            if(canToggle)
                selected=!selected;

            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}