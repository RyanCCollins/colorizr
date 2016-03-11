class String
  # Colors hash holds all of the standard commandline color values
    # The pink is actually light_magenta
  @@colors = { red: 31, green: 32, yellow: 33, blue: 34,
               magenta: 35, pink: 95, light_blue: 94, white: 97,
               light_grey: 37, black: 30, cyan: 36, dark_gray: 90,
                light_red: 91, light_green: 92 }

  @@background_colors = { black: 40, red: 41, green: 42, yellow: 43,
                          blue: 44, magenta: 45, cyan: 46, light_grey: 47,
                          dark_gray: 100, light_red: 101, light_green: 102,
                          light_yellow: 103, light_blue: 104, light_magenta: 105,
                          pink: 105, light_cyan: 106, white: 107 }

  # If a method is called that does not exist,
    # Then call the method missing.
  def method_missing sym
    puts "#{sym} does nothing.  I said nothing!"
  end

  # Create the color methods for every value in the @@colors array
  def self.create_colors
    @@colors.each do |color, value|
      self.send(:define_method, color) do
        "\e[#{value}m" + self + "\e[0m"
      end
    end
  end

  # Create the background colors, which are accessible
    # by calling the color name followed by _background
  def self.create_backgrounds
    @@background_colors.each do |color, value|
      name = (color.to_s + '_background').to_sym
      self.send(:define_method, name) do
        "\e[#{value}m" + self + "\e[0m"
      end
    end
  end

  # Return the colors in a usable array by calling Colorizr.colors
  def self.colors
    @@colors.each do |color, value|
      colors << color
    end
    colors
  end

  def self.background_colors
    @@background_colors.each do |color, value|
      background_colors << color
    end
    background_colors
  end

  # Give a sample of all of the available colors.  Takes
    # an option for showing background colors
  def self.sample_colors
    @@colors.each do |color, value|
      puts "This is " + "#{color}".send(color)
    end
    # Sample background colors
    @@background_colors.each do |color, value|
      puts "This is " + "#{color}".send(color)
    end
  end
end

# Create the colors for the String class
String.create_colors
String.create_backgrounds
