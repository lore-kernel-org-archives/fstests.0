Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D7C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Feb 2022 01:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiBOBs6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Feb 2022 20:48:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiBOBsz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Feb 2022 20:48:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F213570C
        for <fstests@vger.kernel.org>; Mon, 14 Feb 2022 17:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ADjsUUWF06dg7L3qsMiVuAXx0EC/XkEXQw0xTAqYSiE=; b=em3jJhxdHcPbNmD+07foivP8qc
        1TAqP5sHxwCFIpHcX4M0s3LLZWl81mBlVVWBAjBIb4VCN+Um+jRcDCQcaAAKcL0JI7HJt+7uEI6Z0
        dJFkDemfZWPTGwUFbn6dk8cvhO2maB+czkGN6EIY+IVPfRgeJzfIkQ1p6b15VJioB7n1xFSWGySo/
        CR0ZB5dgq4zg5XZpI/J/NarjFiWnwDjnjKEQJOcyB6+rcWbdE3Teoqbw9ndupSSBmkpNhoCbTYV/t
        0+jcNG9CpSV3c/kKfp0BRhpO1F2Y7e1Rm+49Qtsh2iUHz3lxfcVB/Kvht5VYQNLkMa5yJYxDFWZft
        8XV393Vg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJmxR-00HTRp-Uc; Tue, 15 Feb 2022 01:48:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, johannes.thumshirn@wdc.com
Cc:     a.manzanares@samsung.com, p.raghav@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/3] adjust btrfs/237 uuid heuristics and use AWK_PROG
Date:   Mon, 14 Feb 2022 17:48:42 -0800
Message-Id: <20220215014845.4164719-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This v2 makes the btrs/237 change use $AWK_PROG as
requested by Johannes. But I noticed btrfs tests
don't use this consistently. Let's address that
by being consistent.

Luis Chamberlain (3):
  btrfs/237: adjust uuid heuristics
  common/btrfs: use $AWK_PROG
  tests/btrfs: use $AWK_PROG instead of awk

 common/btrfs    |  6 +++---
 tests/btrfs/001 |  2 +-
 tests/btrfs/003 |  2 +-
 tests/btrfs/006 |  6 +++---
 tests/btrfs/011 |  2 +-
 tests/btrfs/022 | 12 ++++++------
 tests/btrfs/027 |  4 ++--
 tests/btrfs/035 |  4 ++--
 tests/btrfs/085 |  2 +-
 tests/btrfs/090 |  2 +-
 tests/btrfs/124 |  4 ++--
 tests/btrfs/125 |  6 +++---
 tests/btrfs/149 |  8 ++++----
 tests/btrfs/161 |  4 ++--
 tests/btrfs/162 |  6 +++---
 tests/btrfs/163 |  6 +++---
 tests/btrfs/164 |  4 ++--
 tests/btrfs/175 |  2 +-
 tests/btrfs/176 |  6 +++---
 tests/btrfs/181 |  2 +-
 tests/btrfs/184 |  2 +-
 tests/btrfs/185 |  8 ++++----
 tests/btrfs/194 |  4 ++--
 tests/btrfs/197 |  4 ++--
 tests/btrfs/198 |  4 ++--
 tests/btrfs/215 |  4 ++--
 tests/btrfs/216 |  4 ++--
 tests/btrfs/218 |  4 ++--
 tests/btrfs/237 |  9 ++++++++-
 tests/btrfs/254 |  4 ++--
 30 files changed, 72 insertions(+), 65 deletions(-)

-- 
2.34.1

