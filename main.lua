if not _G.VojinLIB then
    _G.VojinLIB = {}

    function VojinLIB:Setup()
        self._mod_path = ModPath
        self._save_path = SavePath

        function self:test()
            log("welp")
        end
    end
end

VojinLIB:Setup()