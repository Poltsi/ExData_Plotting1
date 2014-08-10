data.url  = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data.zip  = "household_power_consumption.zip"
data.file = "household_power_consumption.txt"

out.file  = "plot1.png"
out.x     = 480
out.y     = 480

if ( ! file.exists( data.file ) )
{
    print( "The datafile is not found, will download it from source" )
    download.file( data.url, data.zip, method = "curl" )
    unzip( data.zip )
}

# Read only data between 2007-02-01 and 2007-02-02
hpc = read.csv( data.file,
                header     = FALSE,
                col.names  = c( 'Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3' ),
                sep        = ";",
                na.strings = "?",
                skip       = 66637,
                nrows      = 2880 )

png( filename = out.file,
     width    = out.x,
     height   = out.y )

hist( hpc$Global_active_power,
      main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)",
      col  = "red" )

dev.off()
