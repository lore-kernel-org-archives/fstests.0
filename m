Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A2344D9D
	for <fstests@vger.kernel.org>; Tue, 12 May 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592366; cv=none; b=qKWmNsynEY4eOQ2W7Z0xV0gabTXuVyxA/JZeadO6GQ5zgIztjtEKcWPi7H2m0TLvujO2JfVjqQw+pfemyjBaiApKH5Q8G7FKjCrlMdgoIKhtueSoo3L2GT3DX34QVQ7hl2q1PhuR4l8uvaa+jTOxEAZPDIANIk8DhqhCVRsgnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592366; c=relaxed/simple;
	bh=2l3SpkQ8AJz0jHFoMnBUyKc7Lmz/p+IjXTg7RKxfaD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czQ+izx148F6O3h0fQHBsdytRdTHri5C5oP9sqmc4uW8L2tbzlTKaUTbJWrFRJtrgx8OydxaTfXNx8Jye8xkg2MzxBBH1WuKDU5f9bZO6LKr3xmnTZufn0cSNzk7OX1lh2q11XE0EuTYL9yKFDMwIiHUaLeBtcgkmUQXYm/LrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsZXcV6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsZXcV6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD47C2BCFC;
	Tue, 12 May 2026 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592366;
	bh=2l3SpkQ8AJz0jHFoMnBUyKc7Lmz/p+IjXTg7RKxfaD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsZXcV6fNRTQgyxzoQvysdbz7eC5Iy+d8AzjnV81vD9saENP4f9D5CIVkO+Jt+79a
	 faxv2mnubZtDbSMoiy+Et8T3sfBoNh/A2aIVZxzOg9UQ7a6O12VRldDOjoG9bSbQSS
	 CILHniTjtklW2iSRPEVNGHnNjoIXbIO/Ls7Y/TClp2JROWKMuD+EZ/7z6savxmIO0T
	 CCw+1OnPdn+xQzX1fPHDcjPPKQU/9DQMIQXyrJs0IAk+fnOfcUXyIiLk+IIeI88eNH
	 elkb3YEfYmRNEdowcHV7N74spQnlnTSWt/eqGgEtk5pmbiqGxcSLfQuX8zqNDnES5u
	 EVK+TNfxki9IQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [RFC PATCH 3/4] check: consolidate argument handling into function
Date: Tue, 12 May 2026 21:25:38 +0800
Message-ID: <20260512132539.931482-4-zlang@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512132539.931482-1-zlang@kernel.org>
References: <20260512132539.931482-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate the check script's options and any trailing arguments
(e.g. test case list) into the parse_check_args() function (and
sub-function of it), to clean up the scattered logic.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 check | 333 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 172 insertions(+), 161 deletions(-)

diff --git a/check b/check
index 5fe35e8e..d19498e6 100755
--- a/check
+++ b/check
@@ -15,7 +15,7 @@ notrun=()
 interrupt=true
 diff="diff -u"
 showme=false
-have_test_arg=false
+remain_args=()
 randomize=false
 exact_order=false
 export here=`pwd`
@@ -228,7 +228,7 @@ _prepare_test_list()
 	# Specified groups to include
 	# Note that the CLI processing adds a leading space to the first group
 	# parameter, so we have to catch that here checking for "all"
-	if ! $have_test_arg && [ "$GROUP_LIST" == " all" ]; then
+	if [ ${#remain_args[@]} -eq 0 ] && [ "$GROUP_LIST" == " all" ]; then
 		# no test numbers, do everything
 		get_all_tests
 	else
@@ -300,137 +300,182 @@ compat_old_option()
 	done
 }
 
-short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
-long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
-
-compat_old_option "$@"
+# Process tests from command line now.
+process_remain_tests()
+{
+	local list test_dir test_name group_file
 
-# Note: The '+' prefix in getopt's option string preserves the existing
-# behavior that option parsing stops at the first non-option test argument.
-parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
-test $? -ne 0 && usage
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		-*)
+			_fatal "Arguments before tests, please!"
+			;;
+		*)
+			# Expand test pattern (e.g. xfs/???, *fs/001)
+			list=$(cd $SRC_DIR; echo $1)
+			for t in $list; do
+				t=${t#$SRC_DIR/}
+				test_dir=${t%%/*}
+				test_name=${t##*/}
+				group_file=$SRC_DIR/$test_dir/group.list
 
-eval set -- "$parsed_opts"
+				if grep -Eq "^$test_name" $group_file; then
+					# in group file ... OK
+					echo $SRC_DIR/$test_dir/$test_name \
+						>>$tmp.arglist
+				else
+					# oops
+					echo "$t - unknown test, ignored"
+				fi
+			done
+			;;
+		esac
 
-while [ $# -gt 0 ]; do
-	case "$1" in
-	--fs)
-		if [ "$2" == "overlay" ];then
-			[ "$FSTYP" == overlay ] || \
-				export OVL_BASE_FSTYP="$FSTYP"
-			FSTYP=overlay
-			export OVERLAY=true
-		else
-			FSTYP="$2"
-		fi
-		shift
-		;;
-	--udiff)
-		diff="$diff -u"
-		;;
-	-g)
-		GROUP_LIST="$GROUP_LIST ${2//,/ }"
-		shift
-		;;
-	-x)
-		XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
-		shift
-		;;
-	-X)
-		subdir_xfile="$2"
 		shift
-		;;
-	-e)
-		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
-			<(echo "$2" | tr ', ' '\n\n')
-		shift
-		;;
-	-E)
-		if [ -f "$2" ]; then
-			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
-				<(sed "s/#.*$//" "$2")
-		fi
-		shift
-		;;
-	-s)
-		RUN_SECTION="$RUN_SECTION $2"
-		shift
-		;;
-	-S)
-		EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
-		shift
-		;;
-	-l)
-		diff="diff"
-		;;
-	-n)
-		showme=true
-		;;
-	-r)
-		if $exact_order; then
-			_fatal "Cannot specify -r and --exact-order."
-		fi
-		randomize=true
-		;;
-	--exact-order)
-		if $randomize; then
-			_fatal "Cannot specify --exact-order and -r."
-		fi
-		exact_order=true
-		;;
-	-i)
-		iterations=$2
-		shift
-		;;
-	-I)
-		iterations=$2
-		istop=true
-		shift
-		;;
-	-T)
-		timestamp=true
-		;;
-	-d)
-		DUMP_OUTPUT=true
-		;;
-	-b)
-		brief_test_summary=true
-		;;
-	-R)
-		REPORT_LIST="$REPORT_LIST ${2//,/ }"
-		do_report=true
-		shift
-		;;
-	--large-fs)
-		export LARGE_SCRATCH_DEV=yes
-		;;
-	--extra-space)
-		export SCRATCH_DEV_EMPTY_SPACE="$2"
-		shift
-		;;
-	-L)
-		[[ $2 =~ ^[0-9]+$ ]] || usage
-		loop_on_fail=$2
-		shift
-		;;
-	-h|--help)
-		usage
-		;;
-	--)
+	done
+}
+
+parse_check_args()
+{
+	local short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
+	local long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
+
+	compat_old_option "$@"
+
+	# Note: The '+' prefix in getopt's option string preserves the existing
+	# behavior that option parsing stops at the first non-option test argument.
+	local parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
+	test $? -ne 0 && usage
+
+	eval set -- "$parsed_opts"
+
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		--fs)
+			if [ "$2" == "overlay" ];then
+				[ "$FSTYP" == overlay ] || \
+					export OVL_BASE_FSTYP="$FSTYP"
+				FSTYP=overlay
+				export OVERLAY=true
+			else
+				FSTYP="$2"
+			fi
+			shift
+			;;
+		--udiff)
+			diff="$diff -u"
+			;;
+		-g)
+			GROUP_LIST="$GROUP_LIST ${2//,/ }"
+			shift
+			;;
+		-x)
+			XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
+			shift
+			;;
+		-X)
+			subdir_xfile="$2"
+			shift
+			;;
+		-e)
+			readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
+				<(echo "$2" | tr ', ' '\n\n')
+			shift
+			;;
+		-E)
+			if [ -f "$2" ]; then
+				readarray -t -O ${#exclude_tests[@]} exclude_tests < \
+					<(sed "s/#.*$//" "$2")
+			fi
+			shift
+			;;
+		-s)
+			RUN_SECTION="$RUN_SECTION $2"
+			shift
+			;;
+		-S)
+			EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
+			shift
+			;;
+		-l)
+			diff="diff"
+			;;
+		-n)
+			showme=true
+			;;
+		-r)
+			if $exact_order; then
+				_fatal "Cannot specify -r and --exact-order."
+			fi
+			randomize=true
+			;;
+		--exact-order)
+			if $randomize; then
+				_fatal "Cannot specify --exact-order and -r."
+			fi
+			exact_order=true
+			;;
+		-i)
+			iterations=$2
+			shift
+			;;
+		-I)
+			iterations=$2
+			istop=true
+			shift
+			;;
+		-T)
+			timestamp=true
+			;;
+		-d)
+			DUMP_OUTPUT=true
+			;;
+		-b)
+			brief_test_summary=true
+			;;
+		-R)
+			REPORT_LIST="$REPORT_LIST ${2//,/ }"
+			do_report=true
+			shift
+			;;
+		--large-fs)
+			export LARGE_SCRATCH_DEV=yes
+			;;
+		--extra-space)
+			export SCRATCH_DEV_EMPTY_SPACE="$2"
+			shift
+			;;
+		-L)
+			[[ $2 =~ ^[0-9]+$ ]] || usage
+			loop_on_fail=$2
+			shift
+			;;
+		-h|--help)
+			usage
+			;;
+		--)
+			shift
+			break
+			;;
+		*)
+			usage
+			;;
+		esac
 		shift
-		break
-		;;
-	*)
-		usage
-		;;
-	esac
-	shift
-done
+	done
 
-# Remaining arguments
-if [ $# -gt 0 ]; then
-	have_test_arg=true
-fi
+	# Remaining arguments (tests list)
+	if [ $# -gt 0 ]; then
+		remain_args=("$@")
+		process_remain_tests "${remain_args[@]}"
+	elif [ -z "$GROUP_LIST" ]; then
+		# default group list is the auto group. If any other group or
+		# test is specified, we use that instead.
+		GROUP_LIST="auto"
+	fi
+}
+
+parse_check_args "$@"
 
 # we need common/rc, that also sources common/config. We need to source it
 # after processing args, overlay needs FSTYP set before sourcing common/config
@@ -471,40 +516,6 @@ if [ -n "$subdir_xfile" ]; then
 	done
 fi
 
-# Process tests from command line now.
-if $have_test_arg; then
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		-*)	_fatal "Arguments before tests, please!"
-			;;
-		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
-			list=$(cd $SRC_DIR; echo $1)
-			for t in $list; do
-				t=${t#$SRC_DIR/}
-				test_dir=${t%%/*}
-				test_name=${t##*/}
-				group_file=$SRC_DIR/$test_dir/group.list
-
-				if grep -Eq "^$test_name" $group_file; then
-					# in group file ... OK
-					echo $SRC_DIR/$test_dir/$test_name \
-						>>$tmp.arglist
-				else
-					# oops
-					echo "$t - unknown test, ignored"
-				fi
-			done
-			;;
-		esac
-
-		shift
-	done
-elif [ -z "$GROUP_LIST" ]; then
-	# default group list is the auto group. If any other group or test is
-	# specified, we use that instead.
-	GROUP_LIST="auto"
-fi
-
 if [ `id -u` -ne 0 ]
 then
     _fatal "check: QA must be run as root"
-- 
2.54.0

