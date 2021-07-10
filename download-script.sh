set -x

# COMPONENTS=(analytics auth database dynamic-links functions instance-id remote-config app crashlytics firestore installations messaging storage)
COMPONENTS=(app)

#7.0.1 7.0.2 7.1.0 7.2.0 8.0.0
VERSION="7.0.0"

download_dir="$(mktemp -d)"
# Cleans up the temp dir on exit.
trap "rm -rf \"${download_dir}\"" SIGTERM SIGQUIT EXIT

# https://dl.google.com/games/registry/unity/com.google.firebase.analytics/com.google.firebase.analytics-7.0.1.tgz

for component in "${COMPONENTS[@]}"
do
  packagename="com.google.firebase.${component}"
  filename="${packagename}-${VERSION}.tgz"
  output_path="${download_dir}/${filename}"
  url="https://dl.google.com/games/registry/unity/${packagename}/${filename}"
  curl -o "${output_path}" "${url}"

  tar -xvf "${output_path}" -C "${download_dir}"
  unzip_folder="${download_dir}/package"
  ls ${unzip_folder}
  rm -rf "./${component}"
  cp -rf "${unzip_folder}/." "./${component}"
  rm -rf "${unzip_folder}"
done
