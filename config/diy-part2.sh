# Modify some code adaptation
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.2/g' package/base-files/files/bin/config_generate

svn co https://github.com/vernesong/OpenClash.git package/feeds/luci-app-openclash
git clone https://github.com/xiaorouji/openwrt-passwall.git package/feeds/luci-app-passwall

svn co https://github.com/chenhw2/luci-app-aliddns.git package/feeds/luci-app-aliddns

rm -rf feeds/luci/themes/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
#阿里云web dav
git clone https://github.com/messense/aliyundrive-webdav.git package/feeds/luci-app-aliyundrive-webdav
#adguardhome
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/feeds/luci-app-adguardhome
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
