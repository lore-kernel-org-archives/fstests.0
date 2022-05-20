Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CFC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 16:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351551AbiETQXP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351536AbiETQXO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 12:23:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F8917DDCB
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 09:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 091E161E3D
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 16:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB34C385A9;
        Fri, 20 May 2022 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653063791;
        bh=5llEKDN8gVuxzISfO3dEgao+mYCHNU/YfFw87V3InuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQxpt0B7IETvf3xid53JafqVEyDEGYt2Af4JlADFYoOjevPkdf5hQsEIQSK9CnAHI
         i3fwc9+zoQNYqnVHzRI4bXI+n1qfRYFXumV/2nT3+So3vnHpPcH9NjjXmftWgCx/nf
         2BeOTSo+5a+aYU872qbDVUldXB7uyZOAEB2OVsPkGwuc2iY8K7QcYcOEb6Cvqc4u/j
         l983ueXJUa3O9UddDgeiTNjEYRV40bwA+sKEfbBM7iquynNBQikfEWQCWBd3uDR9Zn
         sn+HyKwQ4kDdAB8Cutb3kYWOAtJM3O3vJIkeEuIPrnJANT2G25kYF1MvOsTy44W9CP
         f5xwqUOB+8cnw==
Date:   Fri, 20 May 2022 09:23:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 04/12] fstests: fix group list generation for whacky test
 names
Message-ID: <YofAbrh79yb2dmWs@magnolia>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-5-david@fromorbit.com>
 <20220520083647.s22yb2aearmviffi@zlang-mailbox>
 <20220520085445.mil6iwc5mltbmss3@zlang-mailbox>
 <20220520092515.q5lyyujfnanrpcmx@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520092515.q5lyyujfnanrpcmx@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 05:25:15PM +0800, Zorro Lang wrote:
> On Fri, May 20, 2022 at 04:54:45PM +0800, Zorro Lang wrote:
> > On Fri, May 20, 2022 at 04:36:47PM +0800, Zorro Lang wrote:
> > > On Tue, May 17, 2022 at 05:01:03PM +1000, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Darrick noticed that tests/xfs/191-input-validation didn't get
> > > > generated properly. Fix the regex to handle this.
> > > > 
> > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > >   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> > > > tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> > > > $
> > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > >   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> > > > 191 auto quick mkfs realtime
> > > > $
> > > > 
> > > > Use the regexes for matching test names defined in common/test_names
> > > > rather than trying to open code it.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > 
> > > Hi Dave,
> > > 
> > > After testing, looks like this patch brings in a regression issue, it causes
> > > case number aren't sorted in group.list, then the xfstests/new program can't
> > > get a right new case number which is unused. For example:
> > 
> > Oh, this issue isn't from this patch, it's from 441606d2 ("fstests: faster group
> > file creation"). Hmm... I saw your used "sort -u" in that patch, I'm going to
> > look into what's wrong with that.
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > # make
> > > # ./new generic
> > > Next test id is 019
> > > Append a name to the ID? Test name will be 019-$name. y,[n]: ^C
> > > # ls tests/generic/019
> > > tests/generic/019
> > > 
> > > Then comparing the tests/generic/group.list with old generic/group.list, found
> > > lots of difference, due to the number in new group.list isn't sorted from
> > > small to big (I haven't gotten chance to check if there're missing number).
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > >  tools/mkgroupfile | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> > > > index 24435898..414cb538 100755
> > > > --- a/tools/mkgroupfile
> > > > +++ b/tools/mkgroupfile
> > > > @@ -19,6 +19,8 @@ if [ ! -x ../../check ]; then
> > > >  	exit 1
> > > >  fi
> > > >  
> > > > +. ../../common/test_names
> > > > +
> > > >  cleanup()
> > > >  {
> > > >  	rm -f $new_groups.check
> > > > @@ -60,7 +62,8 @@ ENDL
> > > >  
> > > >  	# Aggregate the groups each test belongs to for the group file
> > > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > > -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> > > > +		sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> > > > +		>> $new_groups
> 
> I think add a "sort -ug" [1] will help to fix this problem.

Yes please, it's much easier for us humans to index the file if it's
already sorted numerically.

> I'm wondering
> why we use ">> $new_groups" at here, why an appending write is needed. I think
> there's not a 'loop running' for this code, right? If there's, please correct
> me, then the 'sort -ug' have to be moved to other place.

The function writes a header into the group list file warning readers
that it's an autogenerated file.

--D

> Thanks,
> Zorro
> 
> [1]
> -               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> -               >> $new_groups
> +               sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" | \
> +               sort -ug > $new_groups
> 
> I'm wondering why we use
> 
> > > >  
> > > >  	# Create the list of unique groups for existence checking
> > > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > > -- 
> > > > 2.35.1
> > > > 
> 
