Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859A7C43217
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Nov 2022 02:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiKHCqN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Nov 2022 21:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKHCqH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Nov 2022 21:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653C2EF48
        for <fstests@vger.kernel.org>; Mon,  7 Nov 2022 18:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667875508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJQtzZvo+8M13aUScJR/SPRR5S4zKby5pMUyPg7u0IE=;
        b=NU7QGDt+oggJwW/7ygmG6D8QKBfPc4EO0VrMBd5G2KPNRxcRR21N2EwntbpCOURkrfbce0
        GVXnGth/+z4QEuahWORkVdi0zPlGjoAQFar71g8ghnHp+/8+0QJtkOv2wvVwuK5Z2IHdvP
        JOtwSNP8YTki2ExdH7uKh++6idZIt7E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-09t7XMemOgeAz7rIgPvTNQ-1; Mon, 07 Nov 2022 21:45:07 -0500
X-MC-Unique: 09t7XMemOgeAz7rIgPvTNQ-1
Received: by mail-pl1-f198.google.com with SMTP id i8-20020a170902c94800b0018712ccd6bbso10193156pla.1
        for <fstests@vger.kernel.org>; Mon, 07 Nov 2022 18:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJQtzZvo+8M13aUScJR/SPRR5S4zKby5pMUyPg7u0IE=;
        b=AYIY7pWWjersuL2JqTVnGTNzZx6N/MVmYeSdHvfXimBTg9VjTPvGz6hwnwJEwCbGyv
         uWfuDI1sYxlc+KtFEzC3e3RqMaKGnOy0tYhx409s3nKC5BcziMTKI3lfWgrYHeeaFT3c
         HH3VVKO7IWOOvj2ipGurToi/ELshOsbd7ymokNHDTqN0S4UnrRAe/dSdJr7zIcsP636X
         2sfy3q3wIc3iaH5xAEItOFdjbSNIaZFzaJa5iMttV7tZEGgttMmqMhug5QyKvPLjRJ0G
         gc4xJsYqEM/U6NMJ2OBhiEDE7BXg1ErRpDBAwLIS2YjH+XzvESByI8FKMQ0D3kmK3ru+
         3nqQ==
X-Gm-Message-State: ANoB5pmEwsL1iO5CzTC7lMBbAGqyXFWmf2NhjzgkrH9W8zt8ABsRxIxV
        wWo6+XWGr2WRxuggGbGIAl6Khv+tA7lPp+nqMhyUhbiACdqi+tpn02xpkTxoKDT/9wWiraB8cWe
        3lS5mHYkefdx44AOC3w==
X-Received: by 2002:a17:902:a401:b0:188:79ba:d542 with SMTP id p1-20020a170902a40100b0018879bad542mr12718560plq.126.1667875506033;
        Mon, 07 Nov 2022 18:45:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6F6rrh+jG7BrnS2sEYhUIFQ9rx950wM7G2GznfnmJMBGXGLc/Ad8KotSKaVGtgHLGfS6dcHw==
X-Received: by 2002:a17:902:a401:b0:188:79ba:d542 with SMTP id p1-20020a170902a40100b0018879bad542mr12718531plq.126.1667875505628;
        Mon, 07 Nov 2022 18:45:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w184-20020a6262c1000000b0056b9ec7e2desm5164203pfb.125.2022.11.07.18.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 18:45:04 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:44:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20221108024455.6lhdrbfoqq53wj4p@zlang-mailbox>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
 <Y2lmFoNQ2ByXzCW0@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2lmFoNQ2ByXzCW0@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 12:09:58PM -0800, Darrick J. Wong wrote:
> On Mon, Nov 07, 2022 at 11:35:16AM -0500, Theodore Ts'o wrote:
> > On Mon, Nov 07, 2022 at 10:02:36AM +0800, Zorro Lang wrote:
> > > I think it doesn't make sense to use $FSX_AVOID in `fsx --replay-ops` cases.
> > > Due to generally the operations which a cases would like to replay are exact
> > > steps to reproduce to a known bug. If we skip some operations (e.g. -F), it
> > > doesn't make sense for this reproducer.
> > > 
> > > The recommended way for this kind of cases is making sure current fs/system
> > > support the operations will be run by fsx, especially those features are not
> > > common on different fs/system....
> > >
> > > So it uses below _require_* helpers to make sure these operations are supported,
> > > before testing:
> > > 
> > >   _require_xfs_io_command "falloc"
> > >   _require_xfs_io_command "falloc" "-k"
> > >   _require_xfs_io_command "fzero"
> > >   _require_xfs_io_command "fcollapse"
> > > 
> > > That's my point, hope I didn't misunderstand what you said :)
> > 
> > No, you didn't understand me.  :-)

Wow, sorry I didn't realize that's a longer story :)

> > 
> > For context, I have an out of tree patch (see attached), which I had
> > tried upstreaming a while back, but it got rejected, so I've continued
> > to keep it in my personal tree.  The basic idea is sometimes you might
> > want to suppress a test even *though* _require_xfs_io_command seems to
> > indicate that operation was supported.
> > 
> > This might either be because the test didn't know about ext4
> > bigalloc's cluster alignment requirements, or because a particular
> > operation might just be *buggy* and being able to run tests as if a
> > particular command wasn't supported was useful.
> > 
> > It was rejected because the claim was that you could just exclude by
> > group instead (e.g., "punch", "collapse") but I didn't trust that the
> > group list would be kept up to date, so I never really agreed with

I agree that most of people don't pay much attention to the group names
when they write a test case. And there're new group names sometimes,
so we always need to supplement some group names later. But the group
name is still helpful, so if you feel some cases missed some groups, please
feel free to tell us :)

> > that line of reasoning.  These days, given that group declaration are
> > kept in the test script, it's much less likely to happen, but I've
> > kept the patch in my tree because it's occasionally useful.
> > 
> > At this point, it's admittedly pretty rarely needed since ext4's
> > collapse and insert range commands are pretty solid modulo tests not
> > understanding cluster alignment, but still, it's not much effort for
> > me to keep carrying the patch and I don't expect it will ever get
> > upstreamed.
> 
> If it's collapse/insert range you're specifically worried about, perhaps
> its time to implement _get_file_block_size for ext4 so that
> _test_congruent_file_oplen can exclude those tests that will get the
> alignment wrong?

Thanks Darrick, I'm thinking about this helper you wrote recently :)
(The real name is _require_congruent_file_oplen in common/rc.)

Hi Ted, is this helpful if you write a _ext4_get_file_block_size (refer to
_xfs_get_file_block_size in common/xfs), then call it in _get_file_block_size
to help _require_congruent_file_oplen to get the correct length which is an
integer multiple of the file's allocation unit size ?

If this's helpful for your first concern [1], please tell me. Then we can talk
about your second concern [2], if it's still your main concern now :)

"This might *[1]* either be because the test didn't know about ext4
 bigalloc's cluster alignment requirements, *[2]* or because a particular
 operation might just be *buggy* and being able to run tests as if a
 particular command wasn't supported was useful."

Thanks,
Zorro

> 
> --D
> 
> > 
> > 					- Ted
> > 
> > commit c9d25475a94d5e53d7f18d247a17088999522862
> > Author: Theodore Ts'o <tytso@mit.edu>
> > Date:   Sat Oct 17 14:39:26 2015 -0400
> > 
> >     common: introduce XFS_IO_AVOID env var
> >     
> >     Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
> >     using various advanced file system features such as "fpunch"
> >     "fcollapse", "finsert", or "zero".  Tests that require an xfs_io
> >     command which is included in the space-separated list found in the
> >     XFS_IO_AVOID environment variable will be skipped using _notrun.
> >     
> >     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > 
> > diff --git a/README b/README
> > index 4c4f22f85..42baff07b 100644
> > --- a/README
> > +++ b/README
> > @@ -245,6 +245,10 @@ Misc:
> >     this option is supported for all filesystems currently only -overlay is
> >     expected to run without issues. For other filesystems additional patches
> >     and fixes to the test suite might be needed.
> > + - setenv XFS_IO_AVOID, which may contain a list of space separated
> > +   xfs_io commands which will be avoided in case you want to exclude
> > +   tests that require the use of certain file system operations such
> > +   as "fpunch", "fcollapse", "finsert", or "zero".
> >  
> >  ______________________
> >  USING THE FSQA SUITE
> > diff --git a/common/rc b/common/rc
> > index eb67e0cdc..d1c07a4d0 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2485,6 +2485,11 @@ _require_xfs_io_command()
> >  	local opts=""
> >  	local attr_info=""
> >  
> > +	if echo "$XFS_IO_AVOID" | grep -wq -- "$command"
> > +	then
> > +		_notrun "Avoiding xfs_io $command"
> > +	fi
> > +
> >  	local testfile=$TEST_DIR/$$.xfs_io
> >  	local testio
> >  	case $command in
> 

