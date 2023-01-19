Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EC0C004D4
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Jan 2023 10:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjASKyW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Jan 2023 05:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjASKyO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Jan 2023 05:54:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AF4A1C0
        for <fstests@vger.kernel.org>; Thu, 19 Jan 2023 02:54:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF42D5CC7A;
        Thu, 19 Jan 2023 10:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674125651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=48FEeJ5dncieQPIQqmEG0uq4RX+eKRdpZUGEVGx09ik=;
        b=W732rdW8XRlKWm51YU8bsutfyfXpkQg/WmqY0hmHn1A9s7pwip/gpcfghLan3EyYF3yDWI
        kx5NlI1bVXhoTcHmjM5vmoT/YR3xGLb9ssE/N5onWRrcS5B9tnHN5lkIau4Um/uiIq01VT
        aEr+kpzXtYEXP5VJsnNTHZjJK9vV8Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674125651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=48FEeJ5dncieQPIQqmEG0uq4RX+eKRdpZUGEVGx09ik=;
        b=VZWnqlMKaVYmcPjgza2wSEXyBGG7KtKrMsz2SviPfgZC8eWpYYcEq1g0AtqWl5wdIFeT+y
        CtEzFqfnlX3nzfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0DAF139ED;
        Thu, 19 Jan 2023 10:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gxnfNlMhyWPkKwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Jan 2023 10:54:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CAE89A06B2; Thu, 19 Jan 2023 11:54:10 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] fstests: Fix checking of UDF filesystems
Date:   Thu, 19 Jan 2023 11:54:01 +0100
Message-Id: <20230119104618.28701-1-jack@suse.cz>
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

								Honza
