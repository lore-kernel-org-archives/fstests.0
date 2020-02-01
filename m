Return-Path: <SRS0=RvYx=3V=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B2DC33C9E
	for <linux-fstests@archiver.kernel.org>; Sat,  1 Feb 2020 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFBE2070C
	for <linux-fstests@archiver.kernel.org>; Sat,  1 Feb 2020 09:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/pDJDzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgBAJO4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 1 Feb 2020 04:14:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45494 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBAJO4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 1 Feb 2020 04:14:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so3770261pls.12
        for <fstests@vger.kernel.org>; Sat, 01 Feb 2020 01:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=06seKl+0hh6CxB/28+goGo4yvWAhM6MmOe6Hwc4rOls=;
        b=n/pDJDzJ4PULdTmBola2hbw5FyHQf4jYvKbua+ayKuzEklZyMkOkl52SB07XCxTqSk
         +f0szOiD4+iYCoAUPW9VjF4H/1drGdyYvsOnPx4szyWHkRhvAUEpjmXg0SvgZ3lhVqOT
         habzms4zknrFtM0OCjg4qL6vpHwThlBDMnJjsbpwquKBQI6qp2KPkjLL3WLHP+hYFw4z
         FppTJrBBHJBcZeHni8eG9SZa0Dc50svwfWuDpNoWkPU+MiZRQxYL2uvsCxn8rejBGMWl
         iU1EV5EGdif5IkVUEa1m8dhEGmIGrj/If6cCisVBx9iPspXCddLuOX1LICzareH7MDVu
         zvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06seKl+0hh6CxB/28+goGo4yvWAhM6MmOe6Hwc4rOls=;
        b=ei5tI5ih8c1aBUm6blt/0BSOLKhXIM7scyYtGnw0ne2KP/9XyCIwGw1WcSMLKyhBLG
         ijcNuH3GjDxGRgDZKfchcAr3v0xsLcB3JilGVICkna1fYov8LxdQLy/5jRD8f5kcdS3S
         OWCIMpqwT9RqqjWxeLX+Co6QIwee3JACppYj8JgvKeL7EW43vik7TlfgLrU3k3zq1k4z
         7b6p06jP6hbpopHkTbyzkTThLD42bG+GAtFPCPslkKb1EuO1/mCPlKEUhX1t10VC0bbK
         laJE4wOuKiHMDiEiklD6W8khYJCrKUs8f0NuC/EfDC0Fm/ObIW5RDYZqTqRDsXLRW1e0
         DKYg==
X-Gm-Message-State: APjAAAVvm6fmMmOG7QoUJl/RyKXN+lE4e77bqAKzGAaN19gqOjf5ltzj
        rtksG0y++JGvXOz3Ltjxv7k=
X-Google-Smtp-Source: APXvYqws+fTXfsG6tqaTuDsL7kjbE7EoigAJTsM7W8/0k09XEvgGRIw7PU5rXzppA3C/R2KzySjv/Q==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr14369130plq.79.1580548495502;
        Sat, 01 Feb 2020 01:14:55 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id g9sm13341573pfm.150.2020.02.01.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 01:14:54 -0800 (PST)
Date:   Sat, 1 Feb 2020 17:14:49 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH v3 1/1] generic/402: Make timestamp range check
 conditional
Message-ID: <20200201091447.GD2697@desktop>
References: <CABeXuvoDnwS5Km657iDwgWVL=L3muqqJp51owc0kkNcTFRrEYw@mail.gmail.com>
 <20200119005744.12852-1-deepa.kernel@gmail.com>
 <CAOQ4uxi9RBFYDFm=Gg=9Ct_apL5sTuUwcAJxj4-PxkCJturfig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi9RBFYDFm=Gg=9Ct_apL5sTuUwcAJxj4-PxkCJturfig@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jan 19, 2020 at 11:19:24AM +0200, Amir Goldstein wrote:
> On Sun, Jan 19, 2020 at 2:57 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > Addition of fs-specific timestamp range checking was added
> > in 188d20bcd1eb ("vfs: Add file timestamp range support").
> >
> > Add a check for whether the kernel supports the limits check
> > before running the associated test.
> >
> > Based on an off-list discussion, we use a simpler interim approach
> > until fsinfo syscall would provide fs timestamp limits info.
> > This isn't perfect, but works for filesystems expiring in 2038.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > ---
> 
> Excellent! Thank you.
> 
> Eryu, you may add any of:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Tested-by: Amir Goldstein <amir73il@gmail.com>
> 
> On kernel v5.4, ext2,ext4,xfs,btrfs (default mkfs) still pass.
> On Kernel v5.3, ext2,xfs are notrun for lack of kernel support
> (instead of failing),
> ext4 (256 bytes inodes) still fails
> and btrfs still pass, because bash overflows $(($s64max + 1 )) just the same as
> the kernel...

Thanks a lot for the double checking! And many thanks to Deepa for the
fix!

Thanks,
Eryu
