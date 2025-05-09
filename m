Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60E269AE7
	for <fstests@vger.kernel.org>; Fri,  9 May 2025 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770985; cv=none; b=Ep2aHTE3SBk5PfF5DKnznU3VSepcwL4ilR2u6xTgAZa7T8heiMigY6KG4WWEI11dfKF78xN6yNyZBgAq3N7LnomCoAX+AEVjKArwrFXhMisDoB2qMbDpRl/7NFdkZ6MYx24xIIbyW1Af3RyJpQkJXTQ7qrfbIkFWjTlneRmgV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770985; c=relaxed/simple;
	bh=ts6dz0mXFTHUyu569wzEgxpCu+l2MA/xM2kMdf2dulE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=bIGVQB7ekf+9Ao9knLHTp5lvOre4GJ24DiUcG1y3gyZZS7yYPnTXJEHjRZU3PmvA9hMZd7fIOxzY7j3Gq9xSHeP2l0JnyCdQwtJ/ePxoXvsymwzGE0jphtEspLcYD50P2z7+R95kgFh05PbA75RBHonep6rQW+kvJ5E18O8cvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MnjbZ96G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MnjbZ96G"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494Bxtk029519;
	Fri, 9 May 2025 06:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qxN1ql
	2mMJTQbR3gyiF/6byQKcgCGc36XlCWbfC99ts=; b=MnjbZ96G8RnQPTh9oNOHrD
	VHqI6N5SFAD2F35L0XY02garSefKsOTEmTlKU4leeO86Zn6wni1QB0QRtXvTGDZo
	0o7NhioELT678t11RGwiv+Oe7Ct6guRX7FtUQs//0pFCLmiBuLm3WV/WO9gkVMw1
	pysrvLksYVxAgwJYO7EDMagPoWNZSyRIBYgNirYFHUWsFb364gdSNcHqZEdGdgey
	XhPKHiJ+mqkoirl92V9KMJouIuSJOj6gjeLMzKYxDqTJljkYGrnp2VUgl4jrisOT
	QkTfmmVAS3MZdQ0ZF/sqdHwzCDOoH4ly8eTXrD3TKbLy1O6z9xESm6/jZEq0MTuQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0hetx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:09:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54969ZOr014845;
	Fri, 9 May 2025 06:09:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0hetv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:09:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5494u4kK001316;
	Fri, 9 May 2025 06:09:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftsxck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:09:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54969X4V55509316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 06:09:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59AAD20163;
	Fri,  9 May 2025 06:09:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4244420142;
	Fri,  9 May 2025 06:09:32 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com (unknown [9.39.25.103])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 06:09:32 +0000 (GMT)
Message-ID: <6b126bce9ad8bc7cf7f6e0205c905082785ef4c5.camel@linux.ibm.com>
Subject: Re: [PATCH 12/28] config: move config section code to it's own file
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org, ritesh.list@gmail.com
Date: Fri, 09 May 2025 11:39:30 +0530
In-Reply-To: <20250417031208.1852171-13-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-13-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nSRIspgNotFuFy8r6ywzcHEh0VHzuXCM
X-Proofpoint-ORIG-GUID: NwkR06F2FVfjHkETtg0c9ufdHf8o-h0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA1NyBTYWx0ZWRfX5o+J1Qq0nHZH EyvT6dLGGI99p7KRPMRNZ+9wsCzLnmCEm9WOEhx8mHgpQh43U246u4C9hwESk4QxOQrZFtKDJpB UpZwceOTJBk8SYHAwhOCkNCqoUQAZ7YQC24ug6JmMk1AOSRiRKjYokXWVtvyBQyUxRHP24/THoW
 ywcxU+bjejvjlCaMJEovjU6enTd/0yHnRAYNtqYljjwSijyFrP3jUEDLrHQAuh8QTgBcET6UE9J q8nZa5ZoI1uK9pKiiuBJvEf8MRPtkA1+Sg4I9vcFdxYxLsn70hRlheHBo2XeONV/3UhMRwHnOgy LC9SQ9rDst5wtNR1fytbAVseZ1swJBA/ovoHh+LD+9dRG+hrXvouK8kDP7WRW5449x/YI6un5FK
 stiA6u43jgZgIcXoLSqPY7S9cM9XuKq5Prj9sL4MJQ+JXICzMOiYGGNT5l83vvaXsZ7LxkBp
X-Authority-Analysis: v=2.4 cv=OcCYDgTY c=1 sm=1 tr=0 ts=681d9c20 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=N6qv2wVp750lJRuKdpwA:9
 a=789OqMIviInqCUNi:21 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090057

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Move the config section parsing, checking and setup code from
> common/config to common/config-section so that it can be included
> directly in contexts where the rest of common/config is not needed.
This looks okay to me. Just a couple of nits comments below.

Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Ritesh - this patch addresses one of feedbacks[1] on one of my cleanup
patches.
[1] https://lore.kernel.org/all/87r028vamn.fsf@gmail.com/
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/config          | 382 +---------------------------------------
>  common/config-sections | 390 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 392 insertions(+), 380 deletions(-)
>  create mode 100644 common/config-sections
> 
> diff --git a/common/config b/common/config
> index 5081c300a..f90a66862 100644
> --- a/common/config
> +++ b/common/config
> @@ -41,6 +41,7 @@
>  
>  . common/test_names
>  . common/exit
> +. common/config-sections
>  
>  # all tests should use a common language setting to prevent golden
>  # output mismatches.
> @@ -544,386 +545,7 @@ _source_specific_fs()
>  	esac
>  }
>  
> -known_hosts()
> -{
> -	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
> -
> -	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
> -	[ -f $HOST_CONFIG_DIR/$HOST ]        && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST
> -	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
> -}
> -
> -# Returns a list of sections in config file
> -# Each section starts with the section name in the format
> -# [section_name1]. Only alphanumeric characters and '_' is allowed
> -# in the section name otherwise the section will not be resognised.
> -# Section name must be contained between square brackets.
> -get_config_sections() {
> -	sed -n -e "s/^\[\([[:alnum:]_-]*\)\]/\1/p" < $1
> -}
> -
> -if [ ! -f "$HOST_OPTIONS" ]; then
> -	known_hosts
> -fi
> -
> -export HOST_OPTIONS_SECTIONS="-no-sections-"
> -export OPTIONS_HAVE_SECTIONS=false
> -if [ -f "$HOST_OPTIONS" ]; then
> -	export HOST_OPTIONS_SECTIONS=`get_config_sections $HOST_OPTIONS`
> -	if [ -z "$HOST_OPTIONS_SECTIONS" ]; then
> -		. $HOST_OPTIONS
> -		export HOST_OPTIONS_SECTIONS="-no-sections-"
> -	else
> -		export OPTIONS_HAVE_SECTIONS=true
> -	fi
> -fi
> -
> -_check_device()
> -{
> -	local name=$1
> -	local dev_needed=$2
> -	local dev=$3
> -
> -	if [ -z "$dev" ]; then
> -		if [ "$dev_needed" == "required" ]; then
> -			_fatal "common/config: $name is required but not defined!"
> -		fi
> -		return 0
> -	fi
> -
> -	if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
> -		# block device or a network url
> -		return 0
> -	fi
> -
> -	case "$FSTYP" in
> -	9p|fuse|tmpfs|virtiofs|afs)
> -		# 9p, fuse, virtiofs and afs mount tags are just plain strings,
> -		# so anything is allowed tmpfs doesn't use mount source, ignore
> -		;;
> -	ceph)
> -		# ceph has two different possible syntaxes for mount devices. The
> -		# network URL check above catches the legacy syntax. Check for the
> -		# new-style syntax here.
> -		if ( echo $dev | grep -qEv "=/" ); then
> -			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
> -		fi
> -		;;
> -	overlay)
> -		if [ ! -d "$dev" ]; then
> -			_fatal "common/config: $name ($dev) is not a directory for overlay"
> -		fi
> -		;;
> -	ubifs)
> -		if [ ! -c "$dev" ]; then
> -			_fatal "common/config: $name ($dev) is not a character device"
> -		fi
> -		;;
> -	ceph-fuse)
> -		;;
> -	*)
> -		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
> -	esac
> -}
> -
> -# check and return a canonical mount point path
> -_canonicalize_mountpoint()
> -{
> -	local name=$1
> -	local dir=$2
> -
> -	if [ -d "$dir" ]; then
> -		# this follows symlinks and removes all trailing "/"s
> -		readlink -e "$dir"
> -		return 0
> -	fi
> -
> -	if [ "$FSTYP" != "overlay" ] || [[ "$name" == OVL_BASE_* ]]; then
> -		_fatal "common/config: $name ($dir) is not a directory"
> -	fi
> -
> -	# base fs may not be mounted yet, so just check that parent dir
> -	# exists (where base fs will be mounted) because we are going to
> -	# mkdir the overlay mount point dir anyway
> -	local base=`basename $dir`
> -	local parent=`dirname $dir`
> -	parent=`_canonicalize_mountpoint OVL_BASE_$name "$parent"`
> -
> -	# prepend the overlay mount point to canonical parent path
> -	echo "$parent/$base"
> -}
> -
> -# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
> -# over reboots
> -_canonicalize_devices()
> -{
> -	if [ "$CANON_DEVS" != "yes" ]; then
> -		return
> -	fi
> -	[ -L "$TEST_DEV" ]	&& TEST_DEV=$(readlink -e "$TEST_DEV")
> -	[ -L "$SCRATCH_DEV" ]	&& SCRATCH_DEV=$(readlink -e "$SCRATCH_DEV")
> -	[ -L "$TEST_LOGDEV" ]	&& TEST_LOGDEV=$(readlink -e "$TEST_LOGDEV")
> -	[ -L "$TEST_RTDEV" ]	&& TEST_RTDEV=$(readlink -e "$TEST_RTDEV")
> -	[ -L "$SCRATCH_RTDEV" ]	&& SCRATCH_RTDEV=$(readlink -e "$SCRATCH_RTDEV")
> -	[ -L "$LOGWRITES_DEV" ]	&& LOGWRITES_DEV=$(readlink -e "$LOGWRITES_DEV")
> -	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> -		local NEW_SCRATCH_POOL=""
> -		for i in $SCRATCH_DEV_POOL; do
> -			if [ -L $i ]; then
> -				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
> -			else
> -				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i"
> -			fi
> -		done
> -		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
> -	fi
> -}
> -
> -# On check -overlay, for the non multi section config case, this
> -# function is called on every test, before init_rc().
> -# When SCRATCH/TEST_* vars are defined in config file, config file
> -# is sourced on every test and this function overrides the vars
> -# every time.
> -# When SCRATCH/TEST_* vars are defined in evironment and not
> -# in config file, this function is called after vars have already
> -# been overriden in the previous test.
> -# In that case, TEST_DEV is a directory and not a blockdev/chardev and
> -# the function will return without overriding the SCRATCH/TEST_* vars.
> -_overlay_config_override()
> -{
> -	# There are 2 options for configuring overlayfs tests:
> -	#
> -	# 1. (legacy) SCRATCH/TEST_DEV point to existing directories
> -	#    on an already mounted fs.  In this case, the new
> -	#    OVL_BASE_SCRATCH/TEST_* vars are set to use the legacy
> -	#    vars values (even though they may not be mount points).
> -	#
> -	[ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
> -	[ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
> -
> -	# Config file may specify base fs type, but we obay -overlay flag
> -	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> -	export FSTYP=overlay
> -
> -	# 2. SCRATCH/TEST_DEV point to the base fs partitions.  In this case,
> -	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
> -	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
> -	#    overlayfs base and mount dirs inside base fs mount.
> -	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
> -
> -	# Store original base fs vars
> -	export OVL_BASE_TEST_DEV="$TEST_DEV"
> -	export OVL_BASE_TEST_DIR="$TEST_DIR"
> -	# If config does not set MOUNT_OPTIONS, its value may be
> -	# leftover from previous _overlay_config_override, so
> -	# don't use that value for base fs mount
> -	[ "$MOUNT_OPTIONS" != "$OVERLAY_MOUNT_OPTIONS" ] || unset MOUNT_OPTIONS
> -	export OVL_BASE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
> -
> -	# Set TEST vars to overlay base and mount dirs inside base fs
> -	export TEST_DEV="$OVL_BASE_TEST_DIR"
> -	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
> -	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
> -
> -	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
> -
> -	# Store original base fs vars
> -	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> -	export OVL_BASE_SCRATCH_MNT="$SCRATCH_MNT"
> -
> -	# Set SCRATCH vars to overlay base and mount dirs inside base fs
> -	export SCRATCH_DEV="$OVL_BASE_SCRATCH_MNT"
> -	export SCRATCH_MNT="$OVL_BASE_SCRATCH_MNT/$OVL_MNT"
> -
> -	# Set fsck options, use default if user not set directly.
> -	export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
> -	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> -	export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
> -}
> -
> -_overlay_config_restore()
> -{
> -	export OVERLAY=true
> -	[ -z "$OVL_BASE_FSTYP" ] || export FSTYP=$OVL_BASE_FSTYP
> -	[ -z "$OVL_BASE_TEST_DEV" ] || export TEST_DEV=$OVL_BASE_TEST_DEV
> -	[ -z "$OVL_BASE_TEST_DIR" ] || export TEST_DIR=$OVL_BASE_TEST_DIR
> -	[ -z "$OVL_BASE_SCRATCH_DEV" ] || export SCRATCH_DEV=$OVL_BASE_SCRATCH_DEV
> -	[ -z "$OVL_BASE_SCRATCH_MNT" ] || export SCRATCH_MNT=$OVL_BASE_SCRATCH_MNT
> -	[ -z "$OVL_BASE_MOUNT_OPTIONS" ] || export MOUNT_OPTIONS=$OVL_BASE_MOUNT_OPTIONS
> -}
> -
> -# Parse config section options. This function will parse all the configuration
> -# within a single section which name is passed as an argument. For section
> -# name format see comments in get_config_sections().
> -# Empty lines and everything after '#' will be ignored.
> -# Configuration options should be defined in the format
> -#
> -# CONFIG_OPTION=value
> -#
> -# This 'CONFIG_OPTION' variable and will be exported as an environment variable.
> -parse_config_section() {
> -	SECTION=$1
> -	if ! $OPTIONS_HAVE_SECTIONS; then
> -		return 0
> -	fi
> -	eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
> -		-e 's/#.*$//' \
> -		-e 's/[[:space:]]*$//' \
> -		-e 's/^[[:space:]]*//' \
> -		-e "s/^\([^=]*\)=\"\?'\?\([^\"']*\)\"\?'\?$/export \1=\"\2\"/" \
> -		< $HOST_OPTIONS \
> -		| sed -n -e "/^\[$SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
> -}
> -
> -get_next_config() {
> -	if [ ! -z "$CONFIG_INCLUDED" ] && ! $OPTIONS_HAVE_SECTIONS; then
> -		return 0
> -	fi
> -
> -	# We might have overriden FSTYP and TEST/SCRATCH vars with overlay values
> -	# in the previous section, so restore them to original values stored in
> -	# OVL_BASE_*.
> -	# We need to do this *before* old FSTYP and MOUNT_OPTIONS are recorded
> -	# and *before* SCRATCH_DEV and MOUNT_OPTIONS are unset
> -	if [ "$FSTYP" == "overlay" ]; then
> -		_overlay_config_restore
> -	fi
> -
> -	local OLD_FSTYP=$FSTYP
> -	local OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
> -	local OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
> -	local OLD_MKFS_OPTIONS=$MKFS_OPTIONS
> -	local OLD_FSCK_OPTIONS=$FSCK_OPTIONS
> -	local OLD_USE_EXTERNAL=$USE_EXTERNAL
> -
> -	unset MOUNT_OPTIONS
> -	unset TEST_FS_MOUNT_OPTS
> -	unset MKFS_OPTIONS
> -	unset FSCK_OPTIONS
> -	unset USE_EXTERNAL
> -
> -	# We might have deduced SCRATCH_DEV from the SCRATCH_DEV_POOL in the previous
> -	# run, so we have to unset it now.
> -	if [ "$SCRATCH_DEV_NOT_SET" == "true" ]; then
> -		unset SCRATCH_DEV
> -	fi
> -
> -	parse_config_section $1
> -	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
> -		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
> -		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
> -		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
> -		[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> -
> -		# clear the external devices if we are not using them
> -		if [ -z "$USE_EXTERNAL" ]; then
> -			unset TEST_RTDEV
> -			unset TEST_LOGDEV
> -			unset SCRATCH_RTDEV
> -			unset SCRATCH_LOGDEV
> -		fi
> -	else
> -		[ -z "$MOUNT_OPTIONS" ] && export MOUNT_OPTIONS=$OLD_MOUNT_OPTIONS
> -		[ -z "$TEST_FS_MOUNT_OPTS" ] && export TEST_FS_MOUNT_OPTS=$OLD_TEST_FS_MOUNT_OPTS
> -		[ -z "$MKFS_OPTIONS" ] && export MKFS_OPTIONS=$OLD_MKFS_OPTIONS
> -		[ -z "$FSCK_OPTIONS" ] && export FSCK_OPTIONS=$OLD_FSCK_OPTIONS
> -		[ -z "$USE_EXTERNAL" ] && export USE_EXTERNAL=$OLD_USE_EXTERNAL
> -	fi
> -
> -	# set default RESULT_BASE
> -	if [ -z "$RESULT_BASE" ]; then
> -		export RESULT_BASE="$here/results/"
> -	fi
> -
> -	if [ "$FSTYP" == "tmpfs" ]; then
> -		if [ -z "$TEST_DEV" ]; then
> -			export TEST_DEV=tmpfs_test
> -		fi
> -		if [ -z "$SCRATCH_DEV" ]; then
> -			export TEST_DEV=tmpfs_scratch
> -		fi
> -	fi
> -
> -	#  Mandatory Config values.
> -	MC=""
> -	[ -z "$EMAIL" ]          && MC="$MC EMAIL"
> -	[ -z "$TEST_DIR" ]       && MC="$MC TEST_DIR"
> -	[ -z "$TEST_DEV" ]       && MC="$MC TEST_DEV"
> -
> -	if [ -n "$MC" ]; then
> -		echo "Warning: need to define parameters for host $HOST"
> -		echo "       or set variables:"
> -		echo "       $MC"
> -		_exit 1
> -	fi
> -
> -	_check_device TEST_DEV required $TEST_DEV
> -	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
> -
> -	# a btrfs tester will set only SCRATCH_DEV_POOL, we will put first of its dev
> -	# to SCRATCH_DEV and rest to SCRATCH_DEV_POOL to maintain the backward compatibility
> -	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> -		if [ ! -z "$SCRATCH_DEV" ]; then
> -			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
> -			_exit 1
> -		fi
> -		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> -		export SCRATCH_DEV
> -		export SCRATCH_DEV_NOT_SET=true
> -	fi
> -
> -	_check_device SCRATCH_DEV optional $SCRATCH_DEV
> -	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
> -
> -	if [ -n "$USE_EXTERNAL" ]; then
> -		_check_device TEST_RTDEV optional $TEST_RTDEV
> -		_check_device TEST_LOGDEV optional $TEST_LOGDEV
> -		_check_device SCRATCH_RTDEV optional $SCRATCH_RTDEV
> -		_check_device SCRATCH_LOGDEV optional $SCRATCH_LOGDEV
> -	fi
> -
> -	# Override FSTYP from config when running ./check -overlay
> -	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs.
> -	# We need to do this *after* default mount options are set by base FSTYP
> -	# and *after* SCRATCH_DEV is deduced from SCRATCH_DEV_POOL
> -	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
> -		_overlay_config_override
> -	fi
> -}
> -
> -if [ -z "$CONFIG_INCLUDED" ]; then
> -	get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
> -	export CONFIG_INCLUDED=true
> -
> -	# Autodetect fs type based on what's on $TEST_DEV unless it's been set
> -	# externally
> -	if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
> -		FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
> -	fi
> -	FSTYP=${FSTYP:=xfs}
> -	export FSTYP
> -	[ -z "$MOUNT_OPTIONS" ] && _mount_opts
> -	[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
> -	[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
> -	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> -else
> -	# We get here for the non multi section case, on every test that sources
> -	# common/rc after re-sourcing the HOST_OPTIONS config file.
> -	# Because of this re-sourcing, we need to re-canonicalize the configured
> -	# mount points and re-override TEST/SCRATCH_DEV overlay vars.
> -
> -	# canonicalize the mount points
> -	# this follows symlinks and removes all trailing "/"s
> -	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
> -	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
> -
> -	# Override FSTYP from config when running ./check -overlay
> -	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs
> -	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
> -		_overlay_config_override
> -	fi
> -fi
> -
> +_config_section_setup
>  _canonicalize_devices
>  # mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
>  # and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
> diff --git a/common/config-sections b/common/config-sections
> new file mode 100644
> index 000000000..69a03375a
> --- /dev/null
> +++ b/common/config-sections
> @@ -0,0 +1,390 @@
> +##/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2000-2003,2006 Silicon Graphics, Inc.  All Rights Reserved.
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# Config section parsing and setup code
Since we want to facilitate sourcing of this file independently, should
we at least mention in the comments some of the dependant files this
file needs to be sourced? For example, this file uses _exit() - so
usage of this file requires common/exit to be sourced?
> +
> +_check_device()
> +{
> +	local name=$1
> +	local dev_needed=$2
> +	local dev=$3
> +
> +	if [ -z "$dev" ]; then
> +		if [ "$dev_needed" == "required" ]; then
> +			_fatal "common/config: $name is required but not defined!"
> +		fi
> +		return 0
> +	fi
> +
> +	if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
> +		# block device or a network url
> +		return 0
> +	fi
> +
> +	case "$FSTYP" in
> +	9p|fuse|tmpfs|virtiofs|afs)
> +		# 9p, fuse, virtiofs and afs mount tags are just plain strings,
> +		# so anything is allowed tmpfs doesn't use mount source, ignore
> +		;;
> +	ceph)
> +		# ceph has two different possible syntaxes for mount devices. The
> +		# network URL check above catches the legacy syntax. Check for the
> +		# new-style syntax here.
> +		if ( echo $dev | grep -qEv "=/" ); then
> +			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
> +		fi
> +		;;
> +	overlay)
> +		if [ ! -d "$dev" ]; then
> +			_fatal "common/config: $name ($dev) is not a directory for overlay"
> +		fi
> +		;;
> +	ubifs)
> +		if [ ! -c "$dev" ]; then
> +			_fatal "common/config: $name ($dev) is not a character device"
> +		fi
> +		;;
> +	ceph-fuse)
> +		;;
> +	*)
> +		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
Nit: 80 chars limit exceed.
> +	esac
> +}
> +
> +# check and return a canonical mount point path
> +_canonicalize_mountpoint()
> +{
> +	local name=$1
> +	local dir=$2
> +
> +	if [ -d "$dir" ]; then
> +		# this follows symlinks and removes all trailing "/"s
> +		readlink -e "$dir"
> +		return 0
> +	fi
> +
> +	if [ "$FSTYP" != "overlay" ] || [[ "$name" == OVL_BASE_* ]]; then
> +		_fatal "common/config: $name ($dir) is not a directory"
> +	fi
> +
> +	# base fs may not be mounted yet, so just check that parent dir
> +	# exists (where base fs will be mounted) because we are going to
> +	# mkdir the overlay mount point dir anyway
> +	local base=`basename $dir`
> +	local parent=`dirname $dir`
> +	parent=`_canonicalize_mountpoint OVL_BASE_$name "$parent"`
> +
> +	# prepend the overlay mount point to canonical parent path
> +	echo "$parent/$base"
> +}
> +
> +# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
> +# over reboots
> +_canonicalize_devices()
> +{
> +	if [ "$CANON_DEVS" != "yes" ]; then
> +		return
> +	fi
> +	[ -L "$TEST_DEV" ]	&& TEST_DEV=$(readlink -e "$TEST_DEV")
> +	[ -L "$SCRATCH_DEV" ]	&& SCRATCH_DEV=$(readlink -e "$SCRATCH_DEV")
> +	[ -L "$TEST_LOGDEV" ]	&& TEST_LOGDEV=$(readlink -e "$TEST_LOGDEV")
> +	[ -L "$TEST_RTDEV" ]	&& TEST_RTDEV=$(readlink -e "$TEST_RTDEV")
> +	[ -L "$SCRATCH_RTDEV" ]	&& SCRATCH_RTDEV=$(readlink -e "$SCRATCH_RTDEV")
> +	[ -L "$LOGWRITES_DEV" ]	&& LOGWRITES_DEV=$(readlink -e "$LOGWRITES_DEV")
> +	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> +		local NEW_SCRATCH_POOL=""
> +		for i in $SCRATCH_DEV_POOL; do
> +			if [ -L $i ]; then
> +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
> +			else
> +				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i"
> +			fi
> +		done
> +		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
> +	fi
> +}
> +
> +# On check -overlay, for the non multi section config case, this
> +# function is called on every test, before init_rc().
> +# When SCRATCH/TEST_* vars are defined in config file, config file
> +# is sourced on every test and this function overrides the vars
> +# every time.
> +# When SCRATCH/TEST_* vars are defined in evironment and not
> +# in config file, this function is called after vars have already
> +# been overriden in the previous test.
> +# In that case, TEST_DEV is a directory and not a blockdev/chardev and
> +# the function will return without overriding the SCRATCH/TEST_* vars.
> +_overlay_config_override()
> +{
> +	# There are 2 options for configuring overlayfs tests:
> +	#
> +	# 1. (legacy) SCRATCH/TEST_DEV point to existing directories
> +	#    on an already mounted fs.  In this case, the new
> +	#    OVL_BASE_SCRATCH/TEST_* vars are set to use the legacy
> +	#    vars values (even though they may not be mount points).
> +	#
> +	[ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
> +	[ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
> +
> +	# Config file may specify base fs type, but we obay -overlay flag
> +	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> +	export FSTYP=overlay
> +
> +	# 2. SCRATCH/TEST_DEV point to the base fs partitions.  In this case,
> +	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
> +	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
> +	#    overlayfs base and mount dirs inside base fs mount.
> +	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
Nit: 80 chars limit exceeded
> +
> +	# Store original base fs vars
> +	export OVL_BASE_TEST_DEV="$TEST_DEV"
> +	export OVL_BASE_TEST_DIR="$TEST_DIR"
> +	# If config does not set MOUNT_OPTIONS, its value may be
> +	# leftover from previous _overlay_config_override, so
> +	# don't use that value for base fs mount
> +	[ "$MOUNT_OPTIONS" != "$OVERLAY_MOUNT_OPTIONS" ] || unset MOUNT_OPTIONS
> +	export OVL_BASE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
> +
> +	# Set TEST vars to overlay base and mount dirs inside base fs
> +	export TEST_DEV="$OVL_BASE_TEST_DIR"
> +	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
> +	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
> +
> +
> 	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
Nit: 80 chars limit exceeded
> +
> +	# Store original base fs vars
> +	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> +	export OVL_BASE_SCRATCH_MNT="$SCRATCH_MNT"
> +
> +	# Set SCRATCH vars to overlay base and mount dirs inside base fs
> +	export SCRATCH_DEV="$OVL_BASE_SCRATCH_MNT"
> +	export SCRATCH_MNT="$OVL_BASE_SCRATCH_MNT/$OVL_MNT"
> +
> +	# Set fsck options, use default if user not set directly.
> +	export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
> +	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> +	export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
> +}
> +
> +_overlay_config_restore()
> +{
> +	export OVERLAY=true
> +	[ -z "$OVL_BASE_FSTYP" ] || export FSTYP=$OVL_BASE_FSTYP
> +	[ -z "$OVL_BASE_TEST_DEV" ] || export TEST_DEV=$OVL_BASE_TEST_DEV
> +	[ -z "$OVL_BASE_TEST_DIR" ] || export TEST_DIR=$OVL_BASE_TEST_DIR
> +	[ -z "$OVL_BASE_SCRATCH_DEV" ] || export SCRATCH_DEV=$OVL_BASE_SCRATCH_DEV
> +	[ -z "$OVL_BASE_SCRATCH_MNT" ] || export SCRATCH_MNT=$OVL_BASE_SCRATCH_MNT
> +	[ -z "$OVL_BASE_MOUNT_OPTIONS" ] || export MOUNT_OPTIONS=$OVL_BASE_MOUNT_OPTIONS
> +}
> +
> +# Returns a list of sections in config file
> +# Each section starts with the section name in the format
> +# [section_name1]. Only alphanumeric characters and '_' is allowed
> +# in the section name otherwise the section will not be resognised.
> +# Section name must be contained between square brackets.
> +get_config_sections() {
> +	sed -n -e "s/^\[\([[:alnum:]_-]*\)\]/\1/p" < $1
> +}
> +
> +# Parse config section options. This function will parse all the configuration
> +# within a single section which name is passed as an argument. For section
> +# name format see comments in get_config_sections().
> +# Empty lines and everything after '#' will be ignored.
> +# Configuration options should be defined in the format
> +#
> +# CONFIG_OPTION=value
> +#
> +# This 'CONFIG_OPTION' variable and will be exported as an environment variable.
> +parse_config_section() {
> +	SECTION=$1
> +	if ! $OPTIONS_HAVE_SECTIONS; then
> +		return 0
> +	fi
> +	eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
> +		-e 's/#.*$//' \
> +		-e 's/[[:space:]]*$//' \
> +		-e 's/^[[:space:]]*//' \
> +		-e "s/^\([^=]*\)=\"\?'\?\([^\"']*\)\"\?'\?$/export \1=\"\2\"/" \
> +		< $HOST_OPTIONS \
> +		| sed -n -e "/^\[$SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
> +}
> +
> +get_next_config() {
> +	if [ ! -z "$CONFIG_INCLUDED" ] && ! $OPTIONS_HAVE_SECTIONS; then
> +		return 0
> +	fi
> +
> +	# We might have overriden FSTYP and TEST/SCRATCH vars with overlay values
> +	# in the previous section, so restore them to original values stored in
> +	# OVL_BASE_*.
> +	# We need to do this *before* old FSTYP and MOUNT_OPTIONS are recorded
> +	# and *before* SCRATCH_DEV and MOUNT_OPTIONS are unset
> +	if [ "$FSTYP" == "overlay" ]; then
> +		_overlay_config_restore
> +	fi
> +
> +	local OLD_FSTYP=$FSTYP
> +	local OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
> +	local OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
> +	local OLD_MKFS_OPTIONS=$MKFS_OPTIONS
> +	local OLD_FSCK_OPTIONS=$FSCK_OPTIONS
> +	local OLD_USE_EXTERNAL=$USE_EXTERNAL
> +
> +	unset MOUNT_OPTIONS
> +	unset TEST_FS_MOUNT_OPTS
> +	unset MKFS_OPTIONS
> +	unset FSCK_OPTIONS
> +	unset USE_EXTERNAL
> +
> +	# We might have deduced SCRATCH_DEV from the SCRATCH_DEV_POOL in the previous
> +	# run, so we have to unset it now.
> +	if [ "$SCRATCH_DEV_NOT_SET" == "true" ]; then
> +		unset SCRATCH_DEV
> +	fi
> +
> +	parse_config_section $1
> +	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
> +		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
> +		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
> +		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
> +		[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> +
> +		# clear the external devices if we are not using them
> +		if [ -z "$USE_EXTERNAL" ]; then
> +			unset TEST_RTDEV
> +			unset TEST_LOGDEV
> +			unset SCRATCH_RTDEV
> +			unset SCRATCH_LOGDEV
> +		fi
> +	else
> +		[ -z "$MOUNT_OPTIONS" ] && export MOUNT_OPTIONS=$OLD_MOUNT_OPTIONS
> +		[ -z "$TEST_FS_MOUNT_OPTS" ] && export TEST_FS_MOUNT_OPTS=$OLD_TEST_FS_MOUNT_OPTS
> +		[ -z "$MKFS_OPTIONS" ] && export MKFS_OPTIONS=$OLD_MKFS_OPTIONS
> +		[ -z "$FSCK_OPTIONS" ] && export FSCK_OPTIONS=$OLD_FSCK_OPTIONS
> +		[ -z "$USE_EXTERNAL" ] && export USE_EXTERNAL=$OLD_USE_EXTERNAL
> +	fi
> +
> +	# set default RESULT_BASE
> +	if [ -z "$RESULT_BASE" ]; then
> +		export RESULT_BASE="$here/results/"
> +	fi
> +
> +	if [ "$FSTYP" == "tmpfs" ]; then
> +		if [ -z "$TEST_DEV" ]; then
> +			export TEST_DEV=tmpfs_test
> +		fi
> +		if [ -z "$SCRATCH_DEV" ]; then
> +			export TEST_DEV=tmpfs_scratch
> +		fi
> +	fi
> +
> +	#  Mandatory Config values.
> +	MC=""
> +	[ -z "$EMAIL" ]          && MC="$MC EMAIL"
> +	[ -z "$TEST_DIR" ]       && MC="$MC TEST_DIR"
> +	[ -z "$TEST_DEV" ]       && MC="$MC TEST_DEV"
> +
> +	if [ -n "$MC" ]; then
> +		echo "Warning: need to define parameters for host $HOST"
> +		echo "       or set variables:"
> +		echo "       $MC"
> +		_exit 1
> +	fi
> +
> +	_check_device TEST_DEV required $TEST_DEV
> +	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
> +
> +	# a btrfs tester will set only SCRATCH_DEV_POOL, we will put first of its dev
> +	# to SCRATCH_DEV and rest to SCRATCH_DEV_POOL to maintain the backward compatibility
> +	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
> +		if [ ! -z "$SCRATCH_DEV" ]; then
> +			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
> +			_exit 1
> +		fi
> +		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> +		export SCRATCH_DEV
> +		export SCRATCH_DEV_NOT_SET=true
> +	fi
> +
> +	_check_device SCRATCH_DEV optional $SCRATCH_DEV
> +	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
> +
> +	if [ -n "$USE_EXTERNAL" ]; then
> +		_check_device TEST_RTDEV optional $TEST_RTDEV
> +		_check_device TEST_LOGDEV optional $TEST_LOGDEV
> +		_check_device SCRATCH_RTDEV optional $SCRATCH_RTDEV
> +		_check_device SCRATCH_LOGDEV optional $SCRATCH_LOGDEV
> +	fi
> +
> +	# Override FSTYP from config when running ./check -overlay
> +	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs.
> +	# We need to do this *after* default mount options are set by base FSTYP
> +	# and *after* SCRATCH_DEV is deduced from SCRATCH_DEV_POOL
> +	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
> +		_overlay_config_override
> +	fi
> +}
> +
> +known_hosts()
> +{
> +	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
> +
> +	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
> +	[ -f $HOST_CONFIG_DIR/$HOST ]        && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST
> +	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
Nit: All 3 statements above exceed 80 char limit
--NR
> +}
> +
> +_config_section_setup()
> +{
> +	if [ ! -f "$HOST_OPTIONS" ]; then
> +		known_hosts
> +	fi
> +
> +	export HOST_OPTIONS_SECTIONS="-no-sections-"
> +	export OPTIONS_HAVE_SECTIONS=false
> +	if [ -f "$HOST_OPTIONS" ]; then
> +		export HOST_OPTIONS_SECTIONS=`get_config_sections $HOST_OPTIONS`
> +		if [ -z "$HOST_OPTIONS_SECTIONS" ]; then
> +			. $HOST_OPTIONS
> +			export HOST_OPTIONS_SECTIONS="-no-sections-"
> +		else
> +			export OPTIONS_HAVE_SECTIONS=true
> +		fi
> +	fi
> +
> +	if [ -z "$CONFIG_INCLUDED" ]; then
> +		get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
> +		export CONFIG_INCLUDED=true
> +
> +		# Autodetect fs type based on what's on $TEST_DEV unless it's
> +		# been set externally
> +		if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
> +			FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
> +		fi
> +		FSTYP=${FSTYP:=xfs}
> +		export FSTYP
> +		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
> +		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
> +		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
> +		[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> +	else
> +		# We get here for the non multi section case, on every test that
> +		# sources common/rc after re-sourcing the HOST_OPTIONS config
> +		# file.  Because of this re-sourcing, we need to re-canonicalize
> +		# the configured mount points and re-override TEST/SCRATCH_DEV
> +		# overlay vars.
> +
> +		# canonicalize the mount points
> +		# this follows symlinks and removes all trailing "/"s
> +		export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
> +		export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
> +
> +		# Override FSTYP from config when running ./check -overlay and
> +		# maybe override base fs TEST/SCRATCH_DEV with overlay base dirs
> +		if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
> +			_overlay_config_override
> +		fi
> +	fi
> +}

