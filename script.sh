rm -rf .repo/local_manifests/

#repo init
repo init -u https://github.com/crdroid-13-fork/android.git -b 13.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

#local_manifest
git clone https://github.com/muralivijay/crave-local_manifest/local_manifests.git -b 13.0 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

#Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=muralivijay
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

# Check keys before procced build
if [ -d "vendor/extra" ]; then
    echo "✓ Keys found for sign build. Proceeding build..."
    lunch lineage_spes-user && mka clean && mka clobber && mka bacon
else
    echo "✗ Error: keys not found Directory 'vendor/extra'."
    echo "Stopping script execution."
    exit 1
fi
