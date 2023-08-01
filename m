Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65648C00528
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Aug 2023 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjHARwj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjHARwe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Aug 2023 13:52:34 -0400
X-Greylist: delayed 109435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 10:52:29 PDT
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CED1BF6
        for <fstests@vger.kernel.org>; Tue,  1 Aug 2023 10:52:28 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ab96:0:640:dd69:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 1204360019;
        Tue,  1 Aug 2023 20:52:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OqVuX9uDSa60-K4F1QRuo;
        Tue, 01 Aug 2023 20:52:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690912345;
        bh=/bFCKG4iHp8E5xTnTMUDn00OxmbI1s9JaTHbXuFzBMw=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=Pq6kx9FUKVqIR/sepoCWF6DGgyd64jD7TEdIR2Htm4lxiTyYo7X3ieptgGrXeiOrb
         L2nuZNWPX9L/4FyN9OmMMuecXE10X0KPolRYvKYD26USjfHBpSJegi16UQCGshydxX
         TvOXn3WswFQ2M2UMJ6u5JAXCFLiuAA4l1qhqSkY4=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Murphy Zhou <xzhou@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 0/2] t_ofd_locks: ipc semaphore fixes
Date:   Tue,  1 Aug 2023 22:52:18 +0500
Message-Id: <20230801175220.1558342-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch set provides 2 semaphore fixes for t_ofd_locks.
First patch fixes the handling of stalled semaphore.
Second patch fixes the init sequence, making sure the lock-setter
process actually waits for the lock-getter to initialize.

Changes in v3: sem is now created by the wrapper script, rather than
by the lock-setter process. This allowed to remove the sem-await loop
from the lock-getter, speeding up the test ~5 times.

CC: fstests@vger.kernel.org
CC: Murphy Zhou <xzhou@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Zorro Lang <zlang@redhat.com>

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

Stas Sergeev (2):
  t_ofd_locks: fix stalled semaphore handling
  t_ofd_locks: fix sem initialization sequence

 src/t_ofd_locks.c | 92 +++++++++++++++++++----------------------------
 tests/generic/478 | 14 +++++---
 2 files changed, 47 insertions(+), 59 deletions(-)

-- 
2.39.2

