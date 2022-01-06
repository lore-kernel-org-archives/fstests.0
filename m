Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27243C433F5
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 02:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbiAFCfP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Jan 2022 21:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344824AbiAFCfN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jan 2022 21:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641436513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Y6ec7tc6YZuXAfW6QQgoyFOZoDzPiYpbd5lseRhA/0=;
        b=YaoWMv7Ur9WISpJxgNDIWYZ8sbJE1cv7NIPIgckYelS23BnjTamv8x9wls2Suheab/mLiF
        uoFVi2afNBSsHK3jz3LdNrm/y9MgCP1NG0ILrfSgDFdR/pgW/cyWasJovnpeen2Tb62LLO
        UcAGH+b8uriZvycYz9BMdO5BMN4QEBs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-hJhrq8L0PNCHRngD3R47Ew-1; Wed, 05 Jan 2022 21:35:11 -0500
X-MC-Unique: hJhrq8L0PNCHRngD3R47Ew-1
Received: by mail-pl1-f198.google.com with SMTP id t3-20020a170902bc4300b00149074b1606so458234plz.13
        for <fstests@vger.kernel.org>; Wed, 05 Jan 2022 18:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9Y6ec7tc6YZuXAfW6QQgoyFOZoDzPiYpbd5lseRhA/0=;
        b=rNyX1yG25zJcgzm//2jxOS4oSiilFbE6nj4CxDfRCVM5cxxAJyGGM1yOviujGsnTPF
         f/GfPq3ODvgfts4vFGs0GvITIjTc2OFTcZE6VPgRpvY9i1qgcWnKwmODhA6YGxt64uBg
         oWFYp1lFSXd/ptKGx9R+mgiIqEky6tNLyrw/Tkea8eIgZpJ3+ZlT5Cix5SCvmnaYBliK
         5Qu3hHuw7m7szzDOnzltzrQkeHTvZLl/YIzCzzTUz0bUn9khsY2oMSd+h18vZcjDuqEc
         O09EVSUg0oO5LihkB7u/EssGhiqD2PMq3+56eRGp0qVY3CCsQ/YFA3mZo+R6hSA9Pl4B
         lKWQ==
X-Gm-Message-State: AOAM531DJHq/DSne8nakUEWIYU9AHIWVOgBkVN097xnabLbdNBaZKOrL
        LCCxzgfNiJ2d9BFjUKy1LH1viYDN6doWV+SdmvR+tnJzAnQKbarcqm5HLv7OPnC4W1sN5PszMlf
        ikj76WpWR0Uk/VA+3yQ==
X-Received: by 2002:a17:902:bc4c:b0:149:ed05:3027 with SMTP id t12-20020a170902bc4c00b00149ed053027mr1574784plz.174.1641436510655;
        Wed, 05 Jan 2022 18:35:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk2jZ0XLeQTU8c6nWJu02JeFt7+zVZQhYLaNw5nuVuhFEUXxNky72D+ipciYJDt9y1cHffvg==
X-Received: by 2002:a17:902:bc4c:b0:149:ed05:3027 with SMTP id t12-20020a170902bc4c00b00149ed053027mr1574760plz.174.1641436510324;
        Wed, 05 Jan 2022 18:35:10 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j17sm387009pfu.77.2022.01.05.18.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:35:10 -0800 (PST)
Date:   Thu, 6 Jan 2022 10:35:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl
 directly
Message-ID: <20220106023506.kwpzkqdpv6hozygk@zlang-mailbox>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <Yb9M3aIb9cJGIJaB@desktop>
 <20211220204059.2248577-1-tytso@mit.edu>
 <20220105155743.6knpj4zsbmy62uwj@zlang-mailbox>
 <20220105160619.r66lacgq7b7ucyuk@zlang-mailbox>
 <YdX5csi2qZjS1KOt@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdX5csi2qZjS1KOt@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 05, 2022 at 03:02:58PM -0500, Theodore Ts'o wrote:
> On Thu, Jan 06, 2022 at 12:06:19AM +0800, Zorro Lang wrote:
> > > This patch looks good to me, I just want to ask if we'd better to try to include
> > > ext2fs/ext2fs.h at here? And of course, check it in configure.ac.
> > > The EXT4_IOC_RESIZE_FS looks like defined in ext2fs/ext2_fs.h which comes from
> > > e2fsprogs-devel package. I can't find this definition from kernel-hearders package.
> > > As you're the expert of this part, please correct me if it's wrong :)
> 
> We're not depending on ext2fs/ext2_fs.h and hence the e2fsprogs-devel
> (or libext2fs-dev package if you're using Debian/Ubuntu) anywhere else
> in the xfstests-dev.  It's not like the code points for
> EXT4_IOC_RESIZE_FS are going to change, so we just use constructs
> like:
> 
> #ifndef EXT4_IOC_RESIZE_FS
> #define EXT4_IOC_RESIZE_FS           _IOW('f', 16, __u64)
> #endif
> 
> in xfstests-dev/src/*.c as needed.
> 
> There's no real upside in adding a dependency which makes it harder
> for developers to compile xfstests.  (Trivia note: I created
> xfstests-bld several years ago because back then, Debian didn't
> include some of the internal header files from xfsprogs which xfstests
> needed.)

Thanks for your kindly explanation.

> 
> Cheers,
> 
> 						- Ted
> 

