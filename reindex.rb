proj_files = [
 "DEO/Deo.RegistryMapping/Deo.RegistryMapping.csproj",
 "DEO/Data/Deo.csproj",
 "DEO/FCS.Reporting.CmdLineProcessor.IntegrationTests/FCS.Reporting.CmdLineProcessor.IntegrationTests.csproj",
 "DEO/IntegrationTester/IntegrationTestBase.csproj",
 "WSOClient/Source/Legacy/WSO11-1/WSO/DEO/DEOGroup.vbg"
]

directories = proj_files.map { |f| File.dirname(f) }

other_directories = Dir.glob("**/*/").reject do |directory_to_test|
 directories.any? do |directory_to_include|
   directory_to_include.start_with?(directory_to_test)
 end
end

def get_cs_files directories
 cs_files = directories.map { |d| Dir.glob(d + '/**/*.cs') }.flatten

 exclude_cs_patterns = [
   /AssemblyInfo.cs/,
   /xaml/,
   /obj\/Debug/,
   /obj\/x86/,
   /AssemblyInfo\.cs/,
   /Resources\.Designer\.cs/,
   /Settings\.Designer\.cs/
 ]

 ignore_extensions = [
   '*.sql',
   '*.ps1',
   '*.psm1',
   '*.xml'
 ]

 exclude_cs_patterns.each do |p|
   cs_files = cs_files.reject { |f| f =~ p }
 end

 cs_files = cs_files.reject { |f| f.strip.length.zero? }
end

def get_vb_files directories
 vb_files = directories.map { |d| Dir.glob(d + '/**/*.cls') }.flatten

 vb_files = vb_files.reject { |f| f.strip.length.zero? }

 vb_files
end

all_code_files = get_cs_files(directories) + get_vb_files(directories)

File.open('.code_files', 'w') { |file| file.write(all_code_files.join("\n")) }
system "ctags -e -L .code_files"
puts "done"
