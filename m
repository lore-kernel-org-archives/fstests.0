Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02F331ED6
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156000; cv=none; b=tmHCLCpxJ2y6Ipj7XgOxUd64SKj92Ir/WVSZNLeNo5aAJy/Rd7IRrmNVum5SI2OVk2gRCmQIJQc0IJoZuRHDZnqBd/ZWEpdUFHjyz4OW/3I7yUzkygeh+EkBhqEsu0Q/7XTc8n6jy8P8llMy+bO271gzQjvVG3HVw/KR8MD3C/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156000; c=relaxed/simple;
	bh=p1uVnvmsZhLjJXG5KYzh8k3pR3GAIGmF19wVE7MWpTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG9kZ4VsauUWvMzF+bBt0YuZWHOYO+iEgyf6nIxiUbrqRucKpo5TEfJK06s0LM5NkzSUaTJvma+H9FrNu2qG9uDUw7jamgyleb4Xn69pyT99LZTMTHwGa9yLemDHg5Kd0tWTObGXh2KSgmK5KpByiPdH6OKW2DvJIlVWJM9ISdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JekYE+I1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JekYE+I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2F31F000FF;
	Wed, 23 Sep 2026 09:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155999;
	bh=EJcvhIrg1Yd4go0Ov+p3DObyZIu2TY7ugAhN72Ak2bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JekYE+I1D0yksr5Qjo3T4KZGPFyysAyVTafjbGWtHR7Br4DVywCdZfdtI68+ANxAI
	 s105aD/IHODcWy3cfFFJt+p4HY548qzPhT/3GCv2SCEYbP6Ag+6hiNh+SOmeuk0Ox2
	 fX3C84El5xZDIBOR7SqMRS74EFJz5zRE/xStRTc3k5n97vxxvXwXnt39tMb/RaNnFC
	 GtFDXE82Rh2uECl2gGF/OlLC29anXI8ndc5qkFBB/SBNmUg/1ouOQsQKtPoa0YkFFB
	 cV/qkF+XEI26Q5dLJhLJIQZXZlFTpYDZRo9o5ikWK2YUNNs6QqfyHY78D88Z3Mw+zj
	 AEW99UMZPn6Nw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/4] common: link .out file to the output directory
Date: Wed, 23 Sep 2026 11:32:53 +0200
Message-ID: <20260923093259.16199-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923093259.16199-1-aalbersh@kernel.org>
References: <20260923093259.16199-1-aalbersh@kernel.org>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 3958ac934980..1eccd60c0bc0 100644
--- a/common/rc
+++ b/common/rc
@@ -3907,8 +3907,8 @@ _link_out_file_named()
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

