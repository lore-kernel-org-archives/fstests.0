Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633437;
	b=bOTwvXoAfwvHOtqYRkgQ3whzx9c04Ov3fS4P86VFmrFOfpnFj/SAKJ5unTzObwMw4MCr
	 Lgcqdgtom6wNtXp+598XqHleXe5QmlR7NPPHcxegbJ+cx3A+LzeKdd3JWaGmSLUjSkK0H
	 oZKmEeh7f+q7i1KsLRccxcFtrgTYTarkFBNFk4kkZruBaTzy1gvNrjYVw5c6uHJ8KbV31
	 LHDLypiQ2N/SfxCKLrM8gh4J+rQ9DXBkQe1LeiipaiVKeIxxmDZX1CTpEoLnF1HfNfpUz
	 YdmEh9fuHBzjVnGdFW0bngvL/P5MJFfXKJQ/inU7pouFHXNX7VwaWYQZwcaM+VK8epw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633437;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bFQFj5valIfj1nxeEXh8W+3tIjxFRbGNFX8KuKpdVTA=;
	b=eoOvEk/eSXPisQdrCKjwHeHb+HPTQhVtWouv2UWh7fef7kktf4AnrEWzUCXTa00s0SAi
	 g0/CaCtbeRbO9ZpDjPo+WrjvFi9W8SEyMtqYFtbboiWFRNA+MgjzWIt8qf24+mOfjOGWn
	 oyuvPYOJ7F7DQI7HyQjyY5FmFSAl9pMS1Xe82/yqoR/xf3u85uzuU9fWK2UE7FZZUDm/i
	 Wk4Knr0A6Q8FwC55sOSCysNfItcwQCgo0bvq05Pyd4ANotMPrMjqrn7cUoaJVqdoMGwMj
	 dcqsHGRYHZweYeaaRksC92hgGD9fEINSIKyeUK3SG0A60H3/jMtf7Y8W11uSNvaSGrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms67BmLh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8A606A323;
	Wed, 25 Nov 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms67BmLh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795633436;
	b=H+n33gM32VihvGxu/oGJCw8N+5v8EUXFm8xDemphfJr5ikPjXxu6ymUZsSXWM8PFfuH0
	 9mnJFfdtWPww1envxBnDQRCbiwc7qtZscSSCW0n8eFxCzGhFSjF6C6Yv6MSReer9d068K
	 S4k+3xGTYpfsM4MO6d0zpWTgxHnRGSiv8MNm+O/bSGS6tjYt0g5u7fCTs5ez6H+Opyi6V
	 CAoInjfpR/v9FfYhvT/zlNO/gt76HrvoyfTPLqYuzr1hc+sp66mPhR4jX6tsk1jod4CaB
	 Y3PdoKpu+hPURcVzCsxKZib8/kZaDr8NQ9/IRAVJ9RBE+jHDlUlKy5F7Ce1uk6uKxNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795633436;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bFQFj5valIfj1nxeEXh8W+3tIjxFRbGNFX8KuKpdVTA=;
	b=dN7TeDP4fRvbIMxJ9SB0rNhMrBAqAmfnrNfbZyPu5IMfmtmVg7THrKBGaxJLEZTFexGL
	 BjMpr5g6IRGeN/zDWZEkJuYAB5wK6KLZQ5t73+1JOy5LlBjcd7G5qrbUsDG4Ucr8SR9ov
	 rAIlOS0X84mi4FgD+btJQfE0gfBGbNeofQWHWMg+2A5V89cIkJ/xWrkSIT1F1ByeFrtVb
	 TcpYex8CWZ8GP4bHC+q4g+/QT5+z+8NxDnB4UsXgfQ6uvUtAR1QV5tRSH9N5AjsuJyk4U
	 VY4KEigyaBzFm6bL+oQrq5WyHsRuiNKW3SvT3K6RLOx/09cIM1cam0PGyzIuiMLqkFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9004B1F000CA;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633436;
	bh=bFQFj5valIfj1nxeEXh8W+3tIjxFRbGNFX8KuKpdVTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ms67BmLh0V3M3iIgFjiediIXaaLWrC0Zc67FmJ03Hayq2VQvH9oa16HUyhhJBfS10
	 j2iZfhiaippwzfqCLmeAOHdoGMbhVlw5seFOEwFi/3EzBWCYX1nsAsho2H7QgovrLc
	 Jzw38HP5xLq48wzo5cjaVU4JXo+9K3EkKHx8gx3jBPJzfmUVnDyfh3f9/nk5xG2Exv
	 q9wgn4ek36gikFA2RL6+NmmBvCwCkgIMG7a+ZCjKHRqv+lJ/1R3p1+Les18XhYvmMF
	 BTSmi0PUO3M9S6zlK03dQmBgSYxOVC7gRECkOoipXYPzoKxECx+05k9+hCgqQLsPCy
	 Pp8uoKVCIU5Cg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 146324CFD9;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Wed, 25 Nov 2026 20:03:43 +0100
Subject: [PATCH 1/4] common: add support for the ntfs driver
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-ntfs-reproducers-v1-1-0cc67533d803@proton.me>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
In-Reply-To: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5171;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=1GKZuARJn7zy6GxqUepj3DnNsqVUAqgax3wRkoiSBi0=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmx2Q77tByNVj+7/avihgKGk8nXaF9UHYptlz+0+9No/j
 9eY/2dsRykLgxgXg6yYIkvH/xshPiHfPi2L0+qDmcPKBDKEgYtTACayuprhf+5Gg8ZfVfO9QpNS
 hH9/Nc3L/Xa/R6fIafHehh88dyTTFjAyTPecXcs1fd6tk+fjrp9hE9m598aku5L1GsWHPt6V27I
 gkg8A
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

Volumes for the ntfs driver (fs/ntfs) are made and checked with mkfs.ntfs
and fsck.ntfs from ntfsprogs-plus, but FSTYP=ntfs only gets the generic
fallbacks today. mkfs.ntfs zeroes the whole device unless it is given
--quick and refuses a device that is not a partition unless it is given
--force, _scratch_mkfs_sized and _scratch_mkfs_blocksized skip every test
that calls them, and the tests that require metadata journaling run
although the driver only checks and empties $LogFile at mount and never
logs a change. Call mkfs.ntfs directly with --quick and --force and filter
its warnings about the device geometry, pass the size to mkfs.ntfs in
sectors and the block size as the cluster size unless MKFS_OPTIONS sets one
(mkfs.ntfs refuses a second -c), check that mkfs.ntfs and fsck.ntfs are
installed, and list ntfs among the filesystems without metadata journaling.
Mount with -i, so that mount -t ntfs always uses the kernel driver and
never a mount.ntfs helper.
The check keeps the generic "fsck -t ntfs -n" path, which runs ntfsck.

Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 common/config |  9 +++++++++
 common/rc     | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 69e5d833..2b164c7d 100644
--- a/common/config
+++ b/common/config
@@ -335,6 +335,7 @@ export MKFS_AFS_PROG="false"
 export MKFS_CIFS_PROG="false"
 export MKFS_OVERLAY_PROG="false"
 export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
+export MKFS_NTFS_PROG=$(type -P mkfs.ntfs)
 export E2FSCK_PROG=$(type -P e2fsck)
 export TUNE2FS_PROG=$(type -P tune2fs)
 export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
@@ -409,6 +410,10 @@ _common_mount_opts()
 	ubifs)
 		echo $UBIFS_MOUNT_OPTIONS
 		;;
+	ntfs)
+		# -i: always mount the kernel driver, never a mount.ntfs helper
+		echo "-i $NTFS_MOUNT_OPTIONS"
+		;;
 	*)
 		;;
 	esac
@@ -550,6 +555,10 @@ _source_specific_fs()
 		;;
 	pvfs2)
 		;;
+	ntfs)
+		[ "$MKFS_NTFS_PROG" = "" ] && _fatal "mkfs.ntfs not found"
+		type -P fsck.ntfs >/dev/null || _fatal "fsck.ntfs not found"
+		;;
 	ubifs)
 		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
 		. ./common/ubifs
diff --git a/common/rc b/common/rc
index 750a8d83..2c37bdb1 100644
--- a/common/rc
+++ b/common/rc
@@ -904,6 +904,9 @@ _test_mkfs()
     btrfs)
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
+    ntfs)
+	$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $* $TEST_DEV > /dev/null
+	;;
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
@@ -953,6 +956,9 @@ _try_mkfs_dev()
     btrfs)
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $*
 	;;
+    ntfs)
+	$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $*
+	;;
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
 	;;
@@ -1069,6 +1075,15 @@ _scratch_mkfs()
 		mkfs_cmd="$MKFS_BCACHEFS_PROG"
 		mkfs_filter="cat"
 		;;
+	ntfs)
+		# --quick skips zeroing the whole device, --force formats a
+		# device that is not a partition; drop the warnings about that
+		# and about the boot geometry of such a device
+		mkfs_cmd="$MKFS_NTFS_PROG --quick --force"
+		mkfs_filter="grep -v -e \"is entire device\" -e \"forced anyway\""
+		mkfs_filter+=" -e \"could not be obtained automatically\""
+		mkfs_filter+=" -e \"boot from\""
+		;;
 	*)
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="cat"
@@ -1313,6 +1328,9 @@ _try_scratch_mkfs_sized()
 		# If no block size is given by local.confg or parameter, blocksize_opt is empty.
 		# Let MKFS_BCACHEFS_PROG decide block size on its own.
 		;;
+	ntfs)
+		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-c|--cluster-size)[ =]?+([0-9]+).*/\2/p'`
+		;;
 	esac
 
 	[ -n "$def_blksz" ] && blocksize=$def_blksz
@@ -1425,6 +1443,16 @@ _try_scratch_mkfs_sized()
 	bcachefs)
 		$MKFS_BCACHEFS_PROG $MKFS_OPTIONS --fs_size=$fssize $blocksize_opt "$@" $SCRATCH_DEV
 		;;
+	ntfs)
+		# mkfs.ntfs refuses a second -c, and takes the size in sectors
+		# after the device
+		local cluster_opt="-c $blocksize"
+		local sector_size=`blockdev --getss $SCRATCH_DEV`
+
+		[ -n "$def_blksz" ] && cluster_opt=""
+		$MKFS_NTFS_PROG --quick --force $MKFS_OPTIONS $cluster_opt "$@" \
+			$SCRATCH_DEV $((fssize / sector_size))
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 		;;
@@ -1517,6 +1545,13 @@ _scratch_mkfs_blocksized()
 	udf)
 		_scratch_mkfs -b $blocksize
 		;;
+	ntfs)
+		# mkfs.ntfs refuses a second -c, so the size asked for here
+		# replaces one in MKFS_OPTIONS
+		MKFS_OPTIONS=$(echo $MKFS_OPTIONS | \
+			sed -E 's/(-c|--cluster-size)[ =]?[0-9]+//') \
+			_scratch_mkfs -c $blocksize
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
 		;;
@@ -4386,7 +4421,7 @@ _has_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
-	ext2|vfat|msdos|udf|exfat|tmpfs|hfs|hfsplus)
+	ext2|vfat|msdos|udf|exfat|ntfs|tmpfs|hfs|hfsplus)
 		echo "$FSTYP does not support metadata journaling"
 		return 1
 		;;

-- 
2.56.1


