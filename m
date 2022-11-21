Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1014C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Nov 2022 12:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKUMgo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiKUMgj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Nov 2022 07:36:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6821F2C4
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 04:36:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FDBC1F86C;
        Mon, 21 Nov 2022 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669034197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Otd/TELC710eGRF1q+236TvtTpWTdpYYQLUvNnum7LE=;
        b=Ejx4tj6EpbIh8S/MOz/DYrE1IuGiVLS/nEuexpIKCnNSYauCDSkwIlLC+9YyoAmutdenqw
        yZMGcoyPSZHW3jy/EpbCrrHSsRV6j+ClKoJxdM8PGXBV0G76XFERgOzEZQJfifryx09Xau
        4tRRm/0+giLEgNvyx77USvWMADZSktg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669034197;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Otd/TELC710eGRF1q+236TvtTpWTdpYYQLUvNnum7LE=;
        b=opHtMEV4iaLF+lCtUj6CRznkABzVjakX/YvUrUw4+1fIFwfpmpvj5b6O9FVWmrr83Ikp6D
        0e4mulaqaoK2F3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CDC11377F;
        Mon, 21 Nov 2022 12:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AwEhA9Vwe2OIXAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 12:36:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1C8E1A070A; Mon, 21 Nov 2022 13:36:36 +0100 (CET)
Date:   Mon, 21 Nov 2022 13:36:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Test generic/614
Message-ID: <20221121123636.ltwwxgoom5bd4eyd@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello Filipe!

I have noticed test generic/614 is failing on ext2. The test creates sparse
file, maps it, and writes data to it through mmap. Then it checks i_blocks
has increased. However for ext2 (and other trivial filesystems supporting
sparse files but not implementing delayed allocation) this is bound to fail
because i_block gets incremented only during page writeback.

So would your btrfs test make sense even if we called fsync(2) before
checking stat(2) results?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
