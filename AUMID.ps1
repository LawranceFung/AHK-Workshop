$installedapps = get-AppxPackage


foreach ($app in $installedapps)
{
    foreach ($id in (Get-AppxPackageManifest $app).package.applications.application.id)
    {

        $line = $app.Name + " = " + $app.packagefamilyname + "!" + $id
        echo $line

    }
}