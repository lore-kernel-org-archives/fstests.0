Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB7FC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiCCN3P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Mar 2022 08:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiCCN3P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2022 08:29:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261A88B05
        for <fstests@vger.kernel.org>; Thu,  3 Mar 2022 05:28:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 91FE21F38B;
        Thu,  3 Mar 2022 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646314108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5S79lcFj5BBsWIQrY0Dtie6Mlcedekp8KsLEGvm10sg=;
        b=FtOuUrFQ6N5MaaeWPyzF0JNBMb7nJZtEPTnzBlmTsj7gf7X1C5hgVZpDhkzU6jXRqN3cCs
        wNK4FQuK/AUyhgw0wnqXGIJDa2ciA7ep+adnW3wl1KciNQoK8o4XhP8FgWvQqZolDrSY1C
        xPHGzdeE4/EVvhvhfV82Twqvz/zg0lE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6482113C23;
        Thu,  3 Mar 2022 13:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IsfDFnzCIGKHWwAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 03 Mar 2022 13:28:28 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 0/4] README: Fix setup, btrfs and distro info
Date:   Thu,  3 Mar 2022 14:28:00 +0100
Message-Id: <20220303132804.4151-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The README had some incorrect environment setup information in the quick start
section and some outdated info related to btrfs testing.

This patchset fixes that, while also adding some more distro specfic setup info.

Gabriel Niebler (4):
  README: Fix environment setup quick start
  README: Adjust and add btrfs testing information
  README: Add command to install required packages on SUSE
  README: Fix indentation to be consistent

 README | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)
