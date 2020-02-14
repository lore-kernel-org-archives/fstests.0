Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADF1C2BA83
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7948D2168B
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgBNPSz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:18:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54672 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgBNPSy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 10:18:54 -0500
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j2ck0-00021u-UO
        for fstests@vger.kernel.org; Fri, 14 Feb 2020 15:18:53 +0000
Received: by mail-qt1-f197.google.com with SMTP id d9so6093151qtq.13
        for <fstests@vger.kernel.org>; Fri, 14 Feb 2020 07:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YK+GMLncR0mwK1+Fb3aWlxL3X2QxSVw9dgg5YgGUvc=;
        b=Y7OMEtflK01AJi0uyGDVsi9TRTNDvc36pQSVJHGrwSH5HElDLye+gkblgEsp2XPEbA
         1DUOiyN5nYyS7WDFOJKZP0LFVd6EfSu9bI0oKg5Y2fBxYjFWoLLRC7eS+dHX/gKWj/e/
         oqDmlCDzu1UG/TVwAEo2NvlfpU9VnTcRX5lAuzpPuFDlm1eE5NtJFHLxe8ulYxrgpKsl
         B5xR7NOu8YWIQAYNdifGqWb7ciQpRCy4m1mKuKt5BHhDLuBUXyqM+GbS0gj8PHmL3uYC
         5VDdw0nQJ8xNByCipdWlpaF7D8gSi3d6yFgGkzhP0mVgBNOMGeXcAHQQ+Z+DeV5fcybo
         kWSw==
X-Gm-Message-State: APjAAAWre5x7eHkM1kGWByMO1XOxQM73sD7OVWKpBLpceUNMnnaZJDj4
        djtPcSgcv3rk7KxTazI0YWvU+6mIUsYqOZftwzc91KNCaqumAHUhyIy0Rn0TEnxnfvFWaCy1N2M
        yqM1TxqGA4q+deMpVkzf63009eLbyocC1wMc=
X-Received: by 2002:ac8:4244:: with SMTP id r4mr2919058qtm.169.1581693531990;
        Fri, 14 Feb 2020 07:18:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEsKpupKheqWwMFY9W+ixLjAeNrtM52LDkpAEOC7cStI9dcJtU6dRc+DonWi0LcO4y8RXBjQ==
X-Received: by 2002:ac8:4244:: with SMTP id r4mr2919034qtm.169.1581693531746;
        Fri, 14 Feb 2020 07:18:51 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:a97b:ff5a:85e:d3eb])
        by smtp.gmail.com with ESMTPSA id s22sm3403933qke.19.2020.02.14.07.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:18:51 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     fstests@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 0/5] fstests: overlay: initial support for aufs and
Date:   Fri, 14 Feb 2020 12:18:43 -0300
Message-Id: <20200214151848.8328-1-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset allows the existing support for overlay to be used with
aufs and fuse-overlayfs, so the increase the coverage/test tools that
are available for these filesystems.

Initial numbers on v5.4-based Ubuntu kernel on Ubuntu Eoan/19.10
(fuse-overlay installed from distro package), few tests excluded:

 OVL_FSTYP=aufs
 - Ran: 645 tests
 - Not run: 483 tests
 - Failures: 22 tests

 OVL_FSTYP=fuse.fuse-overlayfs
 - Ran: 530
 - Not run: 395
 - Failures: 29

Thanks to Amir Goldstein for review/improvements/suggestions.

Changes:
 - v2:
   - fix tests/overlay that hardcode the overlay fs type
   - add support to fuse-overlayfs with +3 other patches
 - v1:
   - [PATCH] common/overlay,rc: introduce OVL_ALT_FSTYP for testing aufs

Mauricio Faria de Oliveira (5):
  common/overlay,rc,config: introduce OVL_FSTYP variable and aufs
  tests/overlay: mount: replace overlay hardcode with OVL_FSTYP variable
  common/rc: introduce new helper function _fs_type_dev_dir()
  common/rc: add quirks for fuse-overlayfs device/mount point
  common/overlay: silence some mount messages for fuse-overlayfs

 README.overlay    |  5 ++++
 common/config     |  2 ++
 common/overlay    | 29 +++++++++++++++++++---
 common/rc         | 61 ++++++++++++++++++++++++++++++++++++++++-------
 tests/overlay/011 |  2 +-
 tests/overlay/035 |  2 +-
 tests/overlay/052 |  4 ++--
 tests/overlay/053 |  4 ++--
 tests/overlay/062 |  2 +-
 9 files changed, 92 insertions(+), 19 deletions(-)

-- 
2.20.1

