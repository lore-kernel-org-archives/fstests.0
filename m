Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C23C1983
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740158; cv=none; b=LABwxJQ4Dc51ZXDweu4wbcfnsGRTRtiO8ZG4EuoOzuuZgzEC5lOccFOdW8ZJMYUBolMJkiG1XyEzp+dJiKSAkOehsm0nVVES7xzg93MSxuYCZJzehKKWmz32k1EXl8mty5JHDxoI+5b3Kx0+b95A5uqAk34DJTWSngMRxanq6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740158; c=relaxed/simple;
	bh=5HcNik3m6BS5mY1lsW9wJoFA7sYYux/uUNxHLZOedP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYJPT++HkVND5L8+ajYZxWETOzPRoVJe02ymn+IIyJbLmTxQqSVS0aqK3nSf0Wa9mm5xLy3xD2Um+EnDjlYzZ6jyuY2ePukgg6lrT1SBcby0UkZl2eWLrMzXJjULk3tywjqkAyVs8mnUNGRHEwby8IzHGIkfLKD3wDobOjzAey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARbjfFrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARbjfFrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739A51F00A3A;
	Wed, 26 Aug 2026 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740157;
	bh=FT3QimyDhsN+TET5yjA5yl+OVoDlS18g1+Ro/1uN7rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARbjfFrNXqzqtrJVGtrrJ0FHFeMXgK8Rk9kbD8ZAojkxPn6c7z30cTH1lvuipoFyK
	 xRHRmZcH9ZL/MymAmYqOVzNkjhHhGqZ36dUclqLAfADH6C5DdF6MawMktSvB+I9kjA
	 G8vNQx18T4ST0bsl/OklFTWCvuCSdCzbpNQwYlEh+bzrO6BzMdTFPYD9jPOGLf7yK/
	 BmiP0OblM0APljuwgwV1ZuCSV3L8vwtUdIrix+18MuSPSJX7h4R/mIzt6k3d2ZXlvN
	 kNyyY+MJoU0JU90axrbmFy+kij5Zup12RqgPprHLrLjO1XBaRrxAN+I9c8JBQ+JFzy
	 0hEEYwjTYOo+A==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 3/4] check: consolidate argument handling into function
Date: Wed, 26 Aug 2026 18:28:56 +0800
Message-ID: <20260826102857.3224318-4-zlang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826102857.3224318-1-zlang@kernel.org>
References: <20260826102857.3224318-1-zlang@kernel.org>
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
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 check | 334 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 173 insertions(+), 161 deletions(-)

diff --git a/check b/check
index 8ab3c7ee..df209f1f 100755
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
@@ -301,137 +301,183 @@ compat_old_option()
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
+	local parsed_opts
+	parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
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
@@ -472,40 +518,6 @@ if [ -n "$subdir_xfile" ]; then
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
2.55.0

