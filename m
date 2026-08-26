Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4443BFE3E
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740154; cv=none; b=L4wD/aXnhU51xiMo+TR+/indEeAoJvFKtG+CoZUCORvUW2ye/AEQkoRCJB/p3oeuGbn2XNyA5QFndI943SXdwmyK8Kd+Pv7zuTvFo1QiV8QX/PmBgLmpEae/k1KH8TKPf6t3LlKT30KWM6EUTo2KGwpTtucIT/8VpOXPwY6Eb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740154; c=relaxed/simple;
	bh=to3fpUQb21l082lDRKAGiJvnBlI157AJDJXxH0dpidA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDZGr6eW90wYxQaKQ/DigzAXJbMPxsu2sH691NX5kLLQYw8Gm/fxX24MkoMlGevwi3FPwae+f3wCNgIaTd78LL0mnId6cTsuyIv9LrvvPz/Po1R+Ag7zoSgFluT3xJlkE3Tqkp6gne8WVPcTr3csbfMNVcEgpuZNUikNF3fZI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzHA7/Hj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzHA7/Hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98401F00A3A;
	Wed, 26 Aug 2026 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740152;
	bh=7hCpz/WJm1lcAtmgsDklw3mkEoMwamvlKkWnEXPCjIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzHA7/HjmhzWTvv3KAi5fT6yAoZYZnBPnQApzOavZCZbs4/SGvtNT3J8waXpMrbVZ
	 fZup4tjzS43AjqjjTgiH7LJ496hA6gUnhsbCXUALXYVJlRg6/+YO1hmd8za6zS3TqS
	 wObEH14jvFUDK39HdqYKggF705Sy06sd1W+L9PUADmg9F4Jld8Rp0e74+vsezvCZza
	 coLDJeiOXfSvIinR3U/ki7/cZj051saDqLdqptXdyTC8/ph6PoGnoVUKz49pU/c7Dt
	 GY04RAsYCZlAahMpQcABoOY+Q5tMZWDgDF0dcLofIr5CTXZrLSn3QNM9tSAOGW2D6j
	 wCsz0nMr9uJBQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 1/4] check: refactor argument parsing with getopt
Date: Wed, 26 Aug 2026 18:28:54 +0800
Message-ID: <20260826102857.3224318-2-zlang@kernel.org>
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

Replace the legacy, hand-written argument parsing loop with getopt.
Also compatible with old-style options (e.g. -nfs, -afs, -glusterfs,
-cifs, -9p, -fuse, -virtiofs, -pvfs2, -tmpfs, -ubifs, -overlay,
-udiff), pre-process them into long options before giving to getopt.

Signed-off-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 check | 180 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 127 insertions(+), 53 deletions(-)

diff --git a/check b/check
index ad685edc..548b01b5 100755
--- a/check
+++ b/check
@@ -272,48 +272,98 @@ _prepare_test_list()
 	rm -f $tmp.list
 }
 
-# Process command arguments first.
+# Backward compatible with the old options mode. Translate word-style options
+# that getopt would misinterpret into long options.
+compat_old_option()
+{
+	check_args=()
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		-nfs)		check_args+=("--fs" "nfs") ;;
+		-afs)		check_args+=("--fs" "afs") ;;
+		-glusterfs)	check_args+=("--fs" "glusterfs") ;;
+		-cifs)		check_args+=("--fs" "cifs") ;;
+		-9p)		check_args+=("--fs" "9p") ;;
+		-fuse)		check_args+=("--fs" "fuse") ;;
+		-virtiofs)	check_args+=("--fs" "virtiofs") ;;
+		-pvfs2)		check_args+=("--fs" "pvfs2") ;;
+		-tmpfs)		check_args+=("--fs" "tmpfs") ;;
+		-ubifs)		check_args+=("--fs" "ubifs") ;;
+		-overlay)	check_args+=("--fs" "overlay") ;;
+		-udiff)		check_args+=("--udiff") ;;
+		-\?)		check_args+=("--help") ;;
+		*)		check_args+=("$1") ;;
+		esac
+		shift
+	done
+}
+
+short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
+long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
+
+compat_old_option "$@"
+
+# Note: The '+' prefix in getopt's option string preserves the existing
+# behavior that option parsing stops at the first non-option test argument.
+parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
+test $? -ne 0 && usage
+
+eval set -- "$parsed_opts"
+
 while [ $# -gt 0 ]; do
 	case "$1" in
-	-\? | -h | --help) usage ;;
-
-	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
-		FSTYP="${1:1}"
+	--fs)
+		if [ "$2" == "overlay" ];then
+			[ "$FSTYP" == overlay ] || \
+				export OVL_BASE_FSTYP="$FSTYP"
+			FSTYP=overlay
+			export OVERLAY=true
+		else
+			FSTYP="$2"
+		fi
+		shift
 		;;
-	-overlay)
-		[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
-		FSTYP=overlay
-		export OVERLAY=true
+	--udiff)
+		diff="$diff -u"
 		;;
-
-	-g)	group=$2 ; shift ;
-		GROUP_LIST="$GROUP_LIST ${group//,/ }"
+	-g)
+		GROUP_LIST="$GROUP_LIST ${2//,/ }"
+		shift
 		;;
-
-	-x)	xgroup=$2 ; shift ;
-		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
+	-x)
+		XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
+		shift
 		;;
-
-	-X)	subdir_xfile=$2; shift ;
+	-X)
+		subdir_xfile="$2"
+		shift
 		;;
 	-e)
-		xfile=$2; shift ;
 		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
-			<(echo "$xfile" | tr ', ' '\n\n')
+			<(echo "$2" | tr ', ' '\n\n')
+		shift
 		;;
-
-	-E)	xfile=$2; shift ;
-		if [ -f $xfile ]; then
+	-E)
+		if [ -f "$2" ]; then
 			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
-				<(sed "s/#.*$//" $xfile)
+				<(sed "s/#.*$//" "$2")
 		fi
+		shift
+		;;
+	-s)
+		RUN_SECTION="$RUN_SECTION $2"
+		shift
+		;;
+	-S)
+		EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
+		shift
+		;;
+	-l)
+		diff="diff"
+		;;
+	-n)
+		showme=true
 		;;
-	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
-	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
-	-l)	diff="diff" ;;
-	-udiff)	diff="$diff -u" ;;
-
-	-n)	showme=true ;;
 	-r)
 		if $exact_order; then
 			_fatal "Cannot specify -r and --exact-order."
@@ -322,40 +372,64 @@ while [ $# -gt 0 ]; do
 		;;
 	--exact-order)
 		if $randomize; then
-			_fatal "Cannnot specify --exact-order and -r."
+			_fatal "Cannot specify --exact-order and -r."
 		fi
 		exact_order=true
 		;;
-	-i)	iterations=$2; shift ;;
-	-I) 	iterations=$2; istop=true; shift ;;
-	-T)	timestamp=true ;;
-	-d)	DUMP_OUTPUT=true ;;
-	-b)	brief_test_summary=true;;
-	-R)	report_fmt=$2 ; shift ;
-		REPORT_LIST="$REPORT_LIST ${report_fmt//,/ }"
+	-i)
+		iterations=$2
+		shift
+		;;
+	-I)
+		iterations=$2
+		istop=true
+		shift
+		;;
+	-T)
+		timestamp=true
+		;;
+	-d)
+		DUMP_OUTPUT=true
+		;;
+	-b)
+		brief_test_summary=true
+		;;
+	-R)
+		REPORT_LIST="$REPORT_LIST ${2//,/ }"
 		do_report=true
+		shift
 		;;
-	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
-	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
-	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
-		loop_on_fail=$2; shift
+	--large-fs)
+		export LARGE_SCRATCH_DEV=yes
+		;;
+	--extra-space)
+		export SCRATCH_DEV_EMPTY_SPACE="$2"
+		shift
+		;;
+	-L)
+		[[ $2 =~ ^[0-9]+$ ]] || usage
+		loop_on_fail=$2
+		shift
+		;;
+	-h|--help)
+		usage
+		;;
+	--)
+		shift
+		break
+		;;
+	*)
+		usage
 		;;
-
-	-*)	usage ;;
-	*)	# not an argument, we've got tests now.
-		have_test_arg=true ;;
 	esac
-
-	# if we've found a test specification, the break out of the processing
-	# loop before we shift the arguments so that this is the first argument
-	# that we process in the test arg loop below.
-	if $have_test_arg; then
-		break;
-	fi
-
 	shift
 done
 
+# Remaining arguments
+if [ $# -gt 0 ]; then
+	have_test_arg=true
+fi
+
 # we need common/rc, that also sources common/config. We need to source it
 # after processing args, overlay needs FSTYP set before sourcing common/config
 if ! . ./common/rc; then
-- 
2.55.0

