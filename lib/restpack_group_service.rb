require 'restpack_service'
require 'restpack_service_messaging'

module Commands::Groups;end #TODO: GJ: loader should create this

RestPack::Service::Loader.load 'group'
