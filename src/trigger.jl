export # external trigger parameters
external_trigger_set_polarity,external_trigger_get_polarity,external_trigger_has_polarity,
external_trigger_set_power,external_trigger_get_power,
external_trigger_set_mode,external_trigger_get_mode,
external_trigger_set_source,external_trigger_get_source,
external_trigger_get_supported_sources,
software_trigger_get_power,software_trigger_set_power

"""
enum dc1394trigger_mode_t
"""
@enum(TriggerMode,
      TRIGGER_MODE_0 = (UInt32)(384),
      TRIGGER_MODE_1 = (UInt32)(385),
      TRIGGER_MODE_2 = (UInt32)(386),
      TRIGGER_MODE_3 = (UInt32)(387),
      TRIGGER_MODE_4 = (UInt32)(388),
      TRIGGER_MODE_5 = (UInt32)(389),
      TRIGGER_MODE_14 = (UInt32)(390),
      TRIGGER_MODE_15 = (UInt32)(391))

const TRIGGER_MODE_MIN = TRIGGER_MODE_0
const TRIGGER_MODE_MAX = TRIGGER_MODE_15
const TRIGGER_MODE_NUM = (Int(TRIGGER_MODE_MAX) - Int(TRIGGER_MODE_MIN)) + 1


immutable dc1394trigger_modes_t
    num::UInt32
    modes::NTuple{8,TriggerMode}
    dc1394trigger_modes_t()=new(0,ntuple(i->TRIGGER_MODE_MIN,8))
end
show(io::IO,fm::dc1394trigger_modes_t)=0<fm.num<8? show(io,fm.modes[1:fm.num]):()

"""
enum dc1394trigger_source_t
"""
@enum(TriggerSource,
      TRIGGER_SOURCE_0 = (UInt32)(576),
      TRIGGER_SOURCE_1 = (UInt32)(577),
      TRIGGER_SOURCE_2 = (UInt32)(578),
      TRIGGER_SOURCE_3 = (UInt32)(579),
      TRIGGER_SOURCE_SOFTWARE = (UInt32)(580))
# end enum TriggerSource

const TRIGGER_SOURCE_MIN = TRIGGER_SOURCE_0
const TRIGGER_SOURCE_MAX = TRIGGER_SOURCE_SOFTWARE
const TRIGGER_SOURCE_NUM = (Int(TRIGGER_SOURCE_MAX) - Int(TRIGGER_SOURCE_MIN)) + 1


immutable dc1394trigger_sources_t
    num::UInt32
    sources::NTuple{5,TriggerSource}
    dc1394trigger_sources_t()=new(0,ntuple(i->TRIGGER_SOURCE_MIN,5))
end
show(io::IO,fm::dc1394trigger_sources_t)=0<fm.num<5? show(io,fm.sources[1:fm.num]):()


# begin enum dc1394trigger_polarity_t
@enum(TriggerPolarity,
      TRIGGER_ACTIVE_LOW = (UInt32)(704),
      TRIGGER_ACTIVE_HIGH = (UInt32)(705))
# end enum TriggerPolarity

const TRIGGER_ACTIVE_MIN = TRIGGER_ACTIVE_LOW
const TRIGGER_ACTIVE_MAX = TRIGGER_ACTIVE_HIGH
const TRIGGER_ACTIVE_NUM = (Int(TRIGGER_ACTIVE_MAX) - Int(TRIGGER_ACTIVE_MIN)) + 1

function external_trigger_set_polarity(camera::Camera,polarity::TriggerPolarity)
    ccall((:dc1394_external_trigger_set_polarity,libdc1394),Error,(Ptr{CameraInfo},TriggerPolarity),camera.handle,polarity)
end

function external_trigger_get_polarity(camera::Camera)
    polarity=Array{TriggerPolarity,1}(1)
    ccall((:dc1394_external_trigger_get_polarity,libdc1394),Error,(Ptr{CameraInfo},Ptr{TriggerPolarity}),camera.handle,polarity)
    polarity[1]
end

function external_trigger_has_polarity(camera::Camera)
    polarity_capable=[Bool(FALSE)]
    ccall((:dc1394_external_trigger_has_polarity,libdc1394),Error,(Ptr{CameraInfo},Ptr{Bool}),camera.handle,polarity_capable)
    polarity_capable[1]==TRUE
end

function external_trigger_set_power(camera::Camera,pwr::Switch)
    ccall((:dc1394_external_trigger_set_power,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handle,pwr)
end

function external_trigger_get_power(camera::Camera)
    pwr=[Switch(OFF)]
    ccall((:dc1394_external_trigger_get_power,libdc1394),Error,(Ptr{CameraInfo},Ptr{Switch}),camera.handle,pwr)
    pwr[1]
end

function external_trigger_set_mode(camera::Camera,mode::TriggerMode)
    ccall((:dc1394_external_trigger_set_mode,libdc1394),Error,(Ptr{CameraInfo},TriggerMode),camera.handle,mode)
end

function external_trigger_get_mode(camera::Camera)
    mode=Array{TriggerMode,1}(1)
    ccall((:dc1394_external_trigger_get_mode,libdc1394),Error,(Ptr{CameraInfo},Ptr{TriggerMode}),camera.handle,mode)
    mode[1]
end

function external_trigger_set_source(camera::Camera,source::TriggerSource)
    ccall((:dc1394_external_trigger_set_source,libdc1394),Error,(Ptr{CameraInfo},TriggerSource),camera.handle,source)
end

function external_trigger_get_source(camera::Camera)
    source=Array{TriggerSource,1}(1)
    ccall((:dc1394_external_trigger_get_source,libdc1394),Error,(Ptr{CameraInfo},Ptr{TriggerSource}),camera.handle,source)
    source[1]
end

function external_trigger_get_supported_sources(camera::Camera)
    sources=Array{dc1394trigger_sources_t,1}(1)
    ccall((:dc1394_external_trigger_get_supported_sources,libdc1394),Error,(Ptr{CameraInfo},Ptr{dc1394trigger_sources_t}),camera.handle,sources)
    sources[1].sources[1:sources[1].num]
end

function software_trigger_set_power(camera::Camera,pwr::Switch)
    ccall((:dc1394_software_trigger_set_power,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handle,pwr)
end

function software_trigger_get_power(camera::Camera)
    pwr=[Switch(OFF)]
    ccall((:dc1394_software_trigger_get_power,libdc1394),Error,(Ptr{CameraInfo},Ptr{Switch}),camera.handle,pwr)
    pwr[1]
end
