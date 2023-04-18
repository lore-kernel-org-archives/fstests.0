Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C710EC77B75
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Apr 2023 04:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDREtb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDREta (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Apr 2023 00:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE41BDC
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2023 21:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C14E61F11
        for <fstests@vger.kernel.org>; Tue, 18 Apr 2023 04:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B1C433EF;
        Tue, 18 Apr 2023 04:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681793368;
        bh=StRAnKP3hbVUB62vPk4R02L5RxPuHU5+SO8k+nSENjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSdQyOVVA+OLolJfuhYgcWXfYjgSfssGY3VH99UwC1nTb7RJLEDopg0srCdUW7q8M
         tNsxf6YgAKUS8Ereipzy/CI+axl/pKDmy6PkGaZpRFd8WSoN0ImgB+7n9uEruAUrI/
         +kUsx0LiMHbhAVhacMRnmsYfE0QWPBfSywm1glkRSHVhyuWMLSUe0mha5DTjgIM/Kf
         NlmyFD2Lxw7Bh0PxsjVyb02evkcqTBeIVfcwU2R0uYeofmQLiRyebQZj48hU8ofdX6
         Xu4k/GrA/1jINk/bG+MqFSDfaf1PUdVrE6MHJq/2Jo5jJRVqIZcMVzS+okPKbe/FKl
         ZDKBB6N3N35Zg==
Date:   Mon, 17 Apr 2023 21:49:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <lrumancik@google.com>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH 2/2] check: _check_filesystems for errors even if test
 failed
Message-ID: <20230418044928.GD360885@frogsfrogsfrogs>
References: <20230414221133.3431400-1-leah.rumancik@gmail.com>
 <20230414221133.3431400-2-leah.rumancik@gmail.com>
 <20230415004131.GC360885@frogsfrogsfrogs>
 <CAMxqPXVGGOn6A5ijRwaw7k0JfYD2gHftDWOVBVq=jrE3JW9gDQ@mail.gmail.com>
 <CAMxqPXVo4aadFwLFZLkEoBXCPk=RPe1yjXraSjsN1PN0jXZLKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxqPXVo4aadFwLFZLkEoBXCPk=RPe1yjXraSjsN1PN0jXZLKw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 17, 2023 at 01:08:20PM -0700, Leah Rumancik wrote:
> Well actually, if you are using DUMP_CORRUPT_FS, you'd probably want
> _check_filesystems to run on the scratch fs as well.

ooh, good point

> This shouldn't
> add that much time if most of your tests are passing :) but I could
> make this only run for scratch fs on failure only if DUMP_CORRUPT_FS
> is set?

Hmm.  On second thought, you've convinced me to go along with this.
The test failed, let's see if corruption happened --> HAPPY DANCE.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> On Mon, Apr 17, 2023 at 10:19 AM Leah Rumancik <lrumancik@google.com> wrote:
> >
> > Sure, will send out another set. Thanks!
> >
> > On Fri, Apr 14, 2023 at 5:41 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 03:11:33PM -0700, Leah Rumancik wrote:
> > > > Previously, we would only run _check_filesystems to ensure that a test
> > > > that appeared to pass did not have any filesystem corruption. However,
> > > > in _check_filesystems, we also repair any errors found in the filesystem.
> > > > Let's do this even if we already know the test failed so that subsequent
> > > > tests aren't affected.
> > > >
> > > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > > ---
> > > >  check | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/check b/check
> > > > index befbf465..c18f02ca 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -972,6 +972,7 @@ function run_section()
> > > >                       # Even though we failed, there may be something interesting in
> > > >                       # dmesg which can help debugging.
> > > >                       _check_dmesg
> > > > +                     (_adjust_oom_score 250; _check_filesystems)
> > >
> > > Seeing as the test failed, do we care about the state of the scratch fs?
> > > Would it be sufficient only to clean up the test fs to avoid cascading
> > > damage?
> > >
> > > (Asking as someone who knows how impactful slow filesystem checking can
> > > be on fstests runtimes... ;))
> > >
> > > --D
> > >
> > > >                       tc_status="fail"
> > > >               else
> > > >                       # The test apparently passed, so check for corruption
> > > > --
> > > > 2.40.0.634.g4ca3ef3211-goog
> > > >
