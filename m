Received: from verein.lst.de ([213.95.11.211]:47544 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966143AbcBDPpy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 4 Feb 2016 10:45:54 -0500
Date: Thu, 4 Feb 2016 16:45:52 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: more reflink fixes
Message-ID: <20160204154552.GA31510@lst.de>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454515328-1586-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

And another one:

---
>From 36919b5d1c84b0ceb8b9fc5c33ec1730d10e5d1c Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 4 Feb 2016 16:42:12 +0100
Subject: xfstests: don't run 907 and 908 on NFS

NFS can't interrupt pending clone operations as they are a remote
operation.  Skip the two tests that rely on this as they'll mess up
all following tests otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/907 | 2 ++
 tests/generic/908 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/generic/907 b/tests/generic/907
index fec22c8..e35e067 100755
--- a/tests/generic/907
+++ b/tests/generic/907
@@ -47,6 +47,8 @@ _require_scratch_reflink
 _require_cp_reflink
 _require_command "$(which timeout)" "timeout"
 
+test "$FSTYP" == "nfs"  && _notrun "NFS can't interrupt clone operations"
+
 rm -f "$seqres.full"
 
 echo "Format and mount"
diff --git a/tests/generic/908 b/tests/generic/908
index 09a3101..c977ed6 100755
--- a/tests/generic/908
+++ b/tests/generic/908
@@ -47,6 +47,8 @@ _require_scratch_reflink
 _require_cp_reflink
 _require_command "$(which timeout)" "timeout"
 
+test "$FSTYP" == "nfs"  && _notrun "NFS can't interrupt clone operations"
+
 rm -f "$seqres.full"
 
 echo "Format and mount"
-- 
2.1.4

