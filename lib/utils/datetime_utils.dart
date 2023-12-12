class DateTimeUtils
{
    static String nowTimeForFilenameAsIso8601()
    {
        String timestamp = DateTime.now().toString();
        String date = timestamp.split(' ')[0];
        String time = timestamp.split(' ')[1];
        String timepart = "${time.split(':')[0]}-${time.split(':')[1]}";

        return "$date--$timepart";
    }   
}