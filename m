Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE053EB64D9
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 10:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjGLKLG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGLKLF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 06:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A6010F2
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689156618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJ2Ymf/7HqU+B9AlyyfTWOivlgwpamMplduO7ACJShA=;
        b=MLi7IkAvJEkP+hJWtMcESoGudomC66sw8lrQ2fit54+U1tFChp6jFHC5cofPeJa2NOBmQO
        ZJFVpgOW5SD483PqfAGM+JeR5XuoJhJS57zG1JwBKSgtuUlL8NnFNX7DBBZ25CA8KQoX5F
        O5elnAHKKEM08H0hkfmPGe3zeoOo8KU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-U8C2NewkMd-8I-gOG_IkHw-1; Wed, 12 Jul 2023 06:10:16 -0400
X-MC-Unique: U8C2NewkMd-8I-gOG_IkHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FD318EBBB0;
        Wed, 12 Jul 2023 10:10:16 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19E9AC1ED96;
        Wed, 12 Jul 2023 10:10:16 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 7D93630C0457; Wed, 12 Jul 2023 10:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 795DA3FB76;
        Wed, 12 Jul 2023 12:10:05 +0200 (CEST)
Date:   Wed, 12 Jul 2023 12:10:05 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
In-Reply-To: <20230712010939.2htp62rd7qvshgiy@moria.home.lan>
Message-ID: <758f1d7d-2411-848f-6773-b8873d8dce83@redhat.com>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com> <20230711234439.GC11442@frogsfrogsfrogs> <20230712010939.2htp62rd7qvshgiy@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On Tue, 11 Jul 2023, Kent Overstreet wrote:

> On Tue, Jul 11, 2023 at 04:44:39PM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 11, 2023 at 05:51:42PM +0200, Mikulas Patocka wrote:
> > > When I run the test 558 on bcachefs, it works like a fork-bomb and kills
> > > the machine. The reason is that the "while" loop spawns "create_file"
> > > subprocesses faster than they are able to complete.
> > > 
> > > This patch fixes the crash by limiting the number of subprocesses to 128.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > > ---
> > >  tests/generic/558 |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > Index: xfstests-dev/tests/generic/558
> > > ===================================================================
> > > --- xfstests-dev.orig/tests/generic/558
> > > +++ xfstests-dev/tests/generic/558
> > > @@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
> > >  while [ $i -lt $loop ]; do
> > >  	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
> > >  	let i=$i+1
> > > +	if [ $((i % 128)) = 0 ]; then wait; fi
> > 
> > Hm.  $loop is (roughly) the number of free inodes divided by 1000.  This
> > test completes nearly instantly on XFS; how many free inodes does
> > bcachefs report after _scratch_mount?
> > 
> > XFS reports ~570k inodes, so it's "only" starting 570 processes.
> > 
> > I think it's probably wise to clamp $loop to something sane, but let's
> > get to the bottom of how the math went wrong and we got a forkbomb.
> 
> It's because:
>  - bcachefs doesn't even report a maximum number of inodes (IIRC);
>    inodes are small and variable size (most fields are varints, typical
>    inode size is 50-100 bytes).
> 
>  - and the kernel has a sysctl to limit the maximum number of open
>    files, and it's got a sane default; this is what's supposed to save
>    us from pinned inodes eating up all ram), but systemd conveniently
>    overwrites it to some absurd value...
> 
> I'd prefer to see this fixed properly, rather than just "fixing" the
> test; userspace being able to pin all kernel memory this easily is a
> real bug.
> 
> We could put a second hard cap on the maximum number of open files, and
> base that on a percentage of total memory; a VFS inode is somewhere in
> the ballpack of a kilobyte, so easy enough to calculate. And we could
> make that percentage itself a sysctl, for the people who are really
> crazy...

If we hit the limit of total open files, we already killed the system. At 
this point the user can't execute any program because executing a programs 
requires opening files.

I think that it is possible to setup cgroups so that a process inside a 
cgroup can't kill the machine by exhausting resources. But distributions 
don't do it. And they don't do it for a root user (the test runs under 
root).

Mikulas

