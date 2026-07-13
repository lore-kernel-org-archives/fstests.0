Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1B434419
	for <fstests@vger.kernel.org>; Mon, 13 Jul 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950781; cv=none; b=jaJ8PU7bLWtmGDGaHR7k756/HPmiOTkYSuXl0/o5LdNIWFwL8zeq3aoaRDlMBAmRpydNyLgzyTe7ByFzTuDWUhqSS6sq8xWItGT9JNm7P5/2Xd4Ya6nAi9s2oodI4lxDSaGFWvKIZfFdykoiZYQ841tRpLjY+i6+vUkq8KDTVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950781; c=relaxed/simple;
	bh=a0BU4ax728mns1U0mSlAUL2+IRB1f04q6ix5t9D3SDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNqfJF9Xf2SzJtnuFwmsPy+xeBIKvbfxj7IwFs9vgYiS+cnBx8BkZeR5h3SW6K/ENVb2qWs3zAUTOy3lrMRSkP7Rp8JxvthTVUdveAG86aR9K1RRxNVGyPn6ulvneZ6SMJJjlkRAiNWeDUAz0suanYrE8nOVSz0rm6Hffb78YLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QXey1Ez8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QXey1Ez8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b966dd74so11946045e9.3
        for <fstests@vger.kernel.org>; Mon, 13 Jul 2026 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783950778; x=1784555578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OyUl63zbU57WT7SbT+WjlY52efw0IkUQqjDEXxuIn0=;
        b=QXey1Ez8t9O8fQgHPZYfy7FBH9KPgXpfjVcLDpDfuHJ5lCg4Cf1h10YPbM8zUqd4N9
         frplBFQ/hkVb11mGbBjoaDTGk8qNEIpP9Dh56Y1eR3S3hwoTaZvC0Fw7ojL5wFnZZMac
         +fd77S9tgE7wkCd4+jjVR/w+dJm6VQ7FPAiwntx+MaZdQpoeyatncYwFNr27EY4H/TOc
         tcFT9sVPpIxddmW6Rz4KebhzZKphphtYemSVjFtNlaxSNqiqVn9A6ftDzASzlms6Msyx
         sxIzjskSy7YfacxnNL024CFMyzToiizoj3zmRCtPyVRh6XaF4wIepTDtQjiP5fmLFBQY
         MKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950778; x=1784555578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5OyUl63zbU57WT7SbT+WjlY52efw0IkUQqjDEXxuIn0=;
        b=BTF2BhE/Sh3NaOXrbgkNeY53sxliV/NQwkuVzqZEPbe3GGzQnN/bBFYbf6KWfr6Rtt
         aN18I3iwgLgUvXy/hDBzgwNlnTTA9zBLyP4qf7hQabRrUwPTw1efAsyElzfY7BtY9hkp
         evRBrA8kWX8hCZIsGtoOVB/pIMDyLcBhJKUoaQVWX7H6fl/9EvFFvzOgcMUAR4Qv/9ji
         +cm5K01DP5c5WlQ0Wk5WamF1ZzuEFwjw+d9TsrUulsam8vQPD7AanSkvwY3MBNlpWpIy
         mlRTJUrDvBoWd+0TkNQ2VeNAg/51LSDGtckVNMnxdKndrPfmnv5OuWMI7YWlekFIVWMF
         C9fw==
X-Forwarded-Encrypted: i=1; AHgh+RpcDe+m2+eB9n54tdkk3gbeJQsHHQvyt0HrjXD7KjiNU7WH/fnkMJ/hHIkY3ypAfkKQRNGYMurb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WOBkLBq+/eT34zdyHvV1ATf7FGTzzDxbpyEnBJbiD05AiB0S
	exDRoMRnclSnEXrWaIRDtYN7oINinPzENRDYsgMwuSYGNDYLbYOwG/3PPoUVUrys9MM=
X-Gm-Gg: AfdE7clHxcsnfU0vAFuquuYgULjSbVecSFURTCy61CMCvDt4OlMcXDoc8rrVD8wVQOc
	sEPoKEssMQph/o8ICjPkW24d/JBx3TLe4o1XuKNwhpNulzGeDeyM//FKcZHVa4EU8s0LVRjPary
	m4u0oOp+TlVD8+2vlvDL987QaoCSQsnPtIDkT0HS807wFM9h1y7wQsaa8Cg+3+2Om6B1E/9Ouk7
	r8pd0kynq1kJzzaxnizi4JJym0eQV6S0e3iJKi23sLOUvRtexIy+0/jPZBbnMMCD9aWbooOE/zr
	mBjLchlsjdxF3rabFsGZnifwMlrvJ/JMYY9RQ0ATrsP8QPXcZ9QtUuhdv6n/IYM3f130A6+kx2b
	Y5K14XM/QBp8Oc0EBsHcvUoQ7ZdMe6exB10iihGgxnP5wxjp/kmvn4oLik79GC+Us+O4eFdsRgc
	A=
X-Received: by 2002:a05:6000:4010:b0:479:190:5873 with SMTP id ffacd0b85a97d-47f2dd02471mr10435117f8f.49.1783950777613;
        Mon, 13 Jul 2026 06:52:57 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm86806032f8f.26.2026.07.13.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:52:57 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: djwong@kernel.org
Cc: avinesh.kumar@suse.com,
	fstests@vger.kernel.org,
	zlang@kernel.org
Subject: [PATCH v2] common: strip attr 2.6.0 --restore safety warnings
Date: Mon, 13 Jul 2026 15:52:56 +0200
Message-ID: <20260713135256.340261-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710234655.GC15202@frogsfrogsfrogs>
References: <20260710234655.GC15202@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avinesh Kumar <avinesh.kumar@suse.com>

attr 2.6.0 (CVE-2026-54371 hardening) makes "setfattr --restore" print a
warning to stderr when neither -P nor -h is given, claiming it may
traverse or dereference symlinks in the dump's pathnames [0]. This warning
leaks into test output and breaks generic/062 and xfs/083 (via
_scratch_populate).

Add a _setfattr_restore helper that runs "setfattr --restore", filters
out just the expected warning line, and preserves any other (unexpected)
stderr. Convert the callers in common/populate, common/overlay and
generic/062 to use it.

[0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 common/overlay    | 2 +-
 common/populate   | 4 ++--
 common/rc         | 8 ++++++++
 tests/generic/062 | 2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/common/overlay b/common/overlay
index d32f3219..73841dd7 100644
--- a/common/overlay
+++ b/common/overlay
@@ -494,7 +494,7 @@ _overlay_trusted_to_user()
 	local dir=$1
 
 	for file in `find $dir`; do
-		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | $SETFATTR_PROG --restore=-
+		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | _setfattr_restore --restore=-
 		for xattr in `_getfattr --absolute-names -d -m '^trusted.overlay.' $file  | tail -n +2 | cut -d= -f1`; do
 			$SETFATTR_PROG -x $xattr $file;
 		done
diff --git a/common/populate b/common/populate
index 1c0dd03e..f7fcd0c3 100644
--- a/common/populate
+++ b/common/populate
@@ -151,7 +151,7 @@ __populate_create_attr() {
 		echo "# file: ${name}";
 		seq --format "user.%08g=\"abcdefgh\"" 0 "${nr}"
 		echo
-	) | setfattr --restore -
+	) | _setfattr_restore --restore=-
 
 	test -z "${missing}" && return
 	seq 1 2 "${nr}" | while read d; do
@@ -200,7 +200,7 @@ __populate_xfs_create_btree_attr() {
 			seq --format "user.%08g=\"abcdefgh\"" "${nr}" "$((nr + incr + 1))"
 			echo "user.v$(printf "%.08d" "$nr")=\"${bigval}\""
 			echo
-		) | setfattr --restore -
+		) | _setfattr_restore --restore=-
 	done
 
 	# ... and in the second loop we delete all the remote attrs to
diff --git a/common/rc b/common/rc
index 79189e7e..6234a580 100644
--- a/common/rc
+++ b/common/rc
@@ -132,6 +132,14 @@ _test_fsxattr_xflag()
 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
 }
 
+_setfattr_restore()
+{
+	$SETFATTR_PROG "$@" 2> $tmp.setfattr.$$
+	local ret=$?
+	cat $tmp.setfattr.$$ | sed -e '/--restore=.*unsafe.*without/d' 1>&2
+	return $ret
+}
+
 # This test requires extsize support on the  filesystem
 _require_scratch_extsize()
 {
diff --git a/tests/generic/062 b/tests/generic/062
index 89659040..3ef96da1 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -186,7 +186,7 @@ _create_test_bed
 _extend_test_bed
 
 echo "*** restore everything"
-setfattr -h --restore=$tmp.backup1
+_setfattr_restore -h --restore=$tmp.backup1 2>&1 | _filter_scratch
 _backup $tmp.backup2
 
 echo "AFTER RESTORE" >>$seqres.full
-- 
2.54.0

