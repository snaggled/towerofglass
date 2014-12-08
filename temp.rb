class Temperature

  class << self
              def from_fahrenheit temp
                            Temperature.new({f: temp})
                                end

                  def from_celsius temp
                                Temperature.new({c: temp})
                                    end
                    end

    def initialize(options={})
                @f = options[:f]
                    @c = options[:c]
                      end

      def in_fahrenheit
                  return @f if @f
                      (@c * (9.0 / 5.0)) + 32
                        end

        def in_celsius
                    return @c if @c
                        (@f - 32) * 5.0 / 9.0
                          end
        end

        class Celsius < Temperature
                  def initialize temp
                              super(c: temp)
                                end
        end

        class Fahrenheit < Temperature
                  def initialize temp
                              super(f: temp)
                                end
        end
