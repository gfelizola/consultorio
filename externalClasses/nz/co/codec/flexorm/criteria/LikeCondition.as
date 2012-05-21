package nz.co.codec.flexorm.criteria
{
    public class LikeCondition extends Condition
    {
		public static const LEFT:String = 'LEFT' ;
		public static const RIGHT:String = 'RIGHT' ;
		public static const ALL:String = 'ALL' ;
		
        private var _str:String;
		private var _sides:String;

        public function LikeCondition(table:String, column:String, str:String, sides:String = LikeCondition.ALL)
        {
            super(table, column);
            _str = str;
			_sides = sides ;
        }

        override public function toString():String
        {
			var st:String = column + " like '" ;
			
			if( _sides == LikeCondition.ALL || _sides == LikeCondition.LEFT ) st += '%' ;
			
			st += _str ;
			
			if( _sides == LikeCondition.ALL || _sides == LikeCondition.RIGHT ) st += '%' ;
			
			st += "'" ;
			
            return st;
        }

    }
}