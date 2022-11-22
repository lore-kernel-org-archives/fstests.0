Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88685C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Nov 2022 12:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiKVMwu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Nov 2022 07:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiKVMwr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Nov 2022 07:52:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064AE8E
        for <fstests@vger.kernel.org>; Tue, 22 Nov 2022 04:52:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58479220C7;
        Tue, 22 Nov 2022 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669121562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7xwriU18XHuVrM4t1Z0J1z7CvG3pqewzAH+iZmduoPo=;
        b=aiEJVYPbfP1I9vta5By+qrahruUl8xmwr1eKo1FKDJldRJns9TLEzyDQ5+cTuXkM+hiUux
        N++nFQtw0z9nSsmfC2yp2iJWABhE/2x9i9wlJkarGe7RpzfNc4nwaP+DY8fcJpKTDNziPr
        6lfkykmQ0ZmlWUKnPCKfkJUe9zgibnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669121562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7xwriU18XHuVrM4t1Z0J1z7CvG3pqewzAH+iZmduoPo=;
        b=D/aD7kZmElCUqm4agdIenuWK2hLWz+RAtXnfemA2B6PlGHPXo2SytGHRti/R+ri+bwE3nT
        V9SxJVYP0M46eQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BE6713B01;
        Tue, 22 Nov 2022 12:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LiGbDhrGfGO1NwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 22 Nov 2022 12:52:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 17CAEA070E; Tue, 22 Nov 2022 13:52:41 +0100 (CET)
Date:   Tue, 22 Nov 2022 13:52:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Filipe Manana <fdmanana@kernel.org>, Jan Kara <jack@suse.cz>,
        fstests@vger.kernel.org
Subject: Re: Test generic/614
Message-ID: <20221122125241.oz5wgbo55c6vdmuv@quack3>
References: <20221121123636.ltwwxgoom5bd4eyd@quack3>
 <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
 <Y3usnwK3MFba2kEw@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3usnwK3MFba2kEw@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon 21-11-22 08:51:43, Darrick J. Wong wrote:
> On Mon, Nov 21, 2022 at 01:32:22PM +0000, Filipe Manana wrote:
> > On Mon, Nov 21, 2022 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello Filipe!
> > 
> > Hi Jan!
> > 
> > >
> > > I have noticed test generic/614 is failing on ext2. The test creates sparse
> > > file, maps it, and writes data to it through mmap. Then it checks i_blocks
> > > has increased. However for ext2 (and other trivial filesystems supporting
> > > sparse files but not implementing delayed allocation) this is bound to fail
> > > because i_block gets incremented only during page writeback.
> > >
> > > So would your btrfs test make sense even if we called fsync(2) before
> > > checking stat(2) results?
> > 
> > Calling fsync before calling stat would defeat the purpose of the test.
> > I.e. the test would pass both with and without the btrfs fix.
> > 
> > So maybe adding the following to the test:
> > 
> > _supported_fs ^ext2
> > 
> > And listing all other filesystems not supporting delayed allocation?
> > 
> > Or adding a _require_delayed_allocation() helper to make it _notrun().
> 
> _require_scratch_delalloc() ?

Yeah, after some experimentation I think I can even sensibly detect
delalloc using filefrag(1) (xfs_io's fiemap command always syncs file
before doing fiemap). I'll give it a shot.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
