Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894764;
	b=wnuXSSowDmWLQ0A5qJf6hERxL5or+yUgaFE1g6YwXv4zy+0y3KJtG2T2chqneMm9Jb4g
	 +FaCxc+6111N5puEjGqGa6QQleemdlAlRUAZ5H+4EC05HY4tYCLlr0h7GOQ1BdbBTp30v
	 pHyj4EvXo/01hCzJO+aylHJXayLQU+TmH7uOOI2/AeU1vgepxh4tq39WqpUts3fGjseYk
	 YKBefDFQb5GicvJy3F/SQcZ7uNmeUpqQgxa8psyVAHDczRYK2Gk5RLNPIAKIzmiGYjg+S
	 hZAjVzYDB9YzirIDNrJJhCb8NexGD/Y4yxm08tYDU0rbfINSa51YyroVW3jlzlNwrmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894764;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DmHcoJJIk4zbH+BUNcu8mTpRZCizYlcJfoe6e12QLEs=;
	b=hoaJ3N8esSkOT45lmCfr+5bdMiHaRSpBX8nt1RVdhNf4pZqMXot/FOZHbUGLq4c9xQJ+
	 wXI2DrqDhTFj/EM4ZspyCYu3/elmS98l3tTZLYO0sh1tU5O3SPFWhRQBnlimJNCs3Mu2R
	 tU10Ou3bO9PNlQy5e+YShm5ZdPapaPTzyQAoIpHqAlN5gN0ghq4118itGiYKcgUf/BeAM
	 bwXLMGpBDFnxEhlc2fLo27Uz1wBmlF/jt4jYMiWT10TPwc2abjuhMUGk0T+muWs+fwYoJ
	 /osc63MY+yfVyqoz6wKEoXw+Otko16u8K7LeXi+p2cdmoWuj2QVzbVlg/ay/rmf5Q5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTvMvG0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB1606A32E
	for <fstests@vger.kernel.org>; Thu,  5 Nov 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTvMvG0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706BA1F000C1;
	Thu,  5 Nov 2026 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894763;
	bh=DmHcoJJIk4zbH+BUNcu8mTpRZCizYlcJfoe6e12QLEs=;
	h=From:To:Cc:Subject:Date;
	b=YTvMvG0yHAv2ltctznC6XJ2ydBCZ5ddR4+CsxLawt+49goT1gXPGXOI7JwCsMxZI/
	 gsayUIyV+46XbbNPlkqeo42BfUi0t3gAiW/zeibpLqbgGynCzbAqv7tSnAbk7IMr2g
	 gRECZY/Q87/yhiAkmxOwY8FPDu38RPkbxKYyNNRHPkgRrKSS7WbNRqOto+ogpvTkkk
	 QaqCiQf7uoLL6uDPaGidTk96WvETGNuTFVcjsu2rDciWXYhZO8M19fnpihQbgONw25
	 TzEXvEI2E5eFbZMJbsSV49pWe2rqX/p4vr5314o/o8b0wXWfKHM1FmC4cd1hQS2PMR
	 LE//gsvPMLZWg==
From: cem@kernel.org
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	hch@lst.de,
	sandeen@sandeen.net,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH] add tmt as a new output format
Date: Thu,  5 Nov 2026 17:05:20 +0100
Message-ID: <20261105160526.44266-1-cem@kernel.org>
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

Here is an example report of a '-g quick' run with this patch against a
regular distro kernel (Fedora 44). I'm not adding it to the patch
description because honestly I have no clue how long those reports are
kept so it may very well get stale in a few months.
https://artifacts.dev.testing-farm.io/ccd9d09a-f8fc-4460-bdbb-005e1a18bad8/

 check         |   2 +-
 common/report | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/check b/check
index bca302151955..47a76ba04c59 100755
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
index 2fa15e62f1e7..7d5e973a6e02 100644
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
+		echo "check: failed to report $test_name to tmt"
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

