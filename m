Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E7148827
	for <fstests@vger.kernel.org>; Tue, 18 Mar 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304304; cv=none; b=hd9i90aphl0TiCS+/1V7Dqqj/IxVavYHXZMD20aatQnNp/zuvVY+Uz1VqtOvcd9b3p+JO8i6WQf32yXmwgM5BIxbFgtsOLhI0Kc3z2fj8R2kKV1DzERBG33fYoQA9jkLrjUgiqcFE1bCLH34ILlkr0soCntl2KVR0zOfHoLiLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304304; c=relaxed/simple;
	bh=Onv1ADy4SnqCC6IlznnSLRejOGZkl4CepZZ96nadWY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNO0U5pDjLgG0UuvcBQybDEMySdvBV4/4kEvkz3oMgUhszrVbsS9N4g9bY+2zjO9ya06UGubqkEZUcfpB545gNbs+krRnj0iPTc2gmiIH6ERa4ouypsLrv25lrzLqtkJcuZ4VyKT1YfDbc/sjAs04lOuRh1YuMUX8XfTHPXEDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ0oZIK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ0oZIK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C550C4CEDD;
	Tue, 18 Mar 2025 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742304303;
	bh=Onv1ADy4SnqCC6IlznnSLRejOGZkl4CepZZ96nadWY0=;
	h=From:To:Cc:Subject:Date:From;
	b=DQ0oZIK19DAU/tk6FhTt8t01b/FiP8WOyf3S8rb+dRlOByTixP+G6Gdc4jEP23DHU
	 tES7yT3gYr/bsIn1IP4qxB9QQ6hQle0Vt5TVz0UsS2/9T/X3fYIY/+mIK1qJ1j7P1v
	 GxOfJKYF006RfDihpKawyxp6YQm3lw1cONZ64NlXyzs1b0iMsAySbboxEuDOMcyv7p
	 7QTSheYKPLH+U9wAcy7CgA0JXdoAMcaFbzRIK6UgMKcBxe4CHjoN7u/l425PExkuh5
	 yaLPCDQ2gd7Cryuf75aDkKd46WpkRg0+HkcVLH4zMo7dPWo4/2N76j8exNBIc5cX1n
	 aTk9LTOvP80Pg==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH] common/rc: _add_dmesg_filter returns when RESULT_DIR is null
Date: Tue, 18 Mar 2025 21:24:59 +0800
Message-ID: <20250318132459.152699-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I always hit below error on a system with readonly rootfs:

  ++ _xfs_prepare_for_eio_shutdown /dev/loop0
  ...
  ++ _add_dmesg_filter 'Internal error'
  ++ local 'regexp=Internal error'
  ++ local filter_file=/dmesg_filter
  ++ '[' '!' -e /dmesg_filter ']'
  ++ echo 'Internal error'
  ./common/rc: line 4716: /dmesg_filter: Read-only file system

The RESULT_DIR is null, due to xfstests/check calls _test_mount and
_scratch_mount before RESULT_DIR creation. And _test_mount does
_prepare_for_eio_shutdown -> _xfs_prepare_for_eio_shutdown ->
_add_dmesg_filter "Internal error" when RESULT_DIR is null.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index e51686389..01e89747d 100644
--- a/common/rc
+++ b/common/rc
@@ -4716,6 +4716,12 @@ _check_dmesg_filter()
 # Add a simple expression to the default dmesg filter
 _add_dmesg_filter()
 {
+	# This function might be called before having RESULT_DIR, do nothing
+	# if RESULT_DIR isn't created
+	if [ ! -d "${RESULT_DIR}" ];then
+		return 1
+	fi
+
 	local regexp="$1"
 	local filter_file="${RESULT_DIR}/dmesg_filter"
 
-- 
2.47.1

