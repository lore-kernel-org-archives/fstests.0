Return-Path: <SRS0=dxnf=2L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E1C2D0C3
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814AE20665
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 18:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7No9L/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfLUSv7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:51:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40968 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSv6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Dec 2019 13:51:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so12555939wrw.8;
        Sat, 21 Dec 2019 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7xNQF6la3SVSsFUP+4NMm0w2clLT5YbEKiF44Xw2akE=;
        b=u7No9L/dhYX00DzfSWbNDwBuCLGcgVCW2+FlmPRBYK+QM+DXjjj5UOValLH9ZbDKZw
         75xxJvfLkNOBenD/0lpUMeflCjE9OnUemUaut8ycdM1g0U+kT5TLMCDeAJGZq9ZYR5cQ
         P0V3Lh6Y8L49WQDqnHWNqRFBfNUwYal/W5XmUkqoe2qkhYn1S4Bfjfe3Xc1e7Z9m8hD3
         Q4h5HMFgDvDcxSfsudm1sQfx2pOeO28IvL/6vK1QjWDBBN/YKOJocojUACoZZDZg195K
         frHttLcfawPAxuqhrhDu1djZUwI6EA708oVe/5Ik39+mVyF+RerA36dE2yHwD69rInYg
         BkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7xNQF6la3SVSsFUP+4NMm0w2clLT5YbEKiF44Xw2akE=;
        b=OXZuHhcqB1qfJRX20Wkek8ipqSJ8Jvz9UcSAqDjASoZjPAcpYHgf7Vxc7TED5Ibp98
         m1oJd4qV7zc28qvK4+UiCYxIBgvpFsKgUJBMyHGAnL7gDwD+jNv9zj6p93f6opuydJj8
         vw+kzDDZibnPbePnCOONQf1ZBYhAR5Na9YDpB9AS2oRqiFxXk70pYJe75eZVrXIuIAWl
         8I+jm7vvTEQIYR955ueInesuGy9x2Ocj/vHsHC0CK9NDj8jvKLHigVhJqD88jifVz71g
         zX8rbkErgHpl5PoV4NfkdlsCHGr8iMSMCvIN1znhXZxg0CglmEw7xP+2jr6GlLD8kbgP
         EpGA==
X-Gm-Message-State: APjAAAW+yX/M+7rwhpce08G/SHfxJJjr7TpAO5nuaqTTTV3mVv1wMQ19
        rPdhNWU4SjlN+yVVoj7THl4=
X-Google-Smtp-Source: APXvYqxkJCCSXbgxroeGL6Tdgyn8lXvDMNZtG1QD9i+65t+7jNJXBW2D5PJodTNtP2zT8JKd2Nn4uQ==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr20966336wrn.251.1576954316530;
        Sat, 21 Dec 2019 10:51:56 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id o4sm13729832wrx.25.2019.12.21.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 10:51:55 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 0/3] Nested overlay exportfs tests
Date:   Sat, 21 Dec 2019 20:51:46 +0200
Message-Id: <20191221185149.17509-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Eryu,

There is a somewhat convoluted story behind those tests...

At the time when overlay NFS export support was merged (v4.16),
nested overlay NFS export was not supported, because of the requirement
that all layers must have non null s_uuid. I had private patches to add
support for nested overlay NFS export, which I tested with these tests.

In kernel v4.20, commit 9df085f3c9a2 ("ovl: relax requirement for non
null uuid ...") was merged to enable NFS export of overlayfs with lower
squashfs. As a by-product from this change, nested overlay NFS export
is since supported.

v5.5-rc2 includes a fix to the v4.20 commit above ("ovl: fix lookup
failure on multi lower squashfs"). I used these tests to verify that
the change did not break the single lower layer with no uuid case.

v5.5-rc2 also includes a fix to how overlayfs encodes file handles in
memory ("ovl: make sure that real fid is 32bit aligned in memory").
I also use those test to verify this change and they flushed out several
bugs in my initial implementation that the existing overlay/exportfs
test did not catch.

Since those test have proven to be useful in catching bugs not directly
related to the less interesting case of nested overlay NFS export, I
decided it is now prime time for me to post them.

Thanks,
Amir.

Amir Goldstein (3):
  overlay: create the overlay/nested test group
  overlay: test file handles with nested overlay on the same fs
  overlay: test file handles with nested overlay on another fs

 tests/overlay/068     | 304 +++++++++++++++++++++++++++++++++++++++++
 tests/overlay/068.out |  50 +++++++
 tests/overlay/069     | 306 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/069.out |  50 +++++++
 tests/overlay/group   |   6 +-
 5 files changed, 714 insertions(+), 2 deletions(-)
 create mode 100755 tests/overlay/068
 create mode 100644 tests/overlay/068.out
 create mode 100755 tests/overlay/069
 create mode 100644 tests/overlay/069.out

-- 
2.17.1

