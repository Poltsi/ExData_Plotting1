data.url  = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data.zip  = "household_power_consumption.zip"
data.file = "household_power_consumption.txt"

out.file  = "plot4.png"
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
                colClasses = c( "character", "character", rep( "numeric", 7 ) ),
                skip       = 66637,
                nrows      = 2880 )

png( filename = out.file,
     width    = out.x,
     height   = out.y )

# Set the array of images

par( mfcol = c( 2, 2 ) )

# Plot the global active power, 1-1

plot( x = as.POSIXct( paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S" ),
      y = hpc$Global_active_power,
      type = "l",
      xlab = "",
      ylab = "Global Active Power" )

# Plot the energy sub meterings

plot( x = as.POSIXct( paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S" ),
      y = hpc$Sub_metering_1,
      type  = "l",
      xlab  = "",
      ylab  = "Energy sub metering" )

# Then add the 2 and 3 submetering

lines( x = as.POSIXct( paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S" ),
       y = hpc$Sub_metering_2,
       col = "red" )

lines( x = as.POSIXct( paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S" ),
       y = hpc$Sub_metering_3,
       col = "blue" )

# Finally add the legends

legend( "topright",
        c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ),
        lty = c( 1, 1 ),
        bty = "n",
        col = c( "black", "red", "blue" ) )
 
# Plot the voltage

plot( x = as.POSIXct( paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S" ),
      y = hpc$Voltage,
      type  = "l",
      xlab  = "datetime",
      ylab  = "Voltage" )

# Finally plot the global reactive power
 
plot( x = as.POSIXct( paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S" ),
      y = hpc$Global_reactive_power,
      type  = "l",
      xlab  = "datetime",
      ylab  = "Global_reactive_power" )

dev.off()
