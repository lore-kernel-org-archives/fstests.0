Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC28386C0D
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802993; cv=none; b=uwkV/jcDawfwgY6Jj16rDGdJjzNgoitNzIpuBWgWu005sEk3ksgo8843/HJxXggPnW1gKQopF7b20lAjzHq+03eGSiNaNfj9MD2RWeQK53MTPeiXisTcvCFLKx/f6EwJKXvtIu+8NJcn/hPYTudy7iAi0Iuy+HJWqJe9sv7rdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802993; c=relaxed/simple;
	bh=nNlZQIV4fScV8ZIpuNXILz+CJLqPV93yA1nXX5UCJ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3SFZKj6hpZNsx6OpEtfvd2K3O0PRYfNX8FFEyRhLLxGqD7rqyMF0p/GWF4GmtMsmVo3fCbIGDTTOVTWpznmVo4KjPWCRmszK9OE98dnBMPrMEPrDU37nnvkbFPHoOctq2qF2F2Hg5hdfmDtelquVXeYQ4x90Wh4Tn3XnXKSQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gZeyv47V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gZeyv47V"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639NcZ2F2303490;
	Fri, 10 Apr 2026 06:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4EkCjKA1/HnjvZO0g
	nQegc5O6erDDDeFkA6eqZPcrck=; b=gZeyv47VzwLiudT04XyvpQrcCI3r4agNM
	aVv7RKHxDPuSJdhITUvlVjkV7KxQs/RbEd4e/nyLhqnFvXYuv+UpiGmb+/KbiAZI
	VDKH2h5p7tIFo2o6LbQpUOiQyvnRh73hX+G081T+41HoMEIGmIe5d0tcL1HFeQqM
	wGMHg+Gd2fxTpn091XjylilUMbZHyRzd8s+2rVjhWrbRRDIaywmDrWkeEsqHBAMc
	eH7kxQdehc7vNCAXER+tERpArxJK7qo6rOgyhyJ97ydCLtog8kzODV7l9V9jIXuN
	hfWpmLfSbrxqUmtwhmca/gzZzkzQNJLqjLJ8bHy+xGBdaGJ6b7YiA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2frn6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2jfMi018877;
	Fri, 10 Apr 2026 06:36:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9pvs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A6aNqY6357452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 06:36:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4AFA20043;
	Fri, 10 Apr 2026 06:36:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F6920040;
	Fri, 10 Apr 2026 06:36:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.bl1-in.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 06:36:21 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com
Subject: [PATCH 6/6] treewide: Use _sysfs_queue_path helper in all queue access locations
Date: Fri, 10 Apr 2026 12:06:06 +0530
Message-ID: <01fdf4d33a80159edbc53fbc57d856f794480c94.1775802601.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775802601.git.ojaswin@linux.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfX+BR7C6Nmosdt
 SvcGTOa+omNe6NhP/KPcK1lz+uUsgKebQFEHE18gm3I60Np1BHeOD7ifVCxp33+7dOW6TotS3Wu
 GKbnp6TLAnHkRVD5MTPY4AJf/kMZR6WxzYrFGHLCVEAcLXG8Xd0rtFlCM0wpu5gbx/eGCW7Yiru
 rXtA983FWeCQl2+v+Wl2fn9GJ0RbALn1QFEcCeKun3uLpw+MApt2DLa0gDxhjqxFSaR4cgzUU31
 QGdbX6Lz8+WLdqdZiKdsLQoNkVU3k8Ko07Poq6oDmuN/e8yI+YQsv/PbXDYHB+hiDMi47CwVrU9
 zTt7QKlOXutXoaORG3ftKD0FsEUa8mdsZnCIAeW118xq9QDktAxSnlNF5yUSNpiQWZNwDjMw57A
 kzrl2y5Dz3oWz6nDaHvxrdSVIbzVhLsNnSdmPuWYuI758KGYoAW7KIXDufaUy3wYAMr7o5ojKpf
 Z/uMSU7tGQHLCQi/Tig==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d89a6a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=kwf3MWuvCv0pIcOVibQA:9
X-Proofpoint-ORIG-GUID: zIAD09uXyb9SJEj68G4tl2sC8sFVeC-i
X-Proofpoint-GUID: 34YzCjxuoNlVxVIT8aMBcKmu0g4dwm7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056

The sysfs queue dir for partitions is present in their parent device's
sysfs dir. This requires extra checks when trying to reading queue data
from sysfs. Currently, fstests open codes this handling or straight up
ignores it in some places.

Avoid this by converting all remaining direct sysfs queue accesses to
use the _sysfs_queue_path helper function. This ensures proper handling
of partitions across the entire codebase and provides a consistent
interface for accessing queue attributes.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/encrypt  |  7 ++-----
 common/rc       | 12 ++++++++----
 common/report   | 20 +++++++++++---------
 common/zoned    |  5 +++--
 tests/btrfs/076 | 11 +++++++----
 tests/btrfs/237 |  5 +++--
 tests/btrfs/273 |  4 +++-
 tests/btrfs/283 |  4 +++-
 8 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/common/encrypt b/common/encrypt
index f2687631..c9e0853d 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -173,11 +173,8 @@ _require_hw_wrapped_key_support()
 	local dev=$1
 
 	echo "Checking for HW-wrapped key support on $dev" >> $seqres.full
-	local sysfs_dir=$(_sysfs_dev $dev)
-	if [ ! -e $sysfs_dir/queue ]; then
-		sysfs_dir=$sysfs_dir/..
-	fi
-	if [ ! -e $sysfs_dir/queue/crypto/hw_wrapped_keys ]; then
+	local queue_path=$(_sysfs_queue_path $dev)
+	if [ $? -ne 0 ] || [ ! -e $queue_path/crypto/hw_wrapped_keys ]; then
 		_notrun "$dev doesn't support hardware-wrapped inline encryption keys"
 	fi
 
diff --git a/common/rc b/common/rc
index d7db5db1..9632b211 100644
--- a/common/rc
+++ b/common/rc
@@ -2502,7 +2502,11 @@ __scratch_dev_has_dax()
 {
 	local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
 	test -e "${sysfs}/dax" && return 0
-	test "$(cat "${sysfs}/queue/dax" 2>/dev/null)" = "1" && return 0
+
+	local queue_path=$(_sysfs_queue_path $SCRATCH_DEV)
+	if [ $? -eq 0 ]; then
+		test "$(cat "${queue_path}/dax" 2>/dev/null)" = "1" && return 0
+	fi
 
 	return 1
 }
@@ -2562,10 +2566,10 @@ _zone_type()
 		echo "Usage: _zone_type <device>"
 		_exit 1
 	fi
-	local sdev=`_short_dev $target`
 
-	if [ -e /sys/block/${sdev}/queue/zoned ]; then
-		cat /sys/block/${sdev}/queue/zoned
+	local queue_path=$(_sysfs_queue_path $target)
+	if [ $? -eq 0 ] && [ -e "$queue_path/zoned" ]; then
+		cat "$queue_path/zoned"
 	else
 		echo none
 	fi
diff --git a/common/report b/common/report
index 7128bbeb..0d9ad78c 100644
--- a/common/report
+++ b/common/report
@@ -37,16 +37,18 @@ __generate_blockdev_report_vars() {
 
 	test -z "$bdev" && return
 	test -b "$bdev" || return
-	local sysfs_bdev="$(_sysfs_dev "$bdev")"
-
 	REPORT_VARS["${bdev_var}_SIZE_KB"]="$(( "$(blockdev --getsz "$bdev")" / 2 ))"
-	REPORT_VARS["${bdev_var}_ROTATIONAL"]="$(cat "$sysfs_bdev/queue/rotational" 2>/dev/null)"
-	REPORT_VARS["${bdev_var}_DAX"]="$(cat "$sysfs_bdev/queue/dax" 2>/dev/null)"
-	REPORT_VARS["${bdev_var}_DISCARD"]="$(sed -e 's/[1-9][0-9]*/1/g' "$sysfs_bdev/queue/discard_max_bytes" 2>/dev/null)"
-	REPORT_VARS["${bdev_var}_WRITE_ZEROES"]="$(sed -e 's/[1-9][0-9]*/1/g' "$sysfs_bdev/queue/write_zeroes_max_bytes" 2>/dev/null)"
-	REPORT_VARS["${bdev_var}_PHYS_BLOCK_BYTES"]="$(cat "$sysfs_bdev/queue/physical_block_size" 2>/dev/null)"
-	REPORT_VARS["${bdev_var}_LBA_BYTES"]="$(cat "$sysfs_bdev/queue/logical_block_size" 2>/dev/null)"
-	REPORT_VARS["${bdev_var}_ZONES"]="$(cat "$sysfs_bdev/queue/nr_zones" 2>/dev/null)"
+
+	local queue_path="$(_sysfs_queue_path "$bdev")"
+	if [ $? -eq 0 ]; then
+		REPORT_VARS["${bdev_var}_ROTATIONAL"]="$(cat "$queue_path/rotational" 2>/dev/null)"
+		REPORT_VARS["${bdev_var}_DAX"]="$(cat "$queue_path/dax" 2>/dev/null)"
+		REPORT_VARS["${bdev_var}_DISCARD"]="$(sed -e 's/[1-9][0-9]*/1/g' "$queue_path/discard_max_bytes" 2>/dev/null)"
+		REPORT_VARS["${bdev_var}_WRITE_ZEROES"]="$(sed -e 's/[1-9][0-9]*/1/g' "$queue_path/write_zeroes_max_bytes" 2>/dev/null)"
+		REPORT_VARS["${bdev_var}_PHYS_BLOCK_BYTES"]="$(cat "$queue_path/physical_block_size" 2>/dev/null)"
+		REPORT_VARS["${bdev_var}_LBA_BYTES"]="$(cat "$queue_path/logical_block_size" 2>/dev/null)"
+		REPORT_VARS["${bdev_var}_ZONES"]="$(cat "$queue_path/nr_zones" 2>/dev/null)"
+	fi
 }
 
 __import_report_vars() {
diff --git a/common/zoned b/common/zoned
index 88b81de5..89d0a061 100644
--- a/common/zoned
+++ b/common/zoned
@@ -17,8 +17,9 @@ _filter_blkzone_report()
 
 _require_limited_active_zones() {
     local dev=$1
-    local sysfs=$(_sysfs_dev ${dev})
-    local attr="${sysfs}/queue/max_active_zones"
+    local queue_path=$(_sysfs_queue_path ${dev})
+    [ $? -ne 0 ] && _notrun "cannot find queue path: $queue_path"
+    local attr="${queue_path}/max_active_zones"
 
     [ -e "${attr}" ] || _notrun "cannot find queue/max_active_zones. Maybe non-zoned device?"
     if [ $(cat "${attr}") == 0 ]; then
diff --git a/tests/btrfs/076 b/tests/btrfs/076
index c148406f..0a1e660d 100755
--- a/tests/btrfs/076
+++ b/tests/btrfs/076
@@ -28,10 +28,13 @@ _fixed_by_kernel_commit 4bcbb3325513 \
 # An extent size can be up to BTRFS_MAX_UNCOMPRESSED
 max_extent_size=$(( 128 * 1024 ))
 if _scratch_btrfs_is_zoned; then
-	zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
-	if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_size ]]; then
-		# Round down to PAGE_SIZE
-		max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
+	queue_path=$(_sysfs_queue_path $SCRATCH_DEV)
+	if [ $? -eq 0 ]; then
+		zone_append_max=$(cat "$queue_path/zone_append_max_bytes")
+		if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_size ]]; then
+			# Round down to PAGE_SIZE
+			max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
+		fi
 	fi
 fi
 file_size=$(( 10 * 1024 * 1024 ))
diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 675f4c42..07a56336 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -44,8 +44,9 @@ get_data_bg_physical()
 $BLKZONE_PROG report $SCRATCH_DEV | grep -q -e "nw" && \
 	_notrun "test is unreliable on devices with conventional zones"
 
-sdev="$(_short_dev $SCRATCH_DEV)"
-zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
+queue_path=$(_sysfs_queue_path $SCRATCH_DEV) || \
+    _notrun "Failed to get queue path: $queue_path"
+zone_size=$(($(cat "$queue_path/chunk_sectors") << 9))
 fssize=$((zone_size * 16))
 devsize=$(($(_get_device_size $SCRATCH_DEV) * 1024))
 # Create a minimal FS to kick the reclaim process
diff --git a/tests/btrfs/273 b/tests/btrfs/273
index 06ae5d53..60c3967b 100755
--- a/tests/btrfs/273
+++ b/tests/btrfs/273
@@ -38,7 +38,9 @@ _require_btrfs_command inspect-internal dump-tree
 # enabled.
 _require_no_compress
 
-max_active=$(cat $(_sysfs_dev ${SCRATCH_DEV})/queue/max_active_zones)
+queue_path=$(_sysfs_queue_path ${SCRATCH_DEV}) || \
+    _notrun "Failed to get queue path: $queue_path"
+max_active=$(cat "$queue_path/max_active_zones")
 
 # Fill the zones leaving the last 1MB
 fill_active_zones() {
diff --git a/tests/btrfs/283 b/tests/btrfs/283
index f7a8290a..9f89fafb 100755
--- a/tests/btrfs/283
+++ b/tests/btrfs/283
@@ -26,7 +26,9 @@ _wants_kernel_commit c7499a64dcf6 \
 
 extent_size=$(( 128 * 1024 ))
 if _scratch_btrfs_is_zoned; then
-	zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
+	queue_path=$(_sysfs_queue_path $SCRATCH_DEV) ||
+	    _notrun "Couldn't find queue path for zoned device"
+	zone_append_max=$(cat "$queue_path/zone_append_max_bytes")
 	if [[ $zone_append_max -gt 0 && $zone_append_max -lt $extent_size ]]; then
 		_notrun "zone append max $zone_append_max is smaller than wanted extent size $extent_size"
 	fi
-- 
2.53.0

