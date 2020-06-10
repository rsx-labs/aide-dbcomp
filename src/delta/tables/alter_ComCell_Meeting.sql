if not exists ( select * from syscolumns where id = OBJECT_ID('COMCELL_MEETING') and name='WEEK' )
begin
	print 'Adding column WEEK to COMCELL_MEETING'
	ALTER TABLE COMCELL_MEETING ADD [WEEK] int NULL
end
GO