require 'mini_magick'
module MiniMagickProcessor
  def image_to_tiff
    Rails.logger.info("Generate UID")
    generate_uid
    Rails.logger.info("Tmp File >>")
    tmp_file = Pathname.new(Dir::tmpdir).join("#{@uid}_#{@source.basename}.tif").to_s
    Rails.logger.info(tmp_file)
    Rails.logger.info(@instance)
    Rails.logger.info(@source.to_s)
    cat = @instance || MiniMagick::Image.open(@source.to_s)
    cat.format("tif")
    Rails.logger.info("Format")
    cat.crop("#{@w}x#{@h}+#{@x}+#{@y}") unless [@x, @y, @w, @h].compact == []
    Rails.logger.info("Crop")
    cat.write tmp_file.to_s
    Rails.logger.info("Save")
    return tmp_file
  end

  def image_from_blob(blob)
    generate_uid
    tmp_file = Pathname.new(Dir::tmpdir).join("#{@uid}_#{@source.basename}.tif").to_s
    cat = @instance || MiniMagick::Image.read(blob)
    cat.format("tif")
    cat.crop("#{@w}x#{@h}+#{@x}+#{@y}") unless [@x, @y, @w, @h].compact == []
    cat.write tmp_file.to_s
    return tmp_file
  end

  def is_a_instance?(object)
    object.class == MiniMagick::Image
  end
end

