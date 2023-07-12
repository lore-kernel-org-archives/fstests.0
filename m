Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31538EB64DC
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 01:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGLBRT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Jul 2023 21:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGLBRS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jul 2023 21:17:18 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 18:17:17 PDT
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [IPv6:2001:41d0:203:375::38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFB95
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2023 18:17:17 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689124183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fA+/5Oi02w3TM6lyJC0Sw32r2SM8itdWMJWYiCXR1Tc=;
        b=JrJu58oPmBT29Qbo4TkJ8g1YFjSWlvZ9C7rPHtPS+FLqNgrY+a6NroaUPy+xnH2TiH0a2h
        gxoHo8cNGS4VK2RE4zvsTBmGcp9q0URQPk7c2b7QHXMLnZQJBTHKXRKN/+ntIsGud4Wawt
        C/8HHblYZZxKtLBWzvpvq4e7mEt3O1E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230712010939.2htp62rd7qvshgiy@moria.home.lan>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
 <20230711234439.GC11442@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711234439.GC11442@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 11, 2023 at 04:44:39PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 11, 2023 at 05:51:42PM +0200, Mikulas Patocka wrote:
> > When I run the test 558 on bcachefs, it works like a fork-bomb and kills
> > the machine. The reason is that the "while" loop spawns "create_file"
> > subprocesses faster than they are able to complete.
> > 
> > This patch fixes the crash by limiting the number of subprocesses to 128.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > ---
> >  tests/generic/558 |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Index: xfstests-dev/tests/generic/558
> > ===================================================================
> > --- xfstests-dev.orig/tests/generic/558
> > +++ xfstests-dev/tests/generic/558
> > @@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
> >  while [ $i -lt $loop ]; do
> >  	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
> >  	let i=$i+1
> > +	if [ $((i % 128)) = 0 ]; then wait; fi
> 
> Hm.  $loop is (roughly) the number of free inodes divided by 1000.  This
> test completes nearly instantly on XFS; how many free inodes does
> bcachefs report after _scratch_mount?
> 
> XFS reports ~570k inodes, so it's "only" starting 570 processes.
> 
> I think it's probably wise to clamp $loop to something sane, but let's
> get to the bottom of how the math went wrong and we got a forkbomb.

It's because:
 - bcachefs doesn't even report a maximum number of inodes (IIRC);
   inodes are small and variable size (most fields are varints, typical
   inode size is 50-100 bytes).

 - and the kernel has a sysctl to limit the maximum number of open
   files, and it's got a sane default; this is what's supposed to save
   us from pinned inodes eating up all ram), but systemd conveniently
   overwrites it to some absurd value...

I'd prefer to see this fixed properly, rather than just "fixing" the
test; userspace being able to pin all kernel memory this easily is a
real bug.

We could put a second hard cap on the maximum number of open files, and
base that on a percentage of total memory; a VFS inode is somewhere in
the ballpack of a kilobyte, so easy enough to calculate. And we could
make that percentage itself a sysctl, for the people who are really
crazy...
