Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091962;
	b=Ak9LECovO9nPoanumzqZpg4x0jJJYseLAV6f7zXXoy2DJZ/3bydhpcGPT+X0Shc/KGB2
	 cf1dYSdm+360LYtB7mhJKiRaL/eSiPeeWwFTIgRfUWry1XHeB0z5CzRQKMAsisKn8s84V
	 KY/IpGzsCUbc6wMuH+Iez/KX9VAon2TbotYm/C0AW5mnMyJEzTvHx340W8QjKp+eOQh7q
	 06/5TshVY7Qm2GMx6qS30CaWWOTWjiYBLxYKpWL4dyaLF53LgeEOpURVPXxro+yxQp/f6
	 aC7/KLNw4N++6UJ1A8YJdmnhmcMjcisJsduPx4D3pmGoTvp3ic4tWwhYT2TUILnTGrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lHH1xXy3JaK2XSawc2qMGlruT/q80Pmcz/yyT0u8T5c=;
	b=XjHDOaHdSzSz+Q/UK5J6Gezdw0vfENpKRf9kSRu38AF+6mTT/gkxoVht2uEMHxzDQuDK
	 T57ISr0GtThnSKCt/AewL4ftAFZ++BBHSKZCR2cNajIM2xZ/xkFRizdLgN47TnzJexuQz
	 icvhuBU7kVW6tlAsj209T8/6Hir+2aWPhk4rpjj098jHq5q0uDy1L8U/GBOeC01gj16E8
	 lAE2G1F6dGeUADf3Gr63c2V1MgXvxfPkzfkaW79gZ0N+fIQtp4RpD1Ag6Jt/IH3XpmUjX
	 b45kQJJrCsVIACnyGIK/UV80HHVzqt1CtonQcTYHM3IIUfLVpBoXR7yRC8vFakP2vUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3bV6dyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2288606A337
	for <fstests@vger.kernel.org>; Thu, 19 Nov 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3bV6dyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607661F000CB;
	Thu, 19 Nov 2026 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091961;
	bh=lHH1xXy3JaK2XSawc2qMGlruT/q80Pmcz/yyT0u8T5c=;
	h=From:To:Cc:Subject:Date;
	b=V3bV6dyQ9FPVgtumW4p9DpDFjk5VzT6ZQxk2irEM+Sh+ZBu+BensTuihK5JEv3G35
	 B4qpdxkcveq39fm1xRXPWkijzTb03jhvD6imVX+rez2PybQUTaA5JvI0+mZBWSQkQr
	 DMpIDhm9mtmxjv05bNkdhtVMj2vuGSiKVeM2uPsneDExu5Jj7mAUfQRnFUA/bKyHB4
	 4LxcI1rKVaRzFoYqxK1wwA3n7GVA+olG/12+r7QNuK81qxcHPSOt4RGC2O0aU2Lhpd
	 w/XVKzjyR6jBd0LE9CPfkj4yIoy/FGWMK/9eKDxaL3Iq7rhO33TOOC9vGrKs66WNXv
	 52OiTe+Wuj8Dg==
From: cem@kernel.org
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	jencce2002@qq.com,
	cem@kernel.org
Subject: [PATCH v2] add tmt as a new output format
Date: Thu, 19 Nov 2026 13:38:55 +0100
Message-ID: <20261119123910.294544-1-cem@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cmaiolino@redhat.com>

I've been trying to expand my testing matrix leveraging the testing-farm
cloud (https://testing-farm.io/), which is a public testing cloud available
for opensource testing.

Testing-farm uses tmt (https://github.com/teemtee) to orchestrate the
tests within the provisioned VMs.
tmt however expects each individual test to be, well, an individual
test so by default it would put a whole xfstests run as a single test
case with a looooong report.
However we can use a tmt-report-result tool to report each test ran
individually as a sub-test, so the report looks a bit more granular,
easy to read and prevent my eyes from bleeding while looking at its
testing reports.

I know tmt can also be used to orchestrate tests on a local machine.
Although I have no use for that, it might be useful for someone else,
reason why at the end of the run it will also print out the tmt report
file location. This also makes the output consistent to what xunit
format does.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
V2:
	- Add Murphy's suggestion to the log output if it fails
	  to add a test result to the final report

 check         |   2 +-
 common/report | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/check b/check
index afe855bcf0ed..420ac7d274df 100755
--- a/check
+++ b/check
@@ -74,7 +74,7 @@ General options:
     -S section              exclude the specified section from the config file
     -T                      output timestamps
     -R fmt[,fmt]            generate report in formats specified. Supported
-                              formats: xunit, xunit-quiet
+                              formats: xunit, xunit-quiet, tmt
     --exact-order           run tests in the exact order specified
     --extra-space <size>    require minimum free space on scratch device
     --fs <type>             test the given FSTYP; valid types include:
diff --git a/common/report b/common/report
index 2fa15e62f1e7..0a4a39285ef4 100644
--- a/common/report
+++ b/common/report
@@ -14,6 +14,8 @@ REPORT_ENV_LIST_OPT=("TAPE_DEV" "RMT_TAPE_DEV" "FSSTRESS_AVOID" "FSX_AVOID"
 		     "KCONFIG_PATH" "PERF_CONFIGNAME" "MIN_FSSIZE"
 		     "IDMAPPED_MOUNTS")
 
+TMT_REPORT_RESULT_PROG="${TMT_REPORT_RESULT_PROG:-tmt-report-result}"
+
 encode_xml()
 {
 	cat -v | \
@@ -244,7 +246,122 @@ _xunit_make_testcase_report()
 }
 
 
-#
+
+_tmt_assert_env()
+{
+	if [ -z "$TMT_TEST_PIDFILE" ]; then
+		_fatal "report format 'tmt' can only be used when xfstests is run as a tmt test"
+	fi
+	if ! command -v "$TMT_REPORT_RESULT_PROG" >/dev/null 2>&1; then
+		_fatal "report format 'tmt' requires $TMT_REPORT_RESULT_PROG to be installed"
+	fi
+}
+
+# tmt subresult names have to be unique within a tmt test, so prefix each test
+# name with its specific section.
+_tmt_testcase_name()
+{
+	local sect_name="$1"
+	local test_name="$2"
+
+	if [ $sect_name == '-no-sections-' ]; then
+		echo "/$test_name"
+	else
+		echo "/$sect_name/$test_name"
+	fi
+}
+
+__tmt_log_append()
+{
+	local log="$1"
+	local title="$2"
+	local file="$3"
+
+	test -s "$file" || return 0
+	echo "--- $title ---" >> "$log"
+	cat "$file" | tr -dc '[:print:][:space:]' >> "$log"
+	echo >> "$log"
+}
+
+# tmt-report-result can attach a single log to a subresult and display that
+# on its web interface. Gather whatever logs a specific test left behind
+# so we can see it on the web interface instead of digging into the resulting
+# artifacts. Do that only for failed / notrun tests as we don't need it if a test
+# passed properly.
+_tmt_make_testcase_log()
+{
+	local test_name="$1"
+	local test_status="$2"
+	local log="${REPORT_DIR}/${test_name}.tmt.log"
+
+	# $REPORT_DIR/<group> is created by check before the test is run
+	rm -f "$log"
+
+	case $test_status in
+	"notrun")
+		__tmt_log_append "$log" "not run" "${REPORT_DIR}/${test_name}.notrun"
+		;;
+	"fail")
+		local out_src="${SRC_DIR}/${test_name}.out"
+		local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
+
+		if [ -n "$_err_msg" ]; then
+			echo "$_err_msg" >> "$log"
+		fi
+		if [ -s "$outbad_file" ]; then
+			echo "--- output mismatch ---" >> "$log"
+			$diff "$out_src" "$outbad_file" >> "$log"
+		fi
+		__tmt_log_append "$log" "hints" "${REPORT_DIR}/${test_name}.hints"
+		__tmt_log_append "$log" "dmesg" "${REPORT_DIR}/${test_name}.dmesg"
+		__tmt_log_append "$log" "mount failures" "${REPORT_DIR}/${test_name}.mountfail"
+		__tmt_log_append "$log" "full output" "${REPORT_DIR}/${test_name}.full"
+		;;
+	esac
+
+	test -s "$log" && echo "$log"
+	return 0
+}
+
+_tmt_make_testcase_report()
+{
+	local sect_name="$1"
+	local test_name="$2"
+	local test_status="$3"
+	local outcome
+	local log
+
+	case $test_status in
+	"pass")
+		outcome="pass"
+		;;
+	"fail")
+		outcome="fail"
+		;;
+	"notrun"|"list")
+		outcome="skip"
+		;;
+	*)
+		outcome="error"
+		;;
+	esac
+
+	log=`_tmt_make_testcase_log "$test_name" "$test_status"`
+
+	# tmt-report-result is chatty on stdout, which would interleave with
+	# the test results printed by check.
+	"$TMT_REPORT_RESULT_PROG" \
+		"`_tmt_testcase_name "$sect_name" "$test_name"`" \
+		"$outcome" ${log:+-o "$log"} >/dev/null ||
+		echo "check: failed to report `_tmt_testcase_name "$sect_name" "$test_name"` to tmt"
+}
+
+# Only useful if using tmt locally, but keeps consistent with xunit implementation
+_tmt_make_section_report()
+{
+	echo "tmt report: $TMT_TEST_DATA/tmt-report-results.yaml"
+}
+
 #  Common report generator entry points
 _make_section_report()
 {
@@ -260,6 +377,9 @@ _make_section_report()
 						   "$bad_count" "$notrun_count" \
 						   "$sect_time"
 			;;
+		"tmt")
+			_tmt_make_section_report
+			;;
 		*)
 			_dump_err "format '$report' is not supported"
 			;;
@@ -279,6 +399,10 @@ _make_testcase_report()
 			_xunit_make_testcase_report "$sect_name" "$test_seq" \
 						    "$test_status" "$test_time" "$report"
 			;;
+		"tmt")
+			_tmt_make_testcase_report "$sect_name" "$test_seq" \
+						  "$test_status"
+			;;
 		*)
 			_dump_err "report format '$report' is not supported"
 			;;
@@ -291,6 +415,9 @@ _assert_report_list() {
 		case "$report" in
 		"xunit"|"xunit-quiet")
 			;;
+		"tmt")
+			_tmt_assert_env
+			;;
 		*)
 			_fatal "report format '$report' is not supported"
 			;;
-- 
2.56.0

