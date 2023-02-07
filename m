Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFEC636CD
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Feb 2023 12:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjBGM23 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Feb 2023 07:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGM22 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Feb 2023 07:28:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B854EC6
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 04:28:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1290C3F6B3;
        Tue,  7 Feb 2023 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675772906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ge6VVpgXRJLsRrA0LWxBC44psf1qJKlbLE+buhIgkhs=;
        b=jmnZy8VpG1IhskOdy9ruO9VToPY7kcOROqAX50rKNy2k34MyRHd5aJ0uu8E4dLqN/XwlIh
        pf/nIk9kHvzEk4iq3jrbV04pwcyn2QKMmSP+/9GvVVzESum/Cv8UsrLLjt4xTstpre92Ru
        hOUt629rrq4B+244tdHsWNsqUn2vHu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675772906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ge6VVpgXRJLsRrA0LWxBC44psf1qJKlbLE+buhIgkhs=;
        b=xlQ2GGvoLAV8ysUVevXEK5MJn0O+ukrAmjScFi5+ZFcK8CMt9agjTCgtf3wpQYhxXC+1X6
        9BOQ4v0nbE37H0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C442213467;
        Tue,  7 Feb 2023 12:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RoPcL+lD4mNXVwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Feb 2023 12:28:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 84F85A06D5; Tue,  7 Feb 2023 13:28:24 +0100 (CET)
Date:   Tue, 7 Feb 2023 13:28:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH v3 3/3] common: Improve blocksize support for udf
Message-ID: <20230207122824.mmxbbxjwseo2fibu@quack3>
References: <20230131123809.28200-1-jack@suse.cz>
 <20230131124005.14207-3-jack@suse.cz>
 <20230206111235.f2nwx2xmdwjtnv64@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206111235.f2nwx2xmdwjtnv64@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon 06-02-23 19:12:35, Zorro Lang wrote:
> On Tue, Jan 31, 2023 at 01:39:59PM +0100, Jan Kara wrote:
> > Add better support for blocksize selection in _scratch_mkfs_sized
> > (accept another variant of mkfs options, select correct default block
> > size if not specified). Also add blocksize selection support to
> > _scratch_mkfs_blocksized.
> > 
> > For _check_udf_filesystem to keep working when blocksize is not
> > specified in MKFS_OPTIONS, add detection of blocksize from a mounted
> > filesystem.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> This patch looks good to me, thanks for doing this for udf filesystem :)
> 
> It's been long time, no patches from udf list to fstests list. For exmaple,
> The udf/102 missed the _setup_udf_scratchdir() helper (be removed) for long
> time, if you're working on udf testing, you might be interested in it.

So I did some larger UDF kernel changes in this cycle so I also found some
time to do more testing which has shown all the problems. My plan is to run
fstests for UDF more often and slowly reduce the amount of failing tests
(so far I was more or less happy that the basic functionality looked solid
and the kernel didn't crash during whole fstests run ;).

> Anyway, I'll merge this patchset this week.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
