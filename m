Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A7C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 18:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357543AbiELS3Q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357524AbiELS3P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 14:29:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1926195A
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 11:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6B79B82799
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 18:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F19C385B8;
        Thu, 12 May 2022 18:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652380152;
        bh=Tz2UwsY0E0+fgez0IhU4l1HsHuhlKC5yGVtAB4qb4bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8WWDXB9hyhMf4HyQqjqKYPpZmEDoKW/OwNT2BFDlbFCwwRkLSceeRVTLvKji6LKW
         Y1TUucm2tl5FHaDP14g83xtreNwNxHUv6bLxJiAJEW5og1SvxVby9IzJMO8i6+Aqin
         mWj3TudGWcU39BtZBQ/edXGpHz4XHd0yAoLP37blEslYlSmjOz1hp4USPLEYqtBRhJ
         YNhufx1tcdCd5JiqXllYb9R7iJ/EVT0QqFwEn9nlRGAf+lwBaplIUCLLXCtpwvQu39
         hxz9g7ABc1PFeHDKyCDYkqOEr8/NRkD8vr/vfCefq28J2+QKyU8elhWlHqaGswlKtQ
         60gsvWYX7PVsA==
Date:   Fri, 13 May 2022 02:29:07 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/overlay: source base fs specific common file
Message-ID: <20220512182907.mikejx7u4bas5kwj@zlang-mailbox>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
        fstests <fstests@vger.kernel.org>
References: <20220512175603.2833164-1-zlang@kernel.org>
 <CAOQ4uxjW=8PvV8ANnCz-7+=DFgUjyd-7N73ZMhEW+92wpLgHNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjW=8PvV8ANnCz-7+=DFgUjyd-7N73ZMhEW+92wpLgHNg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 12, 2022 at 09:11:34PM +0300, Amir Goldstein wrote:
> On Thu, May 12, 2022 at 8:56 PM Zorro Lang <zlang@kernel.org> wrote:
> >
> > When tests overlayfs, sometimes we need the underlying fs specific
> > helpers, e.g. common/rc has:
> >   _filesystem_timestamp_range $OVL_BASE_TEST_DEV $OVL_BASE_FSTYP
> >
> > So when we source common/overlay, better to source then OVL_BASE_FSTYP
> > too.
> >
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >
> > The generic/402 always fails on overlayfs as:
> >
> >   QA output created by 402
> >   ./common/rc: line 2441: _xfs_timestamp_range: command not found
> >   ./common/rc: line 2403: [: syntax error: '-1' unexpected
> >   ./common/rc: line 2408: [: -le: unary operator expected
> >   ./common/rc: line 2441: _xfs_timestamp_range: command not found
> >   0;0 != 1;1
> >   0;0 != 1;1
> >   Silence is golden
> >
> > Due to if FSTYP is overlay, we only source common/overlay file. But we
> > still need the helpers of the underlying filesystem. So I think we need
> > to source the common/$OVL_BASE_FSTYP in common/overlay. What do you think?
> 
> That makes sense.

I haven't given it enough test, hope it won't break something:)

> I don't know why I have never hit this.
> Maybe because I am not running with multi section config or
> because I am runing with kvm-xfstests runner.

Do you test overlay with XFS? For now, I think only xfs+overlay can reproduce
this failure.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 
