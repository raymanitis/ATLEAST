lib.callback.register('mt-restaurants:server:playDriveThruAlert', function(source, job, id)
    lib.callback.await('mt-restaurants:client:playDriveThruAlert', -1, job, id)
    return true
end)