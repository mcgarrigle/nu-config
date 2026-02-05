let present = $"($nu.cache-dir)/carapace.nu" | path exists
if $present {
  source $"($nu.cache-dir)/carapace.nu"
}
