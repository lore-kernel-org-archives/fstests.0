Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51CAC3DA78
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Jan 2023 18:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjAOSeD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Jan 2023 13:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjAOSeD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Jan 2023 13:34:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB1BF744
        for <fstests@vger.kernel.org>; Sun, 15 Jan 2023 10:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 274A560D2E
        for <fstests@vger.kernel.org>; Sun, 15 Jan 2023 18:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A4CC433F0;
        Sun, 15 Jan 2023 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673807640;
        bh=QGpgG4sVzKXlAsKzLbSB/SbugNICZWn2NGQYy17YvB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRO6WrdxUM+48f6AYnLOIP+Ur0gM6nKr3W47GnqZMPQTPYYNj64HyMixVHHjtkWAc
         oHt0B46pYaSnx/PMZ0uAAQNE6Z8BzD06XCARgGHa+20MLiM98ZMxrneb1C/njfMxj8
         z42ZMvHv7DLS/U7/ygtIrxy8MPSIQyh4M3uxWEjWtZKthvejXjwWRoW63W/KyIGGhw
         ga3BBMuZh5qn5BReRNhlGW99zNpD1o2wR5rfDv3s5ypYlEoj9Y14IdNMsg1VaH0pv9
         6T7a5IAjTv4f0/sQxVqhWv2/fuLIWBCwm1MkBp5GZIhe18m+VdSujdOylGLVlXTtv9
         qUPe4/4THxvNg==
Date:   Sun, 15 Jan 2023 10:33:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     David Disseldorp <ddiss@suse.de>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] more python dependence. was: populate: fix horrible
 performance due to excessive forking
Message-ID: <Y8RHF8c2vMJl3khu@magnolia>
References: <20230110224906.1171483-1-david@fromorbit.com>
 <20230110224906.1171483-2-david@fromorbit.com>
 <Y75Q/dBXOIeIPonK@magnolia>
 <Y79pOYhJICghtLgj@magnolia>
 <20230112112458.4b024930@echidna.fritz.box>
 <Y8A+bGITjQo1p3rg@magnolia>
 <20230112204213.k6amqgcydn76pjsm@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112204213.k6amqgcydn76pjsm@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 13, 2023 at 04:42:13AM +0800, Zorro Lang wrote:
> On Thu, Jan 12, 2023 at 09:07:56AM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 12, 2023 at 11:24:58AM +0100, David Disseldorp wrote:
> > > Hi Darrick,
> > > 
> > > On Wed, 11 Jan 2023 17:58:17 -0800, Darrick J. Wong wrote:
> > > 
> > > > > (removexattr looks like a pain in perl though...)
> > > > > 
> > > > > Anyway it's late now, I'll look at the diff tomorrow.  
> > > > 
> > > > ...or thursday now, since I decided to reply to the online fsck design
> > > > doc review comments, which took most of the workday.  I managed to bang
> > > > out a python script (perl doesn't support setxattr!) that cut the xattr
> > > > overhead down to nearly zero.
> > > 
> > > IIUC we currently only depend on python for the fio perf tests and
> > > btrfs/154 . My preference would be to not see it spread further
> > 
> > I don't appreciate your dismissal of the patch before I've even posted
> > it!
> > 
> > The fstests README clearly lists python3 as a dependency.  Argument
> > parsing and xattr calls are provided by the base python3 runtime.  No
> > third party libraries are required for this new program, and if they
> > were, they'd be added to the README.
> 
> Sorry Darrick, that README description might not exact enough :/ some packages
> are not *necessary* for the whole fstests running. Their missing might just
> cause some single cases be skipped.
> 
> The python3 isn't necessary running/building dependence of fstests. Some
> people might run fstests without python3 currently. And I don't plan to
> make it become *necessary* (no running if no python3) now. If you'd like
> to add python3 dependence to common helpers, that might affect more cases.
> 
> So how about fall back to old code if no python3? Or you'd like to skipped
> populate related testing if no python3? Or use another way to reduce the
> hard dependence change.

I'm still working on getting this to pass the online fsck fuzz QA tests.

I started by moving the btree dir creation fix to the front of the
series, and then split this first patch into one patch to speed up
directory creation and a second patch to run most of the creation
helpers in parallel.

It turned out that my earlier patch moving the loop to a perl script was
even faster than Dave's thing, so I substituted that one.

Next I reworked the xattr creation speedups to incorporate all the
review comments.  Zorro pointed out that unlike perl, there's nothing in
fstests that _fatals the lack of python.

For people with python3, I still provide a new script to handle creation
and selective deletion of xattrs.  This reduces the xattr part of the
runtime to nearly zero.  For people who don't want python3, I
resurrected the previous version of the patch that formats a fake xattr
dump file and pipes it to setattr --restore.  The deletion loop is still
slow, but overall it's faster than before.

That leaves the parallel creation patch.  This has caused lots of
headaches for me because the previous populate() implementation would
(perhaps accidentally) create a filesystem where most of the field
fuzzing didn't get in the way of mounting the filesystem, but with
parallel creation enabled, I see a lot of online fsck test failures
resulting from mount failure.

For example, the function creates a directory tree under
SCRATCH_MNT/INOBT/ with enough files to create a multilevel inode btree.
When the function ran serially, the inode allocation rotor would not
generally create the diretory (and its children) in AG 0.  This is what
we want, since problems in the AG 0 inode btree usually result in mount
failures when we try to look up the root directory.  With parallelism
enabled, the inobt gets created in AG 0 sometimes, which causes the
online fsck fuzz tests to fail because mount failed.

The populate function *could* get smarter about avoiding AG 0, though
that would come with an increase in code complexity.

I then measured the performance speedup of each of the individual
patches in my branch.  Removing the execve overhead resulted in a 10x
decrease in runtime (~170s to ~15s), but parallelizing after that only
netted a ~2s decrease in runtime.

Online fsck testing seems fine if I pop the parallelization patches off,
so I'll keep trying, but I think I've hit the point of diminished
returns.

--D

> Thanks,
> Zorro
> 
> > 
> > > (especially if it's just to shave off a little runtime), mostly because
> > > it's a pain for dependency tracking.
> > > Perhaps you could use perl's syscall(SYS_fsetxattr(), ...)? Well, that or
> > 
> > Raw system calls are a terrible idea for maintainability.  You'd
> > *seriously* rather I open-code the glibc xattr wrappers and make the
> > fstests community maintain that for the sake of your preference?
> > 
> > > rewrite it again in awk ;-P
> > 
> > WTAF?
> > 
> > --D
> > 
> > > Cheers, David
> > 
> 
