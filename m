Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB5EB64DD
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 18:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjGLSfr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGLSfq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 14:35:46 -0400
Received: from out-17.mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B8AE77
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 11:35:44 -0700 (PDT)
Date:   Wed, 12 Jul 2023 14:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689186942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsBg8MibrQRwdroTKdHv5Bv4uoUBvRP2QiFNqzp5E2I=;
        b=qQKL8nao8Fm2nGTKE8ypRI0dO1YUrG90Zw2eYooOovhnopSz0pWEYTHfGKs+trTNo47AnT
        2oni84kZ9kq1TT3cOxKKV0xs6bnJd7oespiZhMvrDYjyVd/rRz8okOyKMMvCU7o/fHnnr+
        Uc8mDpwqM22j7UbqvXzKmr3jbWNeqUE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230712183538.fxijfxd6pvs2syh6@moria.home.lan>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
 <20230711234439.GC11442@frogsfrogsfrogs>
 <20230712010939.2htp62rd7qvshgiy@moria.home.lan>
 <758f1d7d-2411-848f-6773-b8873d8dce83@redhat.com>
 <20230712145252.35xgebxg4i4a6g7e@moria.home.lan>
 <173ce5a9-5494-3ac2-e121-63a838734e1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173ce5a9-5494-3ac2-e121-63a838734e1c@redhat.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 12, 2023 at 07:59:07PM +0200, Mikulas Patocka wrote:
> 
> 
> On Wed, 12 Jul 2023, Kent Overstreet wrote:
> 
> > On Wed, Jul 12, 2023 at 12:10:05PM +0200, Mikulas Patocka wrote:
> > > If we hit the limit of total open files, we already killed the system. At 
> > > this point the user can't execute any program because executing a programs 
> > > requires opening files.
> > > 
> > > I think that it is possible to setup cgroups so that a process inside a 
> > > cgroup can't kill the machine by exhausting resources. But distributions 
> > > don't do it. And they don't do it for a root user (the test runs under 
> > > root).
> > 
> > When I looked at this test before I missed the fork bomb aspect - was
> > just looking at the crazy numbers of pinned inodes (which is still a
> > significant fraction of system memory, looking again...)
> > 
> > If we change bcachefs to not report a maximum number of inodes, might
> > that be more in line with other filesystems? Or is it really just
> > because bcachefs inodes are tiny?
> 
> I think that it's OK to report as many free inodes as it fits on the 
> filesystem. I think it is not a bug - we should fix the test, not lie to 
> make the test pass.
> 
> There is one misbehavior though. As the test allocates the inodes on 
> bcachefs, the total number of inodes is decreasing. The other filesystems 
> don't behave in this way and I think that bcachefs shouldn't change the 
> total number of inodes too.

I don't think that's avoidable: bcachefs inodes are variable size (we
use varints for most fields), so the total number of inodes is only a
guess - it'll also decrease by just writing normal data.
