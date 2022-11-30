Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6240C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Nov 2022 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK3Qyj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiK3Qyj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Nov 2022 11:54:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A0776173
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2022 08:54:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2A9A21AE3;
        Wed, 30 Nov 2022 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669827276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7r2SPLv7WW4HKCMJjZDq2JXkqTgZ14EhLOD97YIBNDk=;
        b=HL8O4ADv8WfcTN3vTi3JfTp1yJj44NYLhhiNDPNvdJAi2gsnlO2+fNmNynbJdfZN2/uawd
        OJcChsn9ZTVekDsCvvpFcUgkbpX1I2PX7qrSAixeFXV0nBxv+iybNqzXwkKmh7jEPNZTEy
        rTLCcOfhqthyGx0nQZAA0adE1L1q6zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669827276;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7r2SPLv7WW4HKCMJjZDq2JXkqTgZ14EhLOD97YIBNDk=;
        b=OeASyk0o9NQajnTUdaeZ/wdc9kWfnjGPeOy/Aojb8szOr3bx4yIHBj87XVDzYr8mJLFydD
        HyUcX6wFmGek8dAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 922E31331F;
        Wed, 30 Nov 2022 16:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G8yqI8yKh2OQSwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:54:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 19AF9A0710; Wed, 30 Nov 2022 17:54:36 +0100 (CET)
Date:   Wed, 30 Nov 2022 17:54:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/273: Limit number of files by available inodes
Message-ID: <20221130165436.3y3riyp3sxkayjcp@quack3>
References: <20221130162239.27153-1-jack@suse.cz>
 <CAL3q7H7O3NVOY0PD25wwuoyU5SWC7AqeGUwkDkY4kc1qz_6ovA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7O3NVOY0PD25wwuoyU5SWC7AqeGUwkDkY4kc1qz_6ovA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed 30-11-22 16:45:23, Filipe Manana wrote:
> On Wed, Nov 30, 2022 at 4:30 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Test generic/273 is failing for ext4 with 1k blocksize because it is
> > creating more files than we have available inodes. Just limit the number
> > of files created to the number of inodes.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  tests/generic/273 | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/generic/273 b/tests/generic/273
> > index f86dae9b8095..80c02d43c7ac 100755
> > --- a/tests/generic/273
> > +++ b/tests/generic/273
> > @@ -50,9 +50,16 @@ _file_create()
> >
> >         cd $SCRATCH_MNT/origin
> >
> > -       _disksize=`$DF_PROG -B 1 $SCRATCH_MNT | tail -1 | $AWK_PROG '{ print $5 }'`
> > +       _disksize=$(_get_available_space $SCRATCH_MNT)
> > +       _free_inodes=$(_get_free_inode $SCRATCH_MNT)
> 
> Jan, this will always return 0 on btrfs, since it has no limits on the
> number of inodes, so it ends up not creating any files in the loop below.
> 
> We could call _require_inode_limits, but that would skip the test on btrfs.
> Can we leave the old calculation if get_free_inode returns 0? (and
> maybe leave a comment that a fs without inode limits returns 0)

OK, makes sense. I'll do that. I was wondering for a while whether
_get_free_inode shouldn't return something more sensible for btrfs but I
guess it's difficult to come up with some universally OK value.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
