Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A01C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Nov 2021 10:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C6261073
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Nov 2021 10:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhKNKr5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 05:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNKrw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 05:47:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85400C061746
        for <fstests@vger.kernel.org>; Sun, 14 Nov 2021 02:44:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d24so24444671wra.0
        for <fstests@vger.kernel.org>; Sun, 14 Nov 2021 02:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ET9fk68OxEGmbUkDge8VPUErn22zdBW7eojLd3ldcg=;
        b=ispqzR2KChwNbtCuxHqAponFzc+dqYHkgmcuDAEZpcX0DzH1O9anVS9v0ZT2QurOvo
         UnPcjoMYfTBzEyPXIYQOvYI9mpMNjOedPFUSQUCuY23rQJe0b4yg11tEwi8AlLMLdxiM
         hWIv5zm5QZG1u1Z63JkIYbHsLNZvKchkDjfaiCXsb3DvUKENiEXmi4/U6ARpXCIOuOUn
         YYRuzJyACR0TOsvwHJEBMt9/1Fnkds60Ntwz8iWJ50Espng6HdeiUkb7KcM5NEILNUEk
         v68HG2c+xSf6fRk5552/owutYD0UV+kMA4jsCV7GvEF2tIWVDTAu+rXLaqZ8UD+NShpF
         BprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ET9fk68OxEGmbUkDge8VPUErn22zdBW7eojLd3ldcg=;
        b=N4IkNn1bs9baXQdN6UTp9dmIfvlcoTlOzHJnrnqMuhNGzxVe+b7/VCG4yUQtTHi9vB
         Gu9gW7fLdsmyP9U/S1wjkXFWXsDucX6T+AxFDYJmGUh2FUWyAl7eFz8UT8GXHsOOfRQH
         iCHafZhsNY+K6VtwU5BrDckPmiYfWGKji3i4kHH6t/URFhlxVC6cOMocydaG2rRarqOa
         Xa9ez1yjlGwPzF/A4FaeJF2NgxtgRHo7StuVjAaqLabI00/nu4/o0HHyn9hSpXyNTIzl
         8YHjJkr8aI/y3dI/qtDlnwda9eKEgN4hG4/3uJzmsAojZRFtoB+J+0zq0FgOg6i1cVbR
         d32A==
X-Gm-Message-State: AOAM532vQV10vo4ybr9GdqgxPxvfamXOpEyoyFYuuYlpWHdpnaM49uT3
        5Xe6wE1PHOLVnBaBpbf/E8vT8htYM1VC1Q==
X-Google-Smtp-Source: ABdhPJyamEklsZhblid9d+lbPVtsmO8rtvO4FxG2Ade2Fxwu+VpdRkkWXTLSddz4Vf3GtB8cgg/krQ==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr35874005wri.308.1636886697028;
        Sun, 14 Nov 2021 02:44:57 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id h204sm11213913wmh.33.2021.11.14.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 02:44:56 -0800 (PST)
Date:   Sun, 14 Nov 2021 18:44:50 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     zlang@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/648: dmerror must be unmounted
Message-ID: <YZDoorFQIOPxLySO@desktop>
References: <20211024120512.2383377-1-zlang@redhat.com>
 <20211109040913.kq6icdhwdf5mfs7n@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109040913.kq6icdhwdf5mfs7n@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 09, 2021 at 12:09:13PM +0800, Zorro Lang wrote:
> On Sun, Oct 24, 2021 at 08:05:12PM +0800, Zorro Lang wrote:
> > Sometimes g/648 fail to unmount dmerror with this error:
> > 
> >    umount: /mnt/xfstests/scratch: target is busy.
> > 
> > Even worse, it will cause all later test cases fail as:
> > 
> >   mount: bad usage
> >   Try 'mount --help' for more information.
> >   check: failed to mount $SCRATCH_DEV using specified options
> >   Interrupted!
> > 
> > So we shouldn't _fail directly if dmerror_unmount fails, use a while
> > loop to try to unmount it enough times.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> 
> Ping, it's been 2+ weeks passed, any more review points about this?

Sorry, I lost it in my to-review queue.. Applied now.

Thanks,
Eryu
