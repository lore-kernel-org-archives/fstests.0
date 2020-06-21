Return-Path: <SRS0=f9yW=AC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E366C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE5C252EE
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyMSQVo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgFUXOx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgFUXOw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:14:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B8C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:14:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 97so11648534otg.3
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jpa38r1V+NhS5++nbh/o7Xp6Er63TwATKb8ceCTrSMs=;
        b=ZyMSQVo/QuMjXkLgLU39yjh9itMaEE/TS5iw843uf1SQ4oCdUeTdlCspgk9UG+bZVZ
         /eHKTOlLQP5XaXznyxyKKEptlr9gco18MFnR1mZw+r/glJfCH0putrxFVvt5YyK8rZ93
         sQWHkQ8htd+28SU5/JxZsuhHLD+obl4/Ie+A12BdpdFZhBlvYDTu7eb/+OqV2+itJA5A
         bb6LhTrCfpXQUl3PF2NzIJaSnyO03N0ZbWyLYCnqPfKnj4XF+pMZSDYq0XuOpPaz287s
         GKPfGtNxkrfUpLuY/7L1EK8n3XJgfVEIt/I5BPEbwtCkg7ujpKrrGQkYUfnuAFccCMbe
         wZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jpa38r1V+NhS5++nbh/o7Xp6Er63TwATKb8ceCTrSMs=;
        b=FLS2BI5g8qzdEy9s8hXDl5uiX9tKt8CXziLhDt7pA6M14mOLwjh/iEzHfh38a9tluf
         Phtqd7/vYeMYtZDosmYwxKC/sa5WfLLBDdlWQGs+kQqNBMCsxo1MA06PhOORVQdWHdDR
         QF0YWY9lURHHC7T1IlKXIhdJlrrT8JX3emf40qVBKcTdoRui9I05wmnx3I+Eb6h3IcwQ
         26sm/FQ+BWOUTgBMnGvx9rabjU+qYnxgib3Uw6t5VNGq/VkJdyTQiQ2AEByEGluit4Ln
         zZR26YSnGsMEyYvRW9rLnz/coBQueMS53K/TwWjQqtXZthck8IMcqvsP+SKmjraplsNW
         WV8Q==
X-Gm-Message-State: AOAM53045ttr/IbmUj43y58Go+W0GXysuVBmTto6IcPmG8Wrv70JINEb
        itodL9Kr6x1+tdAyP8UIt47MJKcgug==
X-Google-Smtp-Source: ABdhPJzeRCl4jbHsfabregaz10j7W45QRusApRBhlw1acrgbLrC+Ivat77gBwIrfU2zUfZLX9Wtnjg==
X-Received: by 2002:a9d:d57:: with SMTP id 81mr11554428oti.184.1592781291871;
        Sun, 21 Jun 2020 16:14:51 -0700 (PDT)
Received: from localhost.localdomain (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id p18sm2909058oto.11.2020.06.21.16.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:14:51 -0700 (PDT)
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Arvind Raghavan <raghavan.arvind@gmail.com>
Subject: [PATCH v2 0/7] Change fssum to support POSIX
Date:   Sun, 21 Jun 2020 19:14:47 -0400
Message-Id: <cover.1592779555.git.raghavan.arvind@gmail.com>
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

Changes since v1:
- Change readlink to readlinkat to fix bug
- Added helper sum_one function to simplify single file input
- Moved fstat -> fstatat change and both of the former into separate
  commit

Manually verified that all of the tests that use fssum still pass for
each commit:

tests/btrfs/083
tests/btrfs/050
tests/btrfs/007
tests/btrfs/016
tests/btrfs/128
tests/btrfs/040
tests/btrfs/092
tests/btrfs/087
tests/btrfs/039
tests/btrfs/127
tests/btrfs/044
tests/btrfs/144
tests/btrfs/168
tests/btrfs/134
tests/btrfs/045
tests/btrfs/129
tests/btrfs/043
tests/btrfs/145
tests/btrfs/191
tests/btrfs/147
tests/btrfs/030
tests/btrfs/077
tests/btrfs/155
tests/btrfs/133
tests/btrfs/038
tests/btrfs/053
tests/btrfs/189
tests/btrfs/084
tests/btrfs/135
tests/btrfs/200
tests/btrfs/178
tests/btrfs/051
tests/generic/474
tests/generic/547

Arvind Raghavan (7):
  src/fssum: Make sum_file_data global
  src/fssum: Refactoring changes for recursive traversal
  src/fssum: Refactor recursive traversal
  src/fssum: Add flag -R for non-recursive mode
  src/fssum: Add a flag for including file size in checksum
  src/fssum: Allow single file input
  src/fssum: Fix whitespace in usage

 src/fssum.c | 354 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 203 insertions(+), 151 deletions(-)

-- 
2.20.1

