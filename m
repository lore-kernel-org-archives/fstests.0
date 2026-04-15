Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471338F656
	for <fstests@vger.kernel.org>; Wed, 15 Apr 2026 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288779; cv=none; b=d7HfXWmsSXjUn2uWzosIZCQ9GS7bdPk9xmjb6BQzbOxQewwmUg171NM/sWyzgN+E/jTJ8joFPsTzzie/cQHb5AXIiVRfPwG3Dl6pxuBDDPLF2JbJapmWOjqBpa4lmesose2ScxA+yQERF7YXJ7UXkoSErbawAfqnHQiKLTZXEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288779; c=relaxed/simple;
	bh=QXrQ73ttKh4Y8hLOs1eBx6y4vc3C+32Ttr+sZeUhIYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5lHQFbA2Xg7K0CL3nA801urBzYF6PKFZgyj0POCKUA8pfdEiQxXDTkav3sxEu+ZjOEjNJ0NdA8JTO9sdiaP3X8h9ccDS47KvTzc8EjV3rRZ8QLvkV+GA18aiT7J3/nqrdgpmfTNS9kUJ9XOuY78v7fLfTev7xRg04xZ8OhMBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ia7EHYeN; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ia7EHYeN"
Received: from trampoline.thunk.org (pool-173-48-114-3.bstnma.fios.verizon.net [173.48.114.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63FLWqLY032604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 17:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1776288773; bh=XedYXqUiM5ETQIoxaoYRNON7sq79qLv4YMpJiqJVZAE=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=ia7EHYeNp/Nptq1B6NOFt10sFue9CPRk3tM3UuXOxm+bdS2VZQRHEsQnM/Blg2WFN
	 y3WHhGsWXqVyIH6PySu7wh6HB76x4VyxGpq52M0p9/6Vv+xRTCfRTfrYloVw/BmZgT
	 xBOQYoTFxo8BOnP/YYYCdepVyVsyaXuhg7slp/tpvkq3qNunNcKlnQ0gk/bd01eaFP
	 mwjWCuJ74hwF4lnRgKUjj3hFaC+H9xb73XC6OQkmJFUw5RG90dX7+0N0yftCW0PWZ5
	 DYoRTUNxu8re4ZQoGTELDB2zGCAg673p/ID7OphLYJVzyux+TXaw4eaN5hH/iGxg8D
	 VyfmxCcD+SHIg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F38AF2E00D6; Wed, 15 Apr 2026 17:32:51 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC] check: add new option "--loop <n>" which runs each test multiple times
Date: Wed, 15 Apr 2026 17:32:48 -0400
Message-ID: <20260415213248.1795275-1-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the check script a new option --loop, which re-run each test
multiple times.  This works very similarly to to -L, which will retry
a particular test after it first fails, except that the test is rerun
unconditionally.

This differs from the "-i <n>" option, which iterates each set of
tests <n> times instead of each test.  The -i option is problematic in
two ways.  First, doesn't save the test artifacts from each test run.
This is unfortunate because when the developer is trying to debug a
flaky test failure, running "check -i 100" will run a test 100 times,
but if only the 42nd test fails, the NNN.out.bad file for that failing
test run is not preserved.  The second difference between --loop and
-i is the result.xml file is rewritten after each test set, so we do
not have the cumulative statistics of the 100 test runs in the junit
XML file.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Note: This commit adds a new command-line option instead of changing the
behavior of -i because it's possible that *someone* actually likes the
current behavior of the -i option, and changing how -i works might
break their test runner infrastructure.

Speaking personally, I find the current -i option completely useless
for the needs of xfstests-bld, and I would be happy to just change how
the -i option works.  This would also require changing support for -I,
but I was planning on adding an --loop-while-successful option
eventually, since it would be faster for bisection (although I
normally don't care about the junit XML file for NNN.out.bad files
when bisecting, so I find -I much less objectionable than -i).

 check | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/check b/check
index cd7a79347..923d81a28 100755
--- a/check
+++ b/check
@@ -27,6 +27,8 @@ DUMP_OUTPUT=false
 iterations=1
 istop=false
 loop_on_fail=0
+loop_always=0
+loop_count=0
 exclude_tests=()
 
 # This is a global variable used to pass test failure text to reporting gunk
@@ -85,6 +87,7 @@ check options
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
     -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
+    --loop=<n>		loop tests <n> times, measuring aggregate pass/fail metrics
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -339,6 +342,12 @@ while [ $# -gt 0 ]; do
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
 	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
 		loop_on_fail=$2; shift
+		loop_count=$loop_on_fail
+		;;
+	--loop=*) loop_always=${1#*=}
+		[[ $loop_always =~ ^[0-9]+$ ]] || usage
+		loop_count=$(( loop_always - 1))
+		set +vx
 		;;
 
 	-*)	usage ;;
@@ -604,7 +613,7 @@ _expunge_test()
 }
 
 # retain files which would be overwritten in subsequent reruns of the same test
-_stash_fail_loop_files() {
+_stash_loop_files() {
 	local seq_prefix="${REPORT_DIR}/${1}"
 	local cp_suffix="$2"
 
@@ -629,9 +638,9 @@ _stash_test_status() {
 
 	if ((${#loop_status[*]} > 0)); then
 		# continuing or completing rerun-on-failure loop
-		_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
+		_stash_loop_files "$test_seq" ".rerun${#loop_status[*]}"
 		loop_status+=("$test_status")
-		if ((${#loop_status[*]} > loop_on_fail)); then
+		if ((${#loop_status[*]} > loop_count)); then
 			printf "%s aggregate results across %d runs: " \
 				"$test_seq" "${#loop_status[*]}"
 			awk "BEGIN {
@@ -651,9 +660,9 @@ _stash_test_status() {
 
 	case "$test_status" in
 	fail)
-		if ((loop_on_fail > 0)); then
+		if ((loop_on_fail > 0 || loop_always > 0 )); then
 			# initial failure, start rerun-on-failure loop
-			_stash_fail_loop_files "$test_seq" ".rerun0"
+			_stash_loop_files "$test_seq" ".rerun0"
 			loop_status+=("$test_status")
 		fi
 		bad+=("$test_seq")
@@ -661,7 +670,14 @@ _stash_test_status() {
 	list|notrun)
 		notrun+=("$test_seq")
 		;;
-	pass|expunge)
+	pass)
+		if (( loop_always > 0 )); then
+			# start rerun loop
+			_stash_loop_files "$test_seq" ".rerun0"
+			loop_status+=("$test_status")
+		fi
+	        ;;
+	expunge)
 		;;
 	*)
 		echo "Unexpected test $test_seq status: $test_status"
-- 
2.51.0

