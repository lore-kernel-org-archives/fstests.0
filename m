Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60735C636D3
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Feb 2023 18:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjBGS2G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjBGS2F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Feb 2023 13:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11640C4
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675794423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9ojeXxC6P2gGayJYHiJl2hK0smZodxyGRrXU6MtMqI=;
        b=I08hkbHqepT8Iu2eV9Rl//d54vatu2hQXqoZcSxLp6bWw5xW6geZphn/+IO2RdGf5s8D/h
        uCAs+jJFXSoI1Gz1gu+y8KNJrKpv1s+4/yUa/aVvQgAvpwCRlRQRBqHq5j3SYWnL5GZOvL
        uZHMlF7WXcmmH8VxGBRcZu0155kLdDg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-Z4zVBdqFM4m9krFuDZaSdQ-1; Tue, 07 Feb 2023 13:27:01 -0500
X-MC-Unique: Z4zVBdqFM4m9krFuDZaSdQ-1
Received: by mail-pf1-f197.google.com with SMTP id dc6-20020a056a0035c600b005a7f1614c18so846045pfb.4
        for <fstests@vger.kernel.org>; Tue, 07 Feb 2023 10:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9ojeXxC6P2gGayJYHiJl2hK0smZodxyGRrXU6MtMqI=;
        b=4pNeYYIGmjBu7UIllNfG/NZdOHFv7IIUDtXFhHula2M9CzZGvhgY0xohRoJr0oFo5a
         LnxOGuJ4zR4afQ2kR84tAJwe745zCLpeMdY7GtMcbMbUxp/LFn0Ra7WpJlxqIOLHdPp1
         0roZKXbcxM4Fk9fNIKEdogXtM7MD1u65bWhxHR1xfZxGFrC2JRvyGOCOVh3LH1V5Eo1a
         R7TIgqWMGMfQmwFcRCkmkVREgdfAJa/YTPrRvCaGknnua04G55WQ+//eMjo1xJRdaL9L
         lzwupB4UcMi18pNbLoPFZh0z1LuA4GtHXGw7FX8qtQHQfjcmVJXbEWfzI+zqFvQaVT2d
         g6PQ==
X-Gm-Message-State: AO0yUKVjBBvOBChXvSZ7hb+PbgT3CsUF2LFXfIYmd6Gz9w4n644KyQtZ
        QOMu1t83MGRW5PIKPd/AQ6ju3J6HvjJksdMwexEuqWpxhUyJ3RvnKXX3h39ev/FGggz1C8Gxiqs
        Ifo8tX7P5LP4weiwTLQ==
X-Received: by 2002:a17:902:c40f:b0:196:e8e:cd28 with SMTP id k15-20020a170902c40f00b001960e8ecd28mr4152518plk.15.1675794420526;
        Tue, 07 Feb 2023 10:27:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/AFfjtjTdkkenNEMZorwNt2oVHOZwrp6+a3i0DrttOmpQf67XdNIxjtioPEdBa6NxtczXKmQ==
X-Received: by 2002:a17:902:c40f:b0:196:e8e:cd28 with SMTP id k15-20020a170902c40f00b001960e8ecd28mr4152499plk.15.1675794420175;
        Tue, 07 Feb 2023 10:27:00 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902868900b0019460ac7c6asm9102068plo.283.2023.02.07.10.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:26:59 -0800 (PST)
Date:   Wed, 8 Feb 2023 02:26:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20230207182656.ekjt2lhbid6xf2cs@zlang-mailbox>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kzxKnYf8CLj49v@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 11:35:16AM -0500, Theodore Ts'o wrote:
> On Mon, Nov 07, 2022 at 10:02:36AM +0800, Zorro Lang wrote:
> > I think it doesn't make sense to use $FSX_AVOID in `fsx --replay-ops` cases.
> > Due to generally the operations which a cases would like to replay are exact
> > steps to reproduce to a known bug. If we skip some operations (e.g. -F), it
> > doesn't make sense for this reproducer.
> > 
> > The recommended way for this kind of cases is making sure current fs/system
> > support the operations will be run by fsx, especially those features are not
> > common on different fs/system....
> >
> > So it uses below _require_* helpers to make sure these operations are supported,
> > before testing:
> > 
> >   _require_xfs_io_command "falloc"
> >   _require_xfs_io_command "falloc" "-k"
> >   _require_xfs_io_command "fzero"
> >   _require_xfs_io_command "fcollapse"
> > 
> > That's my point, hope I didn't misunderstand what you said :)
> 
> No, you didn't understand me.  :-)
> 
> For context, I have an out of tree patch (see attached), which I had
> tried upstreaming a while back, but it got rejected, so I've continued
> to keep it in my personal tree.  The basic idea is sometimes you might
> want to suppress a test even *though* _require_xfs_io_command seems to
> indicate that operation was supported.
> 
> This might either be because the test didn't know about ext4
> bigalloc's cluster alignment requirements, or because a particular
> operation might just be *buggy* and being able to run tests as if a
> particular command wasn't supported was useful.
> 
> It was rejected because the claim was that you could just exclude by
> group instead (e.g., "punch", "collapse") but I didn't trust that the
> group list would be kept up to date, so I never really agreed with
> that line of reasoning.  These days, given that group declaration are
> kept in the test script, it's much less likely to happen, but I've
> kept the patch in my tree because it's occasionally useful.
> 
> At this point, it's admittedly pretty rarely needed since ext4's
> collapse and insert range commands are pretty solid modulo tests not
> understanding cluster alignment, but still, it's not much effort for
> me to keep carrying the patch and I don't expect it will ever get
> upstreamed.
> 
> 					- Ted
> 
> commit c9d25475a94d5e53d7f18d247a17088999522862
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Sat Oct 17 14:39:26 2015 -0400
> 
>     common: introduce XFS_IO_AVOID env var

Hi Ted,

fstests has merged below change 2 month ago:
  [PATCH] fstests: update group name according to xfs_io command requirement
  https://lore.kernel.org/fstests/20221108183242.3362013-1-zlang@kernel.org/

So I'd like to check if it helps for the problem you described above?
If not, I think we can think about the patch you metioned above.

Thanks,
Zorro

>     
>     Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
>     using various advanced file system features such as "fpunch"
>     "fcollapse", "finsert", or "zero".  Tests that require an xfs_io
>     command which is included in the space-separated list found in the
>     XFS_IO_AVOID environment variable will be skipped using _notrun.
>     
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/README b/README
> index 4c4f22f85..42baff07b 100644
> --- a/README
> +++ b/README
> @@ -245,6 +245,10 @@ Misc:
>     this option is supported for all filesystems currently only -overlay is
>     expected to run without issues. For other filesystems additional patches
>     and fixes to the test suite might be needed.
> + - setenv XFS_IO_AVOID, which may contain a list of space separated
> +   xfs_io commands which will be avoided in case you want to exclude
> +   tests that require the use of certain file system operations such
> +   as "fpunch", "fcollapse", "finsert", or "zero".
>  
>  ______________________
>  USING THE FSQA SUITE
> diff --git a/common/rc b/common/rc
> index eb67e0cdc..d1c07a4d0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2485,6 +2485,11 @@ _require_xfs_io_command()
>  	local opts=""
>  	local attr_info=""
>  
> +	if echo "$XFS_IO_AVOID" | grep -wq -- "$command"
> +	then
> +		_notrun "Avoiding xfs_io $command"
> +	fi
> +
>  	local testfile=$TEST_DIR/$$.xfs_io
>  	local testio
>  	case $command in
> 

