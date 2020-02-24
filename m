Return-Path: <SRS0=n5xI=4M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE3BC35669
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 03:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C82206B7
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 03:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mpdesouza.com header.i=@mpdesouza.com header.b="pS3wFvk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBXDeu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:34:50 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:16635 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBXDet (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 22:34:49 -0500
X-Greylist: delayed 1433 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 22:34:49 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id C8CDF400C9C4E
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2020 21:10:55 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 6491jpTzmEfyq6491jw2EA; Sun, 23 Feb 2020 21:10:55 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ero3NyMggozYrVIkVkRv1FRU//V7ZobE8nQa+kvk2M=; b=pS3wFvk3XL7ipp5yOjsQPorFgz
        PYPZPk+4SczyvjfxJ0OKCJN105GuKXs/2vCeZdhEUW/EEArSzG/ytJfMWpmp7cpp8X1+1FfjLoN0C
        S8Ybr1dAia9Su1AZQQ1nFVGQE3+gC1I+u4oWz/GW0qDAPt1pX1GE9+G6q2knnCVg9zYdA8ZFPcCzK
        SA1Gz6ZWL9tFkRJeoLb9lS2BJpwhEH3n6C9VYTZChU/6uBXsbVgGbKR4HgCeXuHx3mYJtyi/2zwM9
        khtqpZPBWGkNg88IQZolm6ytF1PBLyC/Evz46PaXlCQbB4wFCHA1G/jDk0xcV4MXzy9jwus8EjPx9
        fu7pfEMQ==;
Received: from [179.185.222.161] (port=40232 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j6490-0034Sn-H6; Mon, 24 Feb 2020 00:10:54 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, guaneryu@gmail.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [ fstests PATCHv3 0/2] btrfs: Test subvolume delete by id feature
Date:   Mon, 24 Feb 2020 00:13:39 -0300
Message-Id: <20200224031341.27740-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.222.161
X-Source-L: No
X-Exim-ID: 1j6490-0034Sn-H6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.222.161]:40232
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Changes from v2:
* Added Reviewed-by from Nikolay to patch 0001
* Changed awk to $AWK_PROG, suggested by Eryu
* Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
* Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
* Created a local function to delete and list subvolumes, suggested by Eryu

Changes from v1:
* Added some prints printing what is being tested
* The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
  plain integers
* New patch expanding the funtionality of _require_btrfs_command, which now
  check for argument of subcommands

Marcos Paulo de Souza (2):
  common: btrfs: Improve _require_btrfs_command
  btrfs: Test subvolume delete --subvolid feature

 common/btrfs        | 13 ++++++--
 tests/btrfs/203     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out | 14 +++++++++
 tests/btrfs/group   |  1 +
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

-- 
2.25.0

