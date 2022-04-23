Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7FFC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 23 Apr 2022 11:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiDWLKb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 23 Apr 2022 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiDWLKa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 23 Apr 2022 07:10:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64892113CB4
        for <fstests@vger.kernel.org>; Sat, 23 Apr 2022 04:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C234B80B1E
        for <fstests@vger.kernel.org>; Sat, 23 Apr 2022 11:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C728C385A5;
        Sat, 23 Apr 2022 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650712050;
        bh=mfKlXfNx8yZ+TkrvWcai1o2GZfWhMshfuHZBmydAJL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qq0r4aMMwTfB9wvreLupIM/4DMJd2M69YHCUMMsUTaq7hLVoLhWuxurHR878BQ9lz
         c3nAPKiZWm4qIfl4q0bHdOZPP099VukD3mpQo+69rpeNXkz4OWufPl71YP0fOwetKd
         z35woY2lk3c+xzhz5pjMMRh3Nah2M9yZmQs80hZtUHFA2Fjjdb7DIzKAIARArJRNfo
         9SDPPOTo5MVokwX0584SpSY6xTsYPkW6a5yJ0UCeW4s9txyRpN8Gf5NC4bQbwWMGpO
         an4Pny64aU7Pq+YDlXpqZRpT0GkKjT1brCufNTAK9IG2uDC12SMYD65R+U6G1fa48J
         YzMtlXxqsGKJA==
Date:   Sat, 23 Apr 2022 13:07:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220423110725.62w7kqot5wmalpt5@wittgenstein>
References: <20220419131423.2367795-1-brauner@kernel.org>
 <20220420175221.2502964-1-brauner@kernel.org>
 <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
 <20220421085942.GR1609613@dread.disaster.area>
 <20220421153513.frp7xdbejsoawews@zlang-mailbox>
 <20220421153717.GA27435@lst.de>
 <20220421155320.agny6epqti2tcmit@wittgenstein>
 <CAOQ4uxhNskcDAuguYYkkvwrwFSw2A_s+MpJj6WcsguOSUSE7mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhNskcDAuguYYkkvwrwFSw2A_s+MpJj6WcsguOSUSE7mg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 23, 2022 at 10:17:59AM +0300, Amir Goldstein wrote:
> On Thu, Apr 21, 2022 at 9:05 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Apr 21, 2022 at 05:37:17PM +0200, Christoph Hellwig wrote:
> > > On Thu, Apr 21, 2022 at 11:35:13PM +0800, Zorro Lang wrote:
> > > > Sure, I won't do that wilfully, just try to ask how we can improve this
> > > > huge and 'keep growing' idmapped-mounts.c, not tend to remove the whole
> > > > idmapped-mount testing coverage :)
> > >
> > > It might just be time to split that file up into a few ones if there
> > > is a sensible split.  I'll let Christian think about that, though.
> >
> > Yep, I agree. I think we need to at least rename it to reflect is vfs
> > generic nature and then split it into separate test binaries.
> > I'll think about a good approach.
> 
> The majority of test cases still do require_fs_allow_idmap and from
> those who don't, most of them are variants for test cases that run
> with and without idmapped mounts and possibly also in_userns.

Just to clarify a few points in more detail to expand on the "grossly
misnamed" theme:

Given that this started out as a dedicated testsuite to provide almost
obsessive testing of idmapped mounts the majority of tests is of course
about idmapped mounts. It'd be rather concerning if it wasn't, in
addition to also being misnamed.

But to put numbers to it, we do have 74 test functions that each have a
separate theme. Spread across the 74 test functions we do have ~120 test
cases (Basically each fork() invocation in each of those 74 test
functions can be considered a separate test case.).

Of these 74 test functions we do have 12 generic vfs test functions,
i.e. test functions that are not concerned with idmapped mounts.

Just going by the number of test functions, not actual test cases that's
almost 20% of the test suite concerned with generic vfs behavior.

Plus, there's additional patchsets that extend the generic behavior
which brings in another ~4-8 additional generic test functions with
multiple test cases. And people will keep adding to it.

> 
> And this new test case is no exception - there is still idmapping
> involved, just not idmapped-mounts.

The point was that there's a decent number of tests that aren't
concerned with idmapped mounts. And this new test-case is only relevant
for tmpfs mounted in a non-initial userns. So I'm not sure what this is
trying to say.

The argument is simply that there is a non-trivial number of tests that
are not concerned with idmapped mounts. But the name of the test binary
does imply that it is only concerned with idmapped mounts when it
clearly isn't. So it is misnamed at this point causing understandable
confusion.

Iow, given that I and others have to respond to a patch or add a comment
in the commit message of a patch to remind people that the thing they're
patching doesn't just do what it says on the tin, we should probably
rename it or do something else to improve the situation.

It'd be concerning to have a can labeled "tomato soup" but to then
discover that is also has spaghetti in it. That might be a nice suprise
but I'd still better put it on the label. :)

That's beside the point that the source file is 15k+ LOC strong which is
just obscene. :)

> 
> However you decide to break it up and/or rename the test binary
> (I am not sure you must split the binary - only the source files),

Rename we must imho; but I haven't yet decided whether or not we really
should use separate binaries. I think I'd make that dependent on whether
or not a good generic name can be found. :)

> I think we need to be more consistent about the groups that the tests
> that run this binary are in.
> 
> 'perms' group is adequate, but adding to the 'idmapped' group and
> maybe also to a new 'userns' group would be useful.
> 
> BTW, the tests that use src/nsexec should also belong to the userns
> group as does overlay/020, the only test that uses the 'unshare' tool.

Good points.
