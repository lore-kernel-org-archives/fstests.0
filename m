Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94902C27C7C
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjATPum (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjATPul (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 10:50:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F261CE8B7
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 07:50:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E5893370C;
        Fri, 20 Jan 2023 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674229835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W+wbLpWvdcs7m+9WuhxyNOokzf/ExWcQKhT4l+mGG6s=;
        b=0ObW+/5q24hx8AUrhUyPbFGzGoKt9p8xS7T78CQAPUfc+iB5WgxgyI9V2US/SzvyXhnFbb
        J8V3yjE5vrw7D39Vn5YqZZAhG/v6FEVLFACF6DM3eJb5/aC5z2S/hug2eX8kFBZj+P69QR
        IwRmkiKrPCm3Q5ZdEgJRbyfCBfqF5a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674229835;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W+wbLpWvdcs7m+9WuhxyNOokzf/ExWcQKhT4l+mGG6s=;
        b=HwUEkaZSn8aogeQQkWnCnRMgNUNcr79h8nZCLd16jwVEW+gBrB1Z6fQlzu7Cq6m1lZXvSt
        r1XrFHaZzTLHMGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 715A613251;
        Fri, 20 Jan 2023 15:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zdyoG0u4ymNqEwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 20 Jan 2023 15:50:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CE4D7A06B5; Fri, 20 Jan 2023 16:50:34 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/2] fstests: Fix checking of UDF filesystems
Date:   Fri, 20 Jan 2023 16:50:28 +0100
Message-Id: <20230120154944.25573-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

these two patches fix the usage of udf_test program in _check_udf_filesystem
so that it can reliably check udf filesystems. It provides it proper arguments
and also unmounts the filesystem prior to running the check.

Changes since v1:
* Added Reviewed-by tag
* Accept also --blocksize version of the option

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20230119104618.28701-1-jack@suse.cz # v1
