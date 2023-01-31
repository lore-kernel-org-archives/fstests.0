Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD48C636D7
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAaMkK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjAaMkI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:40:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381559F8
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:40:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF03922871;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675168805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ijstgUb7tcZChMrie3++D9ucZSju2BPg+4dGDNzMglY=;
        b=mTahyrKDn1DtzVLlmSkJvy0j6utIk51hPP7yX1P9a8U0k1fw9GlpdPLlvwmPJsw8rQAKWR
        PObOh4TRxZEfCNwNM7FfOgtmQ/8cOW1Fn0XLuSB12hud/C9cMt+31TVKSVLXwuZTaO0NR/
        7RzLqMLyf+INK6v0EzwJGmgbGluSg/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675168805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ijstgUb7tcZChMrie3++D9ucZSju2BPg+4dGDNzMglY=;
        b=AgEOvWBOL6t8xdrZyXkCk/JSad7bQirks46d3Mx7qPop1dWeJB/5w0hXUQ2mwQwxgkZTYL
        J1f4c7T7oT9L5mBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A270013585;
        Tue, 31 Jan 2023 12:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n4elJyUM2WNrEQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:40:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12598A06D5; Tue, 31 Jan 2023 13:40:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 0/3] fstests: Fix checking of UDF filesystems
Date:   Tue, 31 Jan 2023 13:39:56 +0100
Message-Id: <20230131123809.28200-1-jack@suse.cz>
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

Changes since v2:
* Include another patch adding better blocksize support to _scratch_mkfs_sized
  and _scratch_mkfs_blocksized

Changes since v1:
* Added Reviewed-by tag
* Accept also --blocksize version of the option

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20230119104618.28701-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20230120154944.25573-1-jack@suse.cz # v2
