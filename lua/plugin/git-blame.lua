require('gitblame').setup{
	enabled = false,
	message_template = '<summary> • <date> • <author>',
	--date_format = '%Y-%m-%d %H:%M',
	date_format = '%r',
	delay = 500
}
