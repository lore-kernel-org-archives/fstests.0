Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3D3DDAE1
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333126; cv=none; b=bZw9Bh860Qybry4JdwLchy6CgGS5XFDiop9rlPPAwA84f1TYMXHvSAr5hh/oK8rhjR8WfvQPYOsD9JPo6L6To9mORc8Mexj/o4BbTumQC5NIIWz6AGIO2HeJCViNRAl5orclsZSWWip2Tx6towXk54Tes3omM9u5UnUOgG/m+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333126; c=relaxed/simple;
	bh=X6wtm7ICSUzIEPXvpmtsmFmE8CED2RDRLB9xYRP/6z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6fXIfI3y1QaTRBUmWAJhQLHy85EbsEeaHrq7XSiipOFoxguJvrljhmkXpigVOvp9E1pXMz9zKn3Kmh4A4NS+H3LZEZK08HwUQVpK9MUjLEPHhIlvYHyGa5Rn75hOF311S3wPrdjC737QYVo7MA3Vmwkq2I06SomzWS8+1nwGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAJGK2dK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAJGK2dK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B291F00898;
	Fri, 25 Sep 2026 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333122;
	bh=NCQVg5uGGI3AvPZSzfTex0ok0V/EKPGquppZ7ERZgIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DAJGK2dKarkUgrmH5W+ULC69N9ttXbh8BoKRsTaQrMkYAKl+TbKb6uTjGjan9Mt/Z
	 6IvKDav1rdJq/5xbfBVTEAt1V3Y70EVOxJ4MLni6PTG7nq64Miqs4TuAm9HE97ILw5
	 C0nIplak2kwZfZ2XhDWuM5JJTLZse8Ao6aLiXxPU23y/D/BUumOf9nQyLIqooHm0mT
	 zqjMxJMfkgT/IYxbe9AcqDaY2Vr1fM4I5iQ1klovWInFL7/P6slVXkzqXR9xUa5039
	 Aog19gUO4T0WWfFdBOTXG/TwOaicsa0kuatzR0CCjx0OE2ayeba/9qJHxfMRv+8m3U
	 zKoa25O5QxIyg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/4] common: link .out file to the output directory
Date: Fri, 25 Sep 2026 12:45:10 +0200
Message-ID: <20260925104514.664260-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925104514.664260-1-aalbersh@kernel.org>
References: <20260925104514.664260-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On immutable systems with read-only system packages, 'ln' will fail to
link .out files into system xfstests root directory. Fix this by linking
golden output file to the results output directory as a .out.good.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 check     | 14 +++++++++-----
 common/rc |  4 ++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/check b/check
index bca302151955..534c2cdf7a06 100755
--- a/check
+++ b/check
@@ -1050,7 +1050,7 @@ function run_section()
 		mkdir -p $RESULT_DIR
 		rm -f ${RESULT_DIR}/require_scratch*
 		rm -f ${RESULT_DIR}/require_test*
-		rm -f $seqres.out.bad $seqres.hints
+		rm -f $seqres.out.bad $seqres.hints $seqres.out.good
 
 		# check if we really should run it
 		if _expunge_test $seqnum; then
@@ -1181,7 +1181,11 @@ function run_section()
 		$timestamp && _timestamp
 		stop=`_wallclock`
 
-		if [ ! -f $seq.out ]; then
+		local out=$here/$seq.out
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
+				echo "(Run '$diff $out $seqres.out.bad'" \
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

