Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED9C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Nov 2022 14:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiKVOLZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiKVOLG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Nov 2022 09:11:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA182ED7E
        for <fstests@vger.kernel.org>; Tue, 22 Nov 2022 06:10:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 998841F899;
        Tue, 22 Nov 2022 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669126220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syMoSlRFmul6CAnDF91gbF1+bttJNKVycTHeZulIpqQ=;
        b=FInOO4+nj4VVnuEPk9eqPIU1gh86xOT6lrD1pyXin7m4G+rLLbneHbZ9xqaHpyrXkaUwCg
        p+pTiEhsK/lSRordzVlBdtDdOWvJaOhTorT1fto1hvvn3r9+JhhJpgvnn4/Ro1Usv7FhnY
        RGL1PW1afbL2jblmHMH5bTDgcXAaNe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669126220;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syMoSlRFmul6CAnDF91gbF1+bttJNKVycTHeZulIpqQ=;
        b=2ovw/ZnbD3DdUE/QuL3BSs4BG5Hp7pEQWL0EpXvoz0bsWyl1SPVi5JhABWqsUiJVjeuW8d
        h+uN21QF19KUQ+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8533813AA1;
        Tue, 22 Nov 2022 14:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o0mbIEzYfGPzZwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 22 Nov 2022 14:10:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C5F36A070E; Tue, 22 Nov 2022 15:10:19 +0100 (CET)
Date:   Tue, 22 Nov 2022 15:10:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Filipe Manana <fdmanana@kernel.org>, Jan Kara <jack@suse.cz>,
        fstests@vger.kernel.org
Subject: Re: Test generic/614
Message-ID: <20221122141019.66a2rjevyfalhx65@quack3>
References: <20221121123636.ltwwxgoom5bd4eyd@quack3>
 <CAL3q7H5fCW9ViD3R8pX9ekLrtF-NpaqaEX+SjmVH09jRsT53dQ@mail.gmail.com>
 <Y3usnwK3MFba2kEw@magnolia>
 <20221122125241.oz5wgbo55c6vdmuv@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122125241.oz5wgbo55c6vdmuv@quack3>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue 22-11-22 13:52:41, Jan Kara wrote:
> On Mon 21-11-22 08:51:43, Darrick J. Wong wrote:
> > On Mon, Nov 21, 2022 at 01:32:22PM +0000, Filipe Manana wrote:
> > > On Mon, Nov 21, 2022 at 12:37 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > Hello Filipe!
> > > 
> > > Hi Jan!
> > > 
> > > >
> > > > I have noticed test generic/614 is failing on ext2. The test creates sparse
> > > > file, maps it, and writes data to it through mmap. Then it checks i_blocks
> > > > has increased. However for ext2 (and other trivial filesystems supporting
> > > > sparse files but not implementing delayed allocation) this is bound to fail
> > > > because i_block gets incremented only during page writeback.
> > > >
> > > > So would your btrfs test make sense even if we called fsync(2) before
> > > > checking stat(2) results?
> > > 
> > > Calling fsync before calling stat would defeat the purpose of the test.
> > > I.e. the test would pass both with and without the btrfs fix.
> > > 
> > > So maybe adding the following to the test:
> > > 
> > > _supported_fs ^ext2
> > > 
> > > And listing all other filesystems not supporting delayed allocation?
> > > 
> > > Or adding a _require_delayed_allocation() helper to make it _notrun().
> > 
> > _require_scratch_delalloc() ?
> 
> Yeah, after some experimentation I think I can even sensibly detect
> delalloc using filefrag(1) (xfs_io's fiemap command always syncs file
> before doing fiemap). I'll give it a shot.

Aha, _require_scratch_delalloc already exists ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
