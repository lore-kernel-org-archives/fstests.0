Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB53C001DF
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Jul 2023 11:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGaL22 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGaL22 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Jul 2023 07:28:28 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B749BF
        for <fstests@vger.kernel.org>; Mon, 31 Jul 2023 04:28:26 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id D213D60035;
        Mon, 31 Jul 2023 14:28:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MSOJdagWl0U0-Jk4OWV8r;
        Mon, 31 Jul 2023 14:28:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690802903;
        bh=lx6Sn6/hF3SJXHSGqATT5I/BBvY8mKajLwTLMCViuWI=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=RkYbgUFbAcDyDsfvOXazUGtQbNPKOOmgDIbrXGY3Bo5lMRWxhzDfNEVO2b2WGX7Cl
         45BRP2xQ24M65pZ7HGm7Q/Papu2nwAg0HNAJ/u52WuzFxa1nVN4dcfcOWWKlsYmmSG
         X3O9BgaWJ7Pz3fxhNGpDKsD6KbyBnsWwX+eJkJfo=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Murphy Zhou <xzhou@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 0/2] t_ofd_locks: ipc semaphore fixes
Date:   Mon, 31 Jul 2023 16:28:05 +0500
Message-Id: <20230731112807.1463846-1-stsp2@yandex.ru>
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

