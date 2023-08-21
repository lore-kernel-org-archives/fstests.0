Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10013EE4996
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Aug 2023 05:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjHUFjg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Aug 2023 01:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjHUFjg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Aug 2023 01:39:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86691A6
        for <fstests@vger.kernel.org>; Sun, 20 Aug 2023 22:39:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a40d8557eso496782b3a.1
        for <fstests@vger.kernel.org>; Sun, 20 Aug 2023 22:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1692596374; x=1693201174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PrNDlExWsXp7IbDtcKP6hyuoUlO8+tTokwRt3LzZyEM=;
        b=BpUJ32BCb8pWxvzvUkkZ/LAzxrvYKBfSGd+Lpw4zVOQnLQzKkN6HdVC/AFQwLX6MRJ
         H34KRHEsWU/SBRg+A4SPPFBjmAQtJ+1FtxnyaF3x2JUf0dZAEuNM5FOMupEHIkRpTjBf
         W16NqjBw7iuvdX2hNtXeveIdwGgNfYDZzXJrQqUc2MM8vJZZs8+d1aIiA8eUvlWrpA5Q
         slNKLfVptcENVg3HmVknKO2pRE5Wpomy55FMk4im9bNK/qKLZdou6LEmZO5F2MrhY1Es
         yYQwDtVxyFM4B6YGscsZb7niBp8z/OKSqTSxs8CxHq8bMaifALvWMA8zPsVv1+9oF8SD
         i1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692596374; x=1693201174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrNDlExWsXp7IbDtcKP6hyuoUlO8+tTokwRt3LzZyEM=;
        b=Hkuo+lF8Q2LfOzhtDzknzRu3Eu1SHCwwczyUKDsCDn+3xm25jwsZndnn1crzoUj+p+
         Mysf+nHsC2RcTQ0GJLBqGj7ufPIoHKoNsLkI8ftT7gaZRS1YHl182v8h52J1AzJSq7tC
         XmsAKnGQPaY0uvouArOEtScye613g896E6kBEQxKCTIK6flQmcjbl6pHAKGO3XWN4t9r
         YuuJ3s8rR744EQaiRM0yhRXtmaDaWpfvGctWdmVKbT80/8FcI6WZgCup77/4q03A75ta
         UsnvTMExVv8Q4XmiIp3R9tFCuEnLJe8lYVnU6TGXkFYZ5DU5sMfSOU3QLRiFzubIkgl1
         4HZQ==
X-Gm-Message-State: AOJu0Yxdxx+2z9j8fZ6qxpzIKMX4UgIHVvDj0FG1F82mIG//5TjIjJVO
        vKPmJJnL09hVjuTyMI7OiODVCg==
X-Google-Smtp-Source: AGHT+IE2ri8l4vyDD0Tyz2JDje2zNABuG19WzrsCwt7PyZkoheT0bSefz23HXMDljNz2UncqWYDfKw==
X-Received: by 2002:a05:6a20:8411:b0:13e:b6b0:72a2 with SMTP id c17-20020a056a20841100b0013eb6b072a2mr9776809pzd.6.1692596373967;
        Sun, 20 Aug 2023 22:39:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id g7-20020a62e307000000b0068a0b8e4d5bsm3250088pfh.21.2023.08.20.22.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 22:39:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qXxdS-004SHU-22;
        Mon, 21 Aug 2023 15:39:30 +1000
Date:   Mon, 21 Aug 2023 15:39:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>, "shr@fb.com" <shr@fb.com>
Subject: Re: [PATCH] generic/471: Remove this broken case
Message-ID: <ZOL4kmQ/2ZLEzvmI@dread.disaster.area>
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAL3q7H7C0mE9tBaipdYPYOCgBVYMTVKQ8=f90khTckt1CbBF4A@mail.gmail.com>
 <9eadebb8-1bc7-1c19-ad3d-04b31271f8dc@fujitsu.com>
 <20230818124325.vxod6jkdzirdeaak@zlang-mailbox>
 <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 19, 2023 at 05:25:35PM +0100, Filipe Manana wrote:
> On Fri, Aug 18, 2023 at 1:43 PM Zorro Lang <zlang@redhat.com> wrote:
> > On Wed, Aug 16, 2023 at 02:58:10PM +0000, Yang Xu (Fujitsu) wrote:
> > > I think the url that Jens mention should be this[1] when he reviewed
> > > Stefan V7 patch for "io-uring/xfs: support async buffered writes".
> > >
> > > [1]https://lkml.kernel.org/linux-fsdevel/ca60a7dc-b16d-d8ce-f56c-547b449da8c9@kernel.dk/
> >
> > Hi Filipe,
> >
> > Does above explanation make sense to you?
> 
> Not completely.
> 
> It justifies that the test's assumptions are not necessarily correct,
> that I understood and it's reasonable.
> 
> However I don't see, neither in that thread nor in this patch's
> changelog, why the test started to fail (on xfs, it still passes on
> btrfs and ext4) after adding support for async buffered IO writes to
> xfs and iomap - as all the writes done by the test are using direct
> IO.

We changed how timestamps are updated so that they are aware of
IOCB_NOWAIT. If the IOCB_NOWIAT DIO write now needs to update the
inode timestamps, it will return -EAGAIN instead of doing
potentially blocking operations that require IO to complete (i.e.
taking a transaction reservation).

Hence the first time we go to do a DIO read an inode, it's going to
do an atime update, which now occurrs from an IOCB_NOWAIT context
and we return -EAGAIN....

Yes, we added non-blocking timestamp updates as part of the async
buffered write support, but this was a general XFS IO path change of
behaviour to address a potential blocking point in *all* IOCB_NOWAIT
reads and writes, buffered or direct.

> At least the changelog should point to that thread, and not the one it
> currently refers to because it doesn't provide any useful information.
> For completeness it should also justify why the async buffered write
> support broke the test, as it points out the test fails after those 2
> commits for buffered write support, yet there are no buffered writes
> performed by the test.

async buffered writes didn't break the test. The addition of
nonblocking timestamp updates in XFS is what causes the test to now
fail.

Indeed, we may change this XFS behaviour again some day - if we can
guarantee that we can get a transaciton reservation without blocking
then we -could- allow the timestamp update to run in IOCB_NOWAIT
context. Doing this would then mean the test might randomly fail,
depending on whether the timestamp update can be done without
blocking or not....

Put simply, the test is not validating that RWF_NOWAIT is behaving
correctly - it just was a simple operation that kinda exercised
RWF_NOWAIT semantics when we had no other way to test this code. It
has outlived it's original purpose, so it should be removed...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
