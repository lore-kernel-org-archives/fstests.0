Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2663033C
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ru3al2Sj"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E71BF7
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=syBZPWaLHClciUyk0/kDKS86tiL6cp5bJb2e97y8P2c=; b=Ru3al2Sjnxg8BbFeFAg7cKF8Wa
	LxfaB0gDvg7nftayObUXybSNSPz3RIePHWibHtnPPhBp9ukMFgTuIUWCbOkEGyf3Cx8rty6H/LjxM
	Wr7d6y4wFnlBoUaPduJ0GVUadGgLkok+bV8Qswq/w0GZxy8nefbb9dr8o5Rkb4wreBIyuc2eHNU1C
	ITOeE0En/+xHm89uLdq4bVm8rC9jb0KvvtS/msu/C1VWdiUR/vElPHhIrxMhV5PP31zVCud1SIv0u
	Sp7OhRAVhQ2WzhSd32F5Zj0HyM6ZbxUONjsbVywfJg9lzKwlkz5YZFO97ZHlab/4A8pl531Zc4wgo
	Z2mwg8pg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r0kPv-004BTh-1L
	for fstests@vger.kernel.org;
	Wed, 08 Nov 2023 15:24:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: fstests@vger.kernel.org
Subject: [PATCH] generic/726,727: add missing _require_scratch_reflink
Date: Wed,  8 Nov 2023 16:24:28 +0100
Message-Id: <20231108152428.432995-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

These two tests require reflink functionality, add the correct
statement to ensure that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/726 | 2 ++
 tests/generic/727 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/generic/726 b/tests/generic/726
index f0d8df2e..77afe10c 100755
--- a/tests/generic/726
+++ b/tests/generic/726
@@ -19,6 +19,7 @@ _begin_fstest auto fiexchange swapext quick
 
 # Import common functions.
 . ./common/filter
+. ./common/reflink
 
 # real QA test starts here
 
@@ -28,6 +29,7 @@ _require_user
 _require_xfs_io_command swapext '-v vfs -a'
 _require_xfs_io_command startupdate
 _require_scratch
+_require_scratch_reflink
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
diff --git a/tests/generic/727 b/tests/generic/727
index 2cda49ea..1f9eebc5 100755
--- a/tests/generic/727
+++ b/tests/generic/727
@@ -20,6 +20,7 @@ _begin_fstest auto fiexchange swapext quick
 # Import common functions.
 . ./common/filter
 . ./common/attr
+. ./common/reflink
 
 # real QA test starts here
 
@@ -31,6 +32,7 @@ _require_command "$SETCAP_PROG" setcap
 _require_xfs_io_command swapext '-v vfs -a'
 _require_xfs_io_command startupdate
 _require_scratch
+_require_scratch_reflink
 _require_attrs security
 
 _scratch_mkfs >> $seqres.full
-- 
2.39.2

