Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526F41DDE3
	for <fstests@vger.kernel.org>; Fri, 14 Aug 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695935; cv=none; b=AY7k3UshonlLw9nn98t5UjAAsxD/pYph3JULH0B7AwlJYevqFdI24aXXcm4oAiAlz8DRNhgCPBCwLmmVWhtXD+Gadg1KlRAMPvuSfZ5nF7Vob4f2AMJ8BGOVLNnoCdBJ2DasJUSMxhFb0rQRGfm9YVDiyU2uzFlLgWNlzQpb3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695935; c=relaxed/simple;
	bh=mKCeJBkAeVoYTn6oppoGiZG2k0z8J3ftVeFmQBJKe8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W58ZtgvscFOzYZJ98ZA1kritKfOsSIpQsIxe0nVs/t/bvM84nZPQ/OuT1gDxq98g2p2HbRwzJNBXVD3uUCRgovlX5dOJfzKlE18QLQi2pRNOJHkMHz4yvqNamOI2hj0UuaeQUpLj3ODmHWjZJB3kDEhr9KmhUL18vttS3RfSx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KmjudyM+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KmjudyM+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E81V1A585863;
	Fri, 14 Aug 2026 08:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mDIPifn87hLyh/aMnX8R4BVicA6qWU
	g5Qksts7Hjdd4=; b=KmjudyM+Vs96Y8DLpAcLaDSrz9aSCOYrPuaWJEb5Di/ygH
	7g3I7j2c2/fBtVJP2mxyz7WP7+nT/A9tmarAEl/5pbkxTdZaLpt/q5y1oydnenE8
	j8opZRQv/KQj1rrkz6yuZOYXqNUuY8ziGGzGLgwzCoe+u352U7Cfxo4iRshAKg5o
	QeiLENxvM/HfMamlNt3jsEijMkvPAA6GH1UtF97AfRyq0IXj7emzD3Cs4V6U+tBY
	b4reWpm1/eKDpkopju2NPynoVDY3mJVo78FapSd3L/v+94tmZRlLmTKTn7VqDn1w
	Jt2CEbFdzTbBh42InEXIyk35rJVtqjxd4aSKi+Cw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma3yy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:25:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E8BPxI022156;
	Fri, 14 Aug 2026 08:25:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hefvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:25:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E8PMDJ51839384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 08:25:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4321B20043;
	Fri, 14 Aug 2026 08:25:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA41F20040;
	Fri, 14 Aug 2026 08:25:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 08:25:20 +0000 (GMT)
Date: Fri, 14 Aug 2026 13:55:17 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH 2/4] check: update usage and README to reflect new
 argument parsing
Message-ID: <an7Q7dlomhqjpddc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260512132539.931482-1-zlang@kernel.org>
 <20260512132539.931482-3-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132539.931482-3-zlang@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfXwNNAQmZ14j3C
 nN2rANxemhG+VAEH5IvoBnwLdsNcjohr6a+8eS0z2R99JhVGxsTqysa95jz4IA7k2WVH6Gibfr3
 fwMrvS0vdx6e7ECdm0GDMHav2ghhpJgulHVCUXNl3KysJB/+dbDfkRPvkdtzemvaUCNlAYf6o5N
 nz3lV+049KfmcFJxqLHU+SdA/z8scu21trJShRMyTZGlICNcNCRDKXbmSrrYGiN5MeoxgvYp3rY
 k08mctSWEyFscpk9/F9Gh3K9r980Zt42cPT2bYbKweZ7ZMKJ9TITWvwWl63fomsKxrtzZ2SBMqX
 QxYWn6uo/ny5ZgCZWE7FdZDLvW6N5TZw6OZp7mTK4rdonxVWWsF3TEeDbwlra0sdmseiBbu7vWT
 ikV2oomSIrit/OlZeZLu8JQDhql8i/fFJtfeL1mP3SWqAKWHVzLWKq5DN2NAk6U6SpujYou2LHe
 dxzXwOj0m+VSpIYeywQ==
X-Proofpoint-ORIG-GUID: yLb3KTv0UveGDyUUBo7A2UILkfl2N4HZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX44Xplu3pNTa/
 EH+8TrYvGbtzfGV4IT1kegCO7+NjPYPZnXsdV28dwVTQFxHqfYCyGIcVxy2JgPCJP99FSh8IF+F
 2HhIpapQpXxwrgLMK8+EAQaP/8TZWYA=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ed0f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=wI2cyiFT6qMBxWeAM4AA:9 a=Ts8lMU5kWArMM4NV:21
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yLb3KTv0UveGDyUUBo7A2UILkfl2N4HZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140061

On Tue, May 12, 2026 at 09:25:37PM +0800, Zorro Lang wrote:
> Update usage() function, README.* files and some comments to match
> the new argument parsing method.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  README         | 10 +++---
>  README.overlay | 18 +++++------
>  check          | 85 ++++++++++++++++++++++++++------------------------
>  common/config  |  8 ++---
>  common/rc      |  2 +-
>  5 files changed, 63 insertions(+), 60 deletions(-)
> 
> diff --git a/README b/README
> index e0cee43a..8644f163 100644
> --- a/README
> +++ b/README
> @@ -386,7 +386,7 @@ Misc:
>   - Set DIFF_LENGTH to "number of diff lines to print from a failed test",
>     by default 10, set to 0 to print the full diff
>   - set IDMAPPED_MOUNTS=true to run all tests on top of idmapped mounts. While
> -   this option is supported for all filesystems currently only -overlay is
> +   this option is supported for all filesystems currently only `--fs overlay` is
>     expected to run without issues. For other filesystems additional patches
>     and fixes to the test suite might be needed.
>   - Set REPORT_VARS_FILE to a file containing colon-separated name-value pairs
> @@ -417,10 +417,10 @@ Running tests:
>      - To randomize test order: ./check -r [test(s)]
>      - You can explicitly specify NFS/AFS/CIFS/OVERLAY, otherwise
>        the filesystem type will be autodetected from $TEST_DEV:
> -        - for running nfs tests: ./check -nfs [test(s)]
> -        - for running afs tests: ./check -afs [test(s)]
> -        - for running cifs/smb3 tests: ./check -cifs [test(s)]
> -        - for overlay tests: ./check -overlay [test(s)]
> +        - for running nfs tests: ./check --fs nfs [test(s)]
> +        - for running afs tests: ./check --fs afs [test(s)]
> +        - for running cifs/smb3 tests: ./check --fs cifs [test(s)]
> +        - for overlay tests: ./check --fs overlay [test(s)]
>            The TEST and SCRATCH partitions should be pre-formatted
>            with another base fs, where the overlay dirs will be created
>  
> diff --git a/README.overlay b/README.overlay
> index 3093bf8c..52bcd332 100644
> --- a/README.overlay
> +++ b/README.overlay
> @@ -1,5 +1,5 @@
>  To run xfstest on overlayfs, configure the variables of TEST and SCRATCH
> -partitions to be used as the "base fs" and run './check -overlay'.
> +partitions to be used as the "base fs" and run './check --fs overlay'.
>  
>  For example, the following config file can be used to run tests on
>  xfs test/scratch partitions:
> @@ -10,24 +10,24 @@ xfs test/scratch partitions:
>   SCRATCH_MNT=/mnt/scratch
>   FSTYP=xfs
>  
> -Using the same config file, but executing './check -overlay' will
> +Using the same config file, but executing './check --fs overlay' will
>  use the same partitions as base fs for overlayfs directories
>  and set TEST_DIR/SCRATCH_MNT values to overlay mount points, i.e.:
>  /mnt/test/ovl-mnt and /mnt/scratch/ovl-mnt, for the context of
>  individual tests.
>  
> -'./check -overlay' does not support mkfs and fsck on the base fs, so
> -the base fs should be pre-formatted before starting the -overlay run.
> +'./check --fs overlay' does not support mkfs and fsck on the base fs, so
> +the base fs should be pre-formatted before starting the --fs overlay run.
>  An easy way to accomplish this is by running './check <some test>' once,
> -before running './check -overlay'.
> +before running './check --fs overlay'.
>  
> -'./check -overlay' support check overlay test and scratch dirs,
> +'./check --fs overlay' support check overlay test and scratch dirs,
>  OVERLAY_FSCK_OPTIONS should be set instead of FSCK_OPTIONS if fsck
>  options need to given directly.
>  
>  Because of the lack of mkfs support, multi-section config files are only
> -partly supported with './check -overlay'. Only multi-section files that
> -do not change FSTYP and MKFS_OPTIONS can be safely used with -overlay.
> +partly supported with './check --fs overlay'. Only multi-section files that
> +do not change FSTYP and MKFS_OPTIONS can be safely used with --fs overlay.
>  
>  For example, the following multi-section config file can be used to
>  run overlay tests on the same base fs, but with different mount options, and on
> @@ -66,7 +66,7 @@ To enable running unionmount testsuite, clone the git repository from:
>  under the xfstests src directory, or set the environment variable
>  UNIONMOUNT_TESTSUITE to the local path where the repository was cloned.
>  
> -Run './check -overlay -g overlay/union' to execute all the unionmount testsuite
> +Run './check --fs overlay -g overlay/union' to execute all the unionmount testsuite
>  test cases.
>  
>  
> diff --git a/check b/check
> index 11bdf81b..5fe35e8e 100755
> --- a/check
> +++ b/check
> @@ -56,43 +56,47 @@ export SRC_DIR="tests"
>  
>  usage()
>  {
> -    echo "Usage: $0 [options] [testlist]"'
> -
> -check options
> -    -nfs		test NFS
> -    -afs		test AFS
> -    -glusterfs		test GlusterFS
> -    -cifs		test CIFS
> -    -9p			test 9p
> -    -fuse		test fuse
> -    -virtiofs		test virtiofs
> -    -overlay		test overlay
> -    -pvfs2		test PVFS2
> -    -tmpfs		test TMPFS
> -    -ubifs		test ubifs
> -    -l			line mode diff
> -    -udiff		show unified diff (default)
> -    -n			show me, do not run tests
> -    -T			output timestamps
> -    -r			randomize test order
> -    --exact-order	run tests in the exact order specified
> -    -i <n>		iterate the test list <n> times
> -    -I <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
> -    -d			dump test output to stdout
> -    -b			brief test summary
> -    -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
> -    --large-fs		optimise scratch device for large filesystems
> -    -s section		run only specified section from config file
> -    -S section		exclude the specified section from the config file
> -    -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> -
> -testlist options
> -    -g group[,group...]	include tests from these groups
> -    -x group[,group...]	exclude tests from these groups
> -    -X exclude_file	exclude individual tests
> -    -e testlist         exclude a specific list of tests
> -    -E external_file	exclude individual tests
> -    [testlist]		include tests matching names in testlist
> +	echo "Usage: $0 [options] [testlist]"'
> +
> +General options:
> +    -b                      brief test summary
> +    -d                      dump test output to stdout
> +    -h, --help              show this help message
> +    -i <n>                  iterate the test list <n> times
> +    -I <n>                  iterate the test list <n> times, but stops
> +                              iterating further in case of any test failure
> +    -l                      line mode diff
> +    -L <n>                  loop tests <n> times following a failure, measuring
> +                              aggregate pass/fail metrics
> +    -n                      show me, do not run tests
> +    -r                      randomize test order
> +    -s section              run only specified section from config file
> +    -S section              exclude the specified section from the config file
> +    -T                      output timestamps
> +    -R fmt[,fmt]            generate report in formats specified. Supported
> +                              formats: xunit, xunit-quiet
> +    --exact-order           run tests in the exact order specified
> +    --extra-space <size>    require minimum free space on scratch device
> +    --fs <type>             test the given FSTYP; valid types include:
> +                              nfs, afs, glusterfs, cifs, 9p, fuse, virtiofs,
> +                              overlay, pvfs2, tmpfs, ubifs
> +    --large-fs              optimise scratch device for large filesystems
> +    --udiff                 show unified diff (default)
> +
> +Test selection options:
> +    -e testlist             exclude a specific list of tests
> +    -E external_file        exclude tests listed in the given file
> +    -g group[,group...]     include tests from these groups
> +    -x group[,group...]     exclude tests from these groups
> +    -X exclude_file         exclude individual tests
> +    [testlist]              include tests matching names in testlist
> +
> +Backward-compatible options:
> +    For compatibility, old options are still accepted (but deprecated):
> +    --fs <nfs|afs|glusterfs|...> is equivalent to:
> +        -nfs, -afs, -glusterfs, -cifs, -9p, -fuse, -virtiofs, -overlay,
> +        -pvfs2, -tmpfs, -ubifs
> +    -udiff is equivalent to --udiff.
>  
>  testlist argument is a list of tests in the form of <test dir>/<test name>.
>  
> @@ -109,7 +113,7 @@ If you want to run all the tests in the test suite, use "-g all" to specify all
>  groups.
>  
>  exclude_file argument refers to a name of a file inside each test directory.
> -for every test dir where this file is found, the listed test names are
> +For every test dir where this file is found, the listed test names are
>  excluded from the list of tests to run from that test dir.
>  
>  external_file argument is a path to a single file containing a list of tests
> @@ -117,15 +121,14 @@ to exclude in the form of <test dir>/<test name>.
>  
>  examples:
>   check xfs/001
> - check -g quick
> + check --fs overlay -g quick
>   check -g xfs/quick
>   check -x stress xfs/*
>   check -X .exclude -g auto
>   check -E ~/.xfstests.exclude
>  '
> -	    _fatal
> +	_fatal
>  }
> -
>  get_sub_group_list()
>  {
>  	local d=$1
> diff --git a/common/config b/common/config
> index d5299d5b..69e5d833 100644
> --- a/common/config
> +++ b/common/config
> @@ -692,7 +692,7 @@ _canonicalize_devices()
>  	fi
>  }
>  
> -# On check -overlay, for the non multi section config case, this
> +# On check --fs overlay, for the non multi section config case, this
>  # function is called on every test, before init_rc().
>  # When SCRATCH/TEST_* vars are defined in config file, config file
>  # is sourced on every test and this function overrides the vars
> @@ -714,7 +714,7 @@ _overlay_config_override()
>  	[ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
>  	[ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
>  
> -	# Config file may specify base fs type, but we obay -overlay flag
> +	# Config file may specify base fs type, but we obay --fs overlay flag
>  	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
>  	export FSTYP=overlay
>  
> @@ -895,7 +895,7 @@ get_next_config() {
>  		_check_device SCRATCH_LOGDEV optional $SCRATCH_LOGDEV
>  	fi
>  
> -	# Override FSTYP from config when running ./check -overlay
> +	# Override FSTYP from config when running ./check --fs overlay
>  	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs.
>  	# We need to do this *after* default mount options are set by base FSTYP
>  	# and *after* SCRATCH_DEV is deduced from SCRATCH_DEV_POOL
> @@ -930,7 +930,7 @@ else
>  	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
>  	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
>  
> -	# Override FSTYP from config when running ./check -overlay
> +	# Override FSTYP from config when running ./check --fs overlay
>  	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs
>  	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
>  		_overlay_config_override
> diff --git a/common/rc b/common/rc
> index 26db5bbd..39d24ef0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4340,7 +4340,7 @@ _has_metadata_journaling()
>  		;;
>  	overlay)
>  		# metadata journaling check is based on base filesystem configurations
> -		# and  because -overlay option saves those configurations to OVL_BASE_*,
> +		# and  because --fs overlay option saves those configurations to OVL_BASE_*,
>  		# adding restore/override the configurations before/after the check.
>  		if [ ! -z $OVL_BASE_FSTYP -a $OVL_BASE_FSTYP != "overlay" ]; then
>  			local ret
> -- 
> 2.54.0
> 
