component {
    
    function up( schema, qb ) {
        schema.create( "fortunes", ( t ) => {
            t.guid( "id" ).default( "(gen_random_uuid ())").primaryKey();
            t.string( "fortune" );
            t.integer( "likeCount" );
            t.integer( "dislikeCount" );
            t.datetime( "created" ).default( "NOW()" );
        });
    }

    function down( schema, qb ) {
        schema.drop( "fortunes" );
    }

}
