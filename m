Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE7C636CC
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjAaMjM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjAaMjM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:39:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6309B40FE
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:39:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F69D21EDF;
        Tue, 31 Jan 2023 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675168750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f0rSifMJI/p6qjB/AYh5A68NZUYbkbSWifoQusS4YRI=;
        b=s+thRnw1UrwZ3nz3JqPANb5t96JnyPQyho22TUI1UCMjcCpTHy8kP8mnTKqN35cT+chGxZ
        SC7MSk1zQZmnVeB4v/BcVKtE4zvGM2CQhbSrZK2jR6blTFuoY9Mj+ZTzPxzYhBmU0JS/7l
        vshGKYF5sXX0CBlv8nL6De51CWTRQcw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E962C13585;
        Tue, 31 Jan 2023 12:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F9w1N+0L2WPxEAAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 31 Jan 2023 12:39:09 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 0/2] README: Add distro and btrfs testing info
Date:   Tue, 31 Jan 2023 13:38:37 +0100
Message-Id: <20230131123839.16084-1-gniebler@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset adds distro specific setup and btrfs testing info to the README.

Gabriel Niebler (2):
  README: Add section to install required packages on (open)SUSE
  README: Add tiny note concerning required scratch devs for btrfs
    testing

 README | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
2.39.1

