Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16161C3DA66
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Aug 2023 02:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbjHXCd1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 22:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbjHXCdS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 22:33:18 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CC0E6D
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 19:33:16 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1c4de3b9072so4187191fac.3
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1692844394; x=1693449194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IZNpztUvlHM4rz1LHAZUw7+5Zc3F5/eEVk/5wtiAEG0=;
        b=ZEIkIwEM4KkTxcjE6oU1NKxj1UpNIdixSCSWo6zUEx49wgzPx6BtpzLS5WwmQCIuWi
         7LpdqK/219X+WrqjLx8g9RNK5t3Tz+hkOH32Y22qD4/M3G4sUOBYS2MsN/m1izQUvI+S
         uVT25yKKMXa4w0Q/KMCN0/1muaKZcsyd/eLEO+Ra4O9LtJZbDkNv9Y4Zu3yloW683hbP
         +QLMtDaEdp7bVJvNdmOgub4WAIPnTxxqsT6x4PnFEMPkIisc96cl6aqyr7HTAMjO7PNb
         xfYjL+dpWXrOmAueS6nb/al/qxFOBwifcl/va9wXglEt6oxM/iq1KwzBTaIXKp+N0WOy
         Mj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844394; x=1693449194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZNpztUvlHM4rz1LHAZUw7+5Zc3F5/eEVk/5wtiAEG0=;
        b=CkECoVtYJ/dW3JSCFPfnVj9vpvNo2rah9MW+yjeGUZNUtLRkbNffk+VX9/0aemNjmH
         IRnvenl+EmI9+q3fuPrKidRsPOL5H07Sf7aIMsK8pzOojLM/bmspqCu/kFmO1XoMijiY
         HUoBAVgMuF25owTIqJoiGZv6guKIZ6ZJIxNQ8nqjZXAxOn90UvBqA44T1b2XVJt40MhF
         DxBBGJ8NDrLDHTS3IO++DGb3gOYrhD5Jm7Q4ATdA+7Vj3UOzET71s3+oV+hozuBiozZS
         1rsujTCPwIHNDERCsc5gfEzxGX6vEck7vPHeFVb1XgnlSYv3Jx742x0kC9L82xgzsk/N
         OVZA==
X-Gm-Message-State: AOJu0YyA2NDSwaQnjvqBG8cAKoCwZBkR/t+toyBv9ia3TTuYy1BVI2wk
        knD1AyNn8bZS0qXSyvSZYU1aOA==
X-Google-Smtp-Source: AGHT+IGhepRrMaJro5bvjLFSIGHG/9aUUrgaX/aciBzbV7/iIevf1VPzLPAr0FQ74ZVqJVKb3pqgYg==
X-Received: by 2002:a05:6870:9123:b0:1b7:3fd5:87cd with SMTP id o35-20020a056870912300b001b73fd587cdmr16281135oae.48.1692844394380;
        Wed, 23 Aug 2023 19:33:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001bdf45eb5b6sm11539241plb.284.2023.08.23.19.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 19:33:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qZ09n-005hve-1I;
        Thu, 24 Aug 2023 12:33:11 +1000
Date:   Thu, 24 Aug 2023 12:33:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>, "shr@fb.com" <shr@fb.com>
Subject: Re: [PATCH] generic/471: Remove this broken case
Message-ID: <ZObBZw0e0SJkYWkY@dread.disaster.area>
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAL3q7H7C0mE9tBaipdYPYOCgBVYMTVKQ8=f90khTckt1CbBF4A@mail.gmail.com>
 <9eadebb8-1bc7-1c19-ad3d-04b31271f8dc@fujitsu.com>
 <20230818124325.vxod6jkdzirdeaak@zlang-mailbox>
 <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com>
 <ZOL4kmQ/2ZLEzvmI@dread.disaster.area>
 <CAL3q7H6hgU89heBMAeDcFqGmSWtpOZu-haAjGDms1--nSVuSzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6hgU89heBMAeDcFqGmSWtpOZu-haAjGDms1--nSVuSzA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 21, 2023 at 12:16:54PM +0100, Filipe Manana wrote:
> On Mon, Aug 21, 2023 at 6:39 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Sat, Aug 19, 2023 at 05:25:35PM +0100, Filipe Manana wrote:
> > > On Fri, Aug 18, 2023 at 1:43 PM Zorro Lang <zlang@redhat.com> wrote:
> > > > On Wed, Aug 16, 2023 at 02:58:10PM +0000, Yang Xu (Fujitsu) wrote:
> > > > > I think the url that Jens mention should be this[1] when he reviewed
> > > > > Stefan V7 patch for "io-uring/xfs: support async buffered writes".
> > > > >
> > > > > [1]https://lkml.kernel.org/linux-fsdevel/ca60a7dc-b16d-d8ce-f56c-547b449da8c9@kernel.dk/
> > > >
> > > > Hi Filipe,
> > > >
> > > > Does above explanation make sense to you?
> > >
> > > Not completely.
> > >
> > > It justifies that the test's assumptions are not necessarily correct,
> > > that I understood and it's reasonable.
> > >
> > > However I don't see, neither in that thread nor in this patch's
> > > changelog, why the test started to fail (on xfs, it still passes on
> > > btrfs and ext4) after adding support for async buffered IO writes to
> > > xfs and iomap - as all the writes done by the test are using direct
> > > IO.
> >
> > We changed how timestamps are updated so that they are aware of
> > IOCB_NOWAIT. If the IOCB_NOWIAT DIO write now needs to update the
> > inode timestamps, it will return -EAGAIN instead of doing
> > potentially blocking operations that require IO to complete (i.e.
> > taking a transaction reservation).
> >
> > Hence the first time we go to do a DIO read an inode, it's going to
> > do an atime update, which now occurrs from an IOCB_NOWAIT context
> > and we return -EAGAIN....
> >
> > Yes, we added non-blocking timestamp updates as part of the async
> > buffered write support, but this was a general XFS IO path change of
> > behaviour to address a potential blocking point in *all* IOCB_NOWAIT
> > reads and writes, buffered or direct.
> 
> Ok, now that's the kind of explanation I would expect in the changelog.

Why? It was clearly obvious in the patch series that this
infrastructure was being added to the VFS and XFS was being
converted to use it. All the VFS support for this was done in
earlier patches in the series, but the bisect doesn't land on them -
it lands on the commit that enabled that functionality.

Indeed, just because the commit a bisect lands on doesn't describe
all the specific changes in behaviour that occur across an entire
series, it doesn't mean the change logs for the patches are bad or
incomplete. It just means there's more context to the new feature
the patch enables than what is in the commit that the bisect lands
on.

> > > At least the changelog should point to that thread, and not the one it
> > > currently refers to because it doesn't provide any useful information.
> > > For completeness it should also justify why the async buffered write
> > > support broke the test, as it points out the test fails after those 2
> > > commits for buffered write support, yet there are no buffered writes
> > > performed by the test.
> >
> > async buffered writes didn't break the test. The addition of
> > nonblocking timestamp updates in XFS is what causes the test to now
> > fail.
> 
> Ok, so the changelog is very misleading, as it points to commits that,
> as far as I can see at least,
> have nothing to do with the changes that make timestamp updates aware
> of NOWAIT semantics.
> 
> So it should be the following commit to be referred (and possibly others):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66fa3cedf16abc82d19b943e3289c82e685419d5

Precisely my point. This is the async timestamp NOWAIT VFS support
patch that the XFS changes depended on. You have to look at the
change as a whole, not just individual commits. But this patch
didn't enable that functionality in XFS - it's just the
infrastructure - and so the bisect is *never* going to land on this
patch because nothing actually uses the code at this point. The
bisect will always land on the commit that enables the new
functionality, and those commits rarely explain all the details of
the new functionality that it is enabling.

If you don't like that, then review the new feature code as it goes
past and ask the authors to rewrite all their commit messages to
explain everything in every patch in the series. We just don't do
that because it is unnecessary - everyone else who reviewed the
series was happy with the commit messages for each commit because
they looked at the whole series, not just one specific patch in the
large work like you have done and then complained about.

> > Indeed, we may change this XFS behaviour again some day - if we can
> > guarantee that we can get a transaciton reservation without blocking
> > then we -could- allow the timestamp update to run in IOCB_NOWAIT
> > context. Doing this would then mean the test might randomly fail,
> > depending on whether the timestamp update can be done without
> > blocking or not....
> >
> > Put simply, the test is not validating that RWF_NOWAIT is behaving
> > correctly - it just was a simple operation that kinda exercised
> > RWF_NOWAIT semantics when we had no other way to test this code. It
> > has outlived it's original purpose, so it should be removed...
> 
> Thanks for the detailed explanation.
> 
> A simpler version of this, or perhaps a lore link to your reply should
> be added to the changelog,
> because the current one is more like "remove this test because someone
> else told to do so" without
> any relevant details.

<shrug>

I don't care if that is done or not, and it should not hold up
removing the test. We know why it needs to be removed, and this
discussion is already in lore under the patch name, so everyone can
find it simply by searching for the commit title in the lore
archive.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
