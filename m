Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30951C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Nov 2022 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiKUQSx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Nov 2022 11:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiKUQSw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Nov 2022 11:18:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C2C68A9
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 08:18:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42D3F21BC7;
        Mon, 21 Nov 2022 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669047530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+JOuIMLMmr6n79D0lCp6+72tbfioV218sJkdEmjmifA=;
        b=HE1lQdpmzkkCXnk5sPimhr7Sw/yQvadVBuBpON3ftxacwBbCNKe5xkDWQQM6Z1Fc7/VgMn
        jX0z0ni/0QXfcv/7d3MqC3CwnuDwVDy3z9wBu6at/jRtScYh8e2rs++k0hL+68sqKNf3eZ
        bPOeO5HYUzKW+mE7tqa44J/KWYgpIIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669047530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+JOuIMLMmr6n79D0lCp6+72tbfioV218sJkdEmjmifA=;
        b=h4bp1nzmfhjIFkOJ4+aolKyFUlhYj2Y3tQ4aZqhNF/8srsQmdhRe/kVEwG9eFG4DpoE0Bc
        aE4e8TDqq+cxesBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 330D91377F;
        Mon, 21 Nov 2022 16:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xUJxDOqke2MOXQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 16:18:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A2F59A070A; Mon, 21 Nov 2022 17:18:49 +0100 (CET)
Date:   Mon, 21 Nov 2022 17:18:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: Test generic/614
Message-ID: <20221121161849.6cq6sjyts2pajv5t@quack3>
References: <20221121123636.ltwwxgoom5bd4eyd@quack3>
 <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon 21-11-22 13:32:22, Filipe Manana wrote:
> On Mon, Nov 21, 2022 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello Filipe!
> 
> Hi Jan!
> 
> >
> > I have noticed test generic/614 is failing on ext2. The test creates sparse
> > file, maps it, and writes data to it through mmap. Then it checks i_blocks
> > has increased. However for ext2 (and other trivial filesystems supporting
> > sparse files but not implementing delayed allocation) this is bound to fail
> > because i_block gets incremented only during page writeback.
> >
> > So would your btrfs test make sense even if we called fsync(2) before
> > checking stat(2) results?
> 
> Calling fsync before calling stat would defeat the purpose of the test.
> I.e. the test would pass both with and without the btrfs fix.
> 
> So maybe adding the following to the test:
> 
> _supported_fs ^ext2
> 
> And listing all other filesystems not supporting delayed allocation?

Yeah, probably something like this. In fact, it is a filesystem bug that we
don't reserve space for blocks written through mmap but one that is
basically by design and difficult to fix. I'll think how to best avoid this
failure.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
