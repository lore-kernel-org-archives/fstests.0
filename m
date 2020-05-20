Return-Path: <SRS0=XlT/=7D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1496C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50BF20759
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 00:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT98Yu8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgEUAGh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 May 2020 20:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgEUAGh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 May 2020 20:06:37 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BB8C061A0E
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:06:37 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b3so4612558oib.13
        for <fstests@vger.kernel.org>; Wed, 20 May 2020 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqcMHeDSG1gVxY5gr/gS5Vf9+NuBAUZRifvk/ostnqE=;
        b=hT98Yu8/5zFZJJXL60ySf/sK61dsZJn0YGoVT51D27Y5nbveLNi/up92z14ZtdTMBG
         CwW/3nJcGAgH6cj2jh7tldPTyMnl4sK2ljsL3zN33VwnxLSJUTfoyzqWvbzQf6F2I3Yx
         WdmdwCiqH244620JdWS+pDWjTYoPR6NGy4b16o0sA/hysnO0Gf9LxxVdwpRmKpg0lZP6
         EQQMf5AOWM09rOoSLyA6DMqzpKIYcRq4jkhRAIrLxZ1CAMrLa92cYCHfpO/UKqrfGxU0
         F+OycJlsyCxWDujt3CofXpNLyvL8gQdYMPoQUkNeXYSyWWRQzlc3E76i0kEfMMn3iDTX
         h4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqcMHeDSG1gVxY5gr/gS5Vf9+NuBAUZRifvk/ostnqE=;
        b=d5ZkEjzx6QCO65bNQe5a5PN7ZGuPwdCUyIqJ7a7RCaRhESK2b2punZCgEDttzHI/YM
         LQlR60GAC40JxL3a0keQ44KBPOhmH0k4zdpNacDHLcfQ08Tc/JHn/YeO/z2joe7sxsj8
         9Ej4X48IZ6H+4R3umaRRs0fkLSlAdcNmZePnTzbGPFcUEDL1828OMayaitkzLDTC1M9j
         6BXaqXu0FFeow4lp8AOdkVfXbqCGOSKh6pGS+DWcPRwED62vHMhZB5vFp3H4ePFFsCbt
         7eXEx02ewClO85LGEgmarrqeijjSvNgrR2/ZoiP6TvTiCasKPOUQ/eVagL7w0zVvyTeb
         iplQ==
X-Gm-Message-State: AOAM530Mszz4C1VuaXXZfBth+KDkEoOHWRMEqCifCFhyhgVyzdtC3Afk
        oN4Z31AmKL0o9VnLz1w3ENKcaws8VueS
X-Google-Smtp-Source: ABdhPJwVL527qmeyTitXFyzp7bWiSu+g3x3aQYPOpSiKnSn1OKke2IHLGSUqwHEgoIrFI1WHRxT+Lw==
X-Received: by 2002:aca:ab4b:: with SMTP id u72mr5085864oie.112.1590019596068;
        Wed, 20 May 2020 17:06:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-159-174.austin.res.rr.com. [70.114.159.174])
        by smtp.gmail.com with ESMTPSA id f95sm1160022otb.45.2020.05.20.17.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:06:35 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH 0/6] Changes to fssum to support POSIX
Date:   Wed, 20 May 2020 17:16:59 -0400
Message-Id: <cover.1590006879.git.raghavan.arvind@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch series modifies fssum to be able to verify POSIX
fsync/fdatasync guarantees. In particular, it allows single
files/symlinks to be passed as input, which allows us to verify
an fsync on a single file without checking the entire directory.

It also adds an option for non-recursive directory traversal,
which is useful because POSIX fsync doesn't guarantee that all
subdirectories are synced. Finally, it adds a flag that allows
file size to be ignored (currently enabled by default). This is
useful because POSIX fsync of a directory doesn't guarantee that
the data in the children is persisted.

These changes will be followed up with several Crashmonkey [1]
tests which make use of these changes.

[1] https://github.com/utsaslab/crashmonkey

Arvind Raghavan (6):
  src/fssum: Make sum_file_data global
  src/fssum: Refactor recursive traversal
  src/fssum: Add flag -R for non-recursive mode
  src/fssum: Add a flag for including file size in checksum
  src/fssum: Allow single file input
  src/fssum: Fix whitespace in usage

 src/fssum.c | 364 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 213 insertions(+), 151 deletions(-)

-- 
2.20.1

