#!/usr/bin/env bash
#
# Downloads files of the given Github Gist and runs then as bash scripts.

err() {
  echo "error: $@" >&2
  exit 1
}

cat << EOF

Config:
- gist_id: ${gist_id}
- exit_on_failure: ${exit_on_failure}

EOF

[[ -n "${gist_id}" ]] || err "gist id is not specified"
case "${exit_on_failure}" in
  "true") set -e ;;
  "false") set +e ;;
  *) err "exit_on_failure should be true or false" ;;
esac

gist_dir=$(mktemp -d)
cleanup() {
  rm -rf "${gist_dir}"
}
trap cleanup EXIT

export GIT_ASKPASS=:
git clone "https://gist.github.com/${gist_id}.git" "${gist_dir}" >/dev/null 2>&1 \
 || err "failed to get gist with id" "${gist_id}"

for i in ${gist_dir}/*; do
  printf '\nExecuting script "%s"\n' "$(basename "${i}")"
  bash "${i}"
done

exit 0
