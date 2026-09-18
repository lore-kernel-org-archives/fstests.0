Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496A358372
	for <fstests@vger.kernel.org>; Fri, 18 Sep 2026 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752765; cv=none; b=h95wRiLaNBYe8mLQW3BR3CenXW/sqeW7jRhudcAbj0UDKVzXi9xLeIHkI6iCIVNfPmeJrJau/7DitCOqkfL/xTdjJecuNIbFh6hqyln68UDT6vprcaebVctJoOLcpJrKy3TV5XyOwboSSyCAOci+FRfAN6nJ0Mc/byaWH/aLezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752765; c=relaxed/simple;
	bh=oRULhetWlLHfrOa89slw8YJZx8g2BI90P3fpWotNdOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz9KxiZL5iSkEwx8QQ2VV4gG4TuX9aHW1lOeEi3nRWbgBK43RuBaAs1RTauN8M7d/Mq1TFEEPwdw0NS9w7Avoc5g/vxIYsf779MgoPIyhQfZSTFZVe2u6ae8s8WW+Egvq5KgWlL0XZ2wv+WF4Dpyw9Mm+ktfu6tCM0bL3GBnQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ25xDXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ25xDXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7C51F00899;
	Fri, 18 Sep 2026 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752755;
	bh=CkbcEIdTVDV2Go22rXEg0TfZJhCgdCoM3txOJtTZIhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kQ25xDXVvjJdm6PTgwVpOuJVVk42lJYyffZ/+LOVzUUKKU1u82In+k/5FiDfaCND1
	 pfqCazJXzrKKWLcwDFVB7xS+rR8/iaYMXkfvcCkvim3XW3JAWhyMhyulUS+X6rXpH0
	 bxT7+wcg/yiab6cSbJE9GB6nvfpVM+iDtDpPMpfPxF0zBsN1q/YfZ41LCBrE99Q8Q1
	 F2A2C5D7Ca3Lz1hqFpe1ege2K5V55FH2O+mOLUYkH4Enk7klKgI2OdvyvffNQX4Z6b
	 /A3cdfyo0lvZViqwAy5//X8q3hdESIrbkAgmlxvf+IVzRz3sf8r60IdK2kXwwCwRTT
	 2lma84Zxo8E7A==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 2/4] common: link .out file to the output directory
Date: Fri, 18 Sep 2026 19:32:07 +0200
Message-ID: <20260918173218.1254465-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918173218.1254465-1-aalbersh@kernel.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On immutable systems with read-only system packages 'ln' will fail to
link .out files into system xfstests root directory. Fix this by linking
golden output file to the results output directory as a .out.good.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 check     | 12 ++++++++----
 common/rc |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/check b/check
index bca302151955..aaed9f4af2ac 100755
--- a/check
+++ b/check
@@ -1181,7 +1181,11 @@ function run_section()
 		$timestamp && _timestamp
 		stop=`_wallclock`
 
-		if [ ! -f $seq.out ]; then
+		local out=$seq.out
+		if [ -f $seqres.out.good ]; then
+			out=$seqres.out.good
+		fi
+		if [ ! -f $out ]; then
 			_dump_err "no qualified output"
 			tc_status="fail"
 			rm -f "$seqres.mountfail?"
@@ -1193,7 +1197,7 @@ function run_section()
 		# from `foo' to 'foo'. Filter old versions to match the new
 		# version.
 		sed -i "s/\`/\'/g" $tmp.out
-		if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
+		if diff $out $tmp.out >/dev/null 2>&1 ; then
 			if [ "$tc_status" != "fail" ]; then
 				echo "$seqnum `expr $stop - $start`" >>$tmp.time
 				echo -n " `expr $stop - $start`s"
@@ -1202,13 +1206,13 @@ function run_section()
 		else
 			_dump_err "- output mismatch (see $seqres.out.bad)"
 			mv $tmp.out $seqres.out.bad
-			$diff $seq.out $seqres.out.bad | {
+			$diff $out $seqres.out.bad | {
 			if test "$DIFF_LENGTH" -le 0; then
 				cat
 			else
 				head -n "$DIFF_LENGTH"
 				echo "..."
-				echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
+				echo "(Run '$diff $here/$out $seqres.out.bad'" \
 					" to see the entire diff)"
 			fi; } | sed -e 's/^\(.\)/    \1/'
 			tc_status="fail"
diff --git a/common/rc b/common/rc
index cb6db6799c97..570a9511c9be 100644
--- a/common/rc
+++ b/common/rc
@@ -3893,8 +3893,8 @@ _link_out_file_named()
 		print $result
 		' <$seqfull.cfg)
 	rm -f $1 || _fail "_link_out_file_named: failed to remove existing output file"
-	ln -fs $(basename $1).$suffix $1 || _fail "$(basename $1).$suffix: could not setup output file"
-	test -r $1 || _fail "$(basename $1).$suffix: output file for feature set \"$2\" not found"
+	ln -fs $(realpath $1).$suffix $seqres.out.good || _fail "$(basename $1).$suffix: could not setup output file"
+	test -r $seqres.out.good || _fail "$(basename $1).$suffix: output file for feature set \"$2\" not found"
 }
 
 _link_out_file()
-- 
2.54.0

