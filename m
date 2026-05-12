Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5D36A343
	for <fstests@vger.kernel.org>; Tue, 12 May 2026 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592359; cv=none; b=dx05Ogbq5yK8uCmKXxyD6aIe4bIuHYLKrN/FbO0Zo1oWXQYgZDOKElcMxag26zftC5LOIWUqpe8DsDFZX9loJZbz1iJMiocu3doasiHA8OR9DZCjJVVF53XhapPyvRyCUjbjnHdZxZ1Vr68ahP5HBYNszjx35YSbmUxcEtJURug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592359; c=relaxed/simple;
	bh=u9QVFwEqL2HnHbVjO1PqmeotvTnwMwlTsnWS2VWsYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+vDfSQhfwMHit/3fLfqLRLnNqWepUbtw1Ior6D6l4a+m2UAKR4X9RQPf418sWKu1Peggm2tXIzqlKnZ9vsw/V24r9I3JxQK+HS3ZrVtjcDZx70BDx50SY3UCJWlD+J2Yxy5vtdkYl1W/r/PZ7/ZXdoXnbL7/JsRSuc4WrVHdjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM2Cjsn7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM2Cjsn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4841FC2BCB0;
	Tue, 12 May 2026 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592358;
	bh=u9QVFwEqL2HnHbVjO1PqmeotvTnwMwlTsnWS2VWsYbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fM2Cjsn7fyS4FZqual1qdp2A/SuJnNaS8WpmwgnMHbe4wytP/DqePlqZqsBVRos+7
	 2Lqnbj3vkM0fBLStj6HyUYOx3m8pz2TJQcPPeSQOPpibxhvXX+a+rCaO3Qn39VnlAl
	 k1Cv4aY79WHkfBTrtAvhD30OxeYGTD2sjRYrnZDytpnOb0zq0FYoDT7BR2zdnOWwYO
	 fQFAZrZETZ+YuxUmSV9X80t0BORZ+fwfYTaphNBcfUnBXaZn4SoUHPQD40/+Ay74eA
	 qEJ51fwf2Wm7B2O6MNirL8byMHImWJ4S7fV1dqUL1V8mbGOHn40Nf6GY7uHMhRDeY7
	 /6lWo971CsdLw==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [RFC PATCH 1/4] check: refactor argument parsing with getopt
Date: Tue, 12 May 2026 21:25:36 +0800
Message-ID: <20260512132539.931482-2-zlang@kernel.org>
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

Replace the legacy, hand-written argument parsing loop with getopt.
Also compatible with old-style options (e.g. -nfs, -afs, -glusterfs,
-cifs, -9p, -fuse, -virtiofs, -pvfs2, -tmpfs, -ubifs, -overlay,
-udiff), pre-process them into long options before giving to getopt.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 check | 179 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 126 insertions(+), 53 deletions(-)

diff --git a/check b/check
index ad685edc..11bdf81b 100755
--- a/check
+++ b/check
@@ -272,48 +272,97 @@ _prepare_test_list()
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
@@ -322,40 +371,64 @@ while [ $# -gt 0 ]; do
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
2.54.0

