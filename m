Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F030C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD2F20739
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UORVCnBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFQJrc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:47:32 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:58002 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQJrc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2020 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OSd9W
        /Yf7TK1nY5FnrGlLv4zPYU6XOVQJJpmJZMx5Sg=; b=UORVCnBxuXu/bVhBWNs42
        E+j2XgXPcocFh2pRIIlxEVZywRohr5h41PtWsGATkf5mtkoZNu/UVfJyzcke+yhw
        mEKeXaKmX8dJWUcZOc4ePyndyEDi0wRRKSLRAhyuxXf1VXMjT+U/I5KS+gz5sqCQ
        B/Clnaq5fScQjQyheL/RP4=
Received: from localhost.localdomain (unknown [122.96.44.138])
        by smtp4 (Coremail) with SMTP id HNxpCgDH8VsW4+leg8edAw--.16498S2;
        Wed, 17 Jun 2020 17:32:07 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 0/6] Make fstests support new behavior of DAX
Date:   Wed, 17 Jun 2020 17:31:58 +0800
Message-Id: <20200617093204.20838-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH8VsW4+leg8edAw--.16498S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xr4rJF17ury5Jr4UCr1Dtrb_yoW8Jry5pa
        y0kryfKF1xJw1xZrW3GwnFgas8KFs7Cr47Zr17X34IqF1rXa45Krn2qr1xJryrWry8Wr4Y
        v3WkKFyF9FsrJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFsjUUUUUU=
X-Originating-IP: [122.96.44.138]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbBEBhGXlUMR5af1gAAsR
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

The new behavior of DAX on xfs/ext4 has been merged into main kernel
tree/ext4-dax branch so it is time for fstests to support new behavior
of DAX.

References:
https://lkml.org/lkml/2019/10/20/96
https://lkml.org/lkml/2020/5/28/949

Xiao Yang (6):
  common/rc: Introduce new helpers for DAX mount options and
    FS_XFLAG_DAX
  fstests: Use _require_scratch_dax_mountopt() and
    _require_scratch_dax_iflag()
  common/rc: Remove unused _require_scratch_dax()
  generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
    roughly
  generic/413, xfs/260: Improve format operation for PMD fault testing
  xfs/260: Move xfs/260 to generic

 common/rc                      | 57 +++++++++++++++++++++++++++++-----
 tests/ext4/030                 |  2 +-
 tests/ext4/031                 |  4 +--
 tests/generic/223              |  1 -
 tests/generic/413              | 12 ++-----
 tests/generic/462              |  2 +-
 tests/{xfs/260 => generic/602} | 12 +++----
 tests/generic/602.out          |  2 ++
 tests/generic/group            |  1 +
 tests/xfs/260.out              |  2 --
 tests/xfs/group                |  1 -
 11 files changed, 65 insertions(+), 31 deletions(-)
 rename tests/{xfs/260 => generic/602} (93%)
 create mode 100644 tests/generic/602.out
 delete mode 100644 tests/xfs/260.out

-- 
2.21.0

