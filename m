Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381BC352A1
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Dec 2022 11:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiLFLFv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiLFLFq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Dec 2022 06:05:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917252BC8
        for <fstests@vger.kernel.org>; Tue,  6 Dec 2022 03:05:44 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E5001FE59;
        Tue,  6 Dec 2022 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670324743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPv9/BB7euCdMwIKqpmNe6wxMeVcwFxme84+SVw8yew=;
        b=iLzsYTmYjnMdyjdNxSeBzgpKZQ4CLgBmlgrucjPDsYzN8+Xn9xs1hS2Azy7WR7mmjrzxWK
        R3Nbbkcc5ZXvS2pjkzqqphDVUT48CgJoKMcaX+DhwYJRFB/uo22PvDBp9IZoZRIzzcTb2d
        u8C0OpEItEgJv3HHh36GI+N2Jlpjcuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670324743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPv9/BB7euCdMwIKqpmNe6wxMeVcwFxme84+SVw8yew=;
        b=FCswGJFLPi72cHMipAM9CI2/euyoh2c6yLWxzMvAM1fDUJS+14azBv/g1ztU1B3+iCdjAP
        /xKXQ/NkEF6RF1DQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3BAEE13326;
        Tue,  6 Dec 2022 11:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mN+JDgcij2OpPgAAGKfGzw
        (envelope-from <jack@suse.cz>); Tue, 06 Dec 2022 11:05:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A4988A0725; Tue,  6 Dec 2022 12:05:42 +0100 (CET)
Date:   Tue, 6 Dec 2022 12:05:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Disseldorp <ddiss@suse.de>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/044: Fix failure when mount options are
 incompatible with ext3
Message-ID: <20221206110542.dlpuy2izqzdelswz@quack3>
References: <20221205124144.23770-1-jack@suse.cz>
 <20221206003542.50227091@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206003542.50227091@echidna.fritz.box>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi David!

On Tue 06-12-22 00:35:42, David Disseldorp wrote:
> On Mon,  5 Dec 2022 13:41:44 +0100, Jan Kara wrote:
> > There are some mount options that are incompatible with ext3 filesystem
> > type. If they are used, this test fails because it tries to remount the
> > filesystem as ext3. The test makes sense even without remounting as ext3
> > so just make the test silently skip the remount.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  tests/ext4/044 | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/ext4/044 b/tests/ext4/044
> > index 50de5a40bdc7..96fa70cc0d1e 100755
> > --- a/tests/ext4/044
> > +++ b/tests/ext4/044
> > @@ -53,9 +53,10 @@ _within_tolerance "sec_ctime" $sec_ctime $sec 1 -v
> >  
> >  _scratch_unmount >> $seqres.full 2>&1
> >  
> > -# Test mount to ext3 then mount back to ext4 and check timestamp again
> > -_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
> > -_scratch_unmount >> $seqres.full 2>&1
> > +# Test mount to ext3 then mount back to ext4 and check timestamp again.  We
> > +# ignore if ext3 failed to mount. It can happen because some mount options are
> > +# incompatible with ext3. Still the test makes sense.
> > +_mount -t ext3 `_scratch_mount_options $*` >> $seqres.full 2>&1 && _scratch_unmount >> $seqres.full 2>&1
> >  _scratch_mount
> 
> I suppose this makes sense compared to filtering or dropping all mount
> options.

Yeah, filtering would need constant updating and dropping all mount options
could have some unexpected sideeffects.

> $* should always be empty here, right?

Yeah, likely yes. I've just copied that without thinking too much about it
:).

> Looks fine otherwise...
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
