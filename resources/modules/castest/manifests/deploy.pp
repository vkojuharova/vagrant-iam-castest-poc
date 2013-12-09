define castest::deploy(
$deploy_dir,
$path,
) {
  notice("DEBUG::castest::deploy Tomcat deploy dir is $deploy_dir")

  notice("DEBUG::castest::deploy path is $path")

  file { "$deploy_dir/${name}.war":
    owner => 'root',
    source => $path,
  }
}