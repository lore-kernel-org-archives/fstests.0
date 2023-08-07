Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4FC001DB
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Aug 2023 22:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjHGWcQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Aug 2023 18:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHGWcP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2023 18:32:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E7AB3
        for <fstests@vger.kernel.org>; Mon,  7 Aug 2023 15:32:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43736200C3;
        Mon,  7 Aug 2023 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691447532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8KuHCQKnqtoei4oL9svPDA5OYUFE3S+Yi2mj4NLwFY=;
        b=LL61EuO2h5Vqcy+V2ZYYXkPFIOc0A6TxiFd1/nKaP5ckq84VjXrqM1KWoQgEIgugl5Ga2E
        U7mekrn8qMtHvzVei+tUwzghuAjI6fx+aZhJBcEudykCZn+PQQLK+MuVQlSjrdx3pkR7tP
        9GD2FYdowbqBhptTMAMh3mVrH868oes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691447532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8KuHCQKnqtoei4oL9svPDA5OYUFE3S+Yi2mj4NLwFY=;
        b=De09hoC1SO+Eu/Wvx61lW82ZXT1bHKMKu5uimebSUeZlL6EdjQIbblwqbWdsoA7crZFilx
        uzALHauBrdpLXdCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09FA913487;
        Mon,  7 Aug 2023 22:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SR3nAOxw0WRQAQAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 07 Aug 2023 22:32:12 +0000
Date:   Tue, 8 Aug 2023 00:34:49 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] common/rc: drop '-f' parameter from fsck.exfat
Message-ID: <20230808003449.760508f1@echidna.fritz.box>
In-Reply-To: <20230807174835.moxyuvx4mp47pvky@zlang-mailbox>
References: <20230807112850.9198-1-ddiss@suse.de>
        <20230807174835.moxyuvx4mp47pvky@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for the feedback, Zorro...

On Tue, 8 Aug 2023 01:48:35 +0800, Zorro Lang wrote:

> On Mon, Aug 07, 2023 at 01:28:50PM +0200, David Disseldorp wrote:
> > fsck.exfat doesn't support the '-f' flag, so add a special case to
> > _repair_test_fs().  
> 
> I'm wondering why _repair_scratch_fs() doesn't have the '-f', but the
> _repair_test_fs() has it. Looks like the '-f' option was for extN fs
> originally, it's not a fsck common option, but in fsck.ext4.
> 
> So I think the '-f' might not be a necessary option. As _repair_scratch_fs
> works without it, can we just remove the '-f' from _repair_test_fs()?

The fsck.ext4 usage states:
 -f    Force checking even if filesystem is marked clean

As _repair_test_fs() is only called on _check_test_fs() failure, I
suppose '-f' removal should be fine. Still, to avoid any behavioural
changes I could also just add an explicit ext case with '-f'.

There's also a question of what btrfs should do here, as calling the
"fsck.btrfs" no-op script following btrfs check failure likely
doesn't make much sense.

Cheers, David
