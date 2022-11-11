Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502ADC4332F
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Nov 2022 02:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKKC0T (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiKKC0S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Nov 2022 21:26:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA16239E
        for <fstests@vger.kernel.org>; Thu, 10 Nov 2022 18:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668133525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3S4jeX2vJh+LCNqFIlzIjLuqx9zHXq4CCQ8JM8M17f4=;
        b=XuDqKUB2NWSU1VxGoZg5nNiXCdI5rv7f79UJTG89vLvTUJvdYl6URVabPRzdmc+XQo0nCG
        JkDwNRYcLIoOn2d+ZcNA52axyJ/ith8aLo0KJeJ3kJj2cJLvsFAralMl34I2AKggnJltP4
        EBPcESgayxNZ9xk+buVqyPIyssX4yjU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-_7rsviITOJqGt-SDamWopw-1; Thu, 10 Nov 2022 21:25:20 -0500
X-MC-Unique: _7rsviITOJqGt-SDamWopw-1
Received: by mail-pf1-f200.google.com with SMTP id cj8-20020a056a00298800b0056cee8a0cf8so1967098pfb.9
        for <fstests@vger.kernel.org>; Thu, 10 Nov 2022 18:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S4jeX2vJh+LCNqFIlzIjLuqx9zHXq4CCQ8JM8M17f4=;
        b=peX+w5MsUxwTTM1lzrfNFxD6d/EC85J0XSXoLEI4o2S6X348l4Nv3tGOIHgms8h6DA
         K+e+IKSDrhOYO5RBLtz4a8WkIlnUwn0IzFNNBbBqAn7IJDA8UjU3NyfxhmGJsv81y9EA
         iTtarO3dCprnWDJawGLX3gzIdhglZttRaDbS1RnOHA2H49gUKCQKVEXxAbIKdJwUX1YR
         u8YW6pmMMBPlu/C0tON/EwQKzIdU6RBv5Rhhwe3VxsH23P4xeNrZAp1E9TcqhB268ZhS
         AXyEsxDzZQ/QX3bjb2DFuh++X//QM351osW9GcUXkKEIpqHyKqtqRCYodp7YpgGdj4p9
         YFMA==
X-Gm-Message-State: ACrzQf2XGj4rB+FcPhq3PJN6p/5hbCWK4fXI6Zs4eC6NInrHV+RBTJ3C
        3JdsCiFYpYxXtrJ079iiC9diP2X+5Hzq+J957veMSrmL3Rylnvq6XCRqE4UBy3BXWHBCg2kZQaJ
        r2U0CZP3e4KHPP8uQvg==
X-Received: by 2002:a17:90b:30c7:b0:213:5e6e:5d28 with SMTP id hi7-20020a17090b30c700b002135e6e5d28mr3101158pjb.60.1668133519701;
        Thu, 10 Nov 2022 18:25:19 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5yo+znz1oGMg7I+9Fbbakkl0ZrtluZseaBW5w1uGKDikjwhcOZFkJfsGZk1EsXXkIWH260Qg==
X-Received: by 2002:a17:90b:30c7:b0:213:5e6e:5d28 with SMTP id hi7-20020a17090b30c700b002135e6e5d28mr3101131pjb.60.1668133519317;
        Thu, 10 Nov 2022 18:25:19 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b31-20020a631b5f000000b0045751ef6423sm294359pgm.87.2022.11.10.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:25:18 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:25:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20221111022514.uzk5a2ovnetutrzy@zlang-mailbox>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
 <Y2lmFoNQ2ByXzCW0@magnolia>
 <20221108024455.6lhdrbfoqq53wj4p@zlang-mailbox>
 <Y2pw08wrQbAfAtT5@mit.edu>
 <20221108155605.faqf7knxrdcdin4n@zlang-mailbox>
 <Y2qHkFxVvYlANCZc@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qHkFxVvYlANCZc@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 08, 2022 at 08:45:04AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 08, 2022 at 11:56:05PM +0800, Zorro Lang wrote:
> > On Tue, Nov 08, 2022 at 10:08:03AM -0500, Theodore Ts'o wrote:
> > > On Tue, Nov 08, 2022 at 10:44:55AM +0800, Zorro Lang wrote:
> > > > > If it's collapse/insert range you're specifically worried about, perhaps
> > > > > its time to implement _get_file_block_size for ext4 so that
> > > > > _test_congruent_file_oplen can exclude those tests that will get the
> > > > > alignment wrong?
> > > > 
> > > > Thanks Darrick, I'm thinking about this helper you wrote recently :)
> > > > (The real name is _require_congruent_file_oplen in common/rc.)
> > > > 
> > > > Hi Ted, is this helpful if you write a _ext4_get_file_block_size (refer to
> > > > _xfs_get_file_block_size in common/xfs), then call it in _get_file_block_size
> > > > to help _require_congruent_file_oplen to get the correct length which is an
> > > > integer multiple of the file's allocation unit size ?
> > > 
> > > Well, it's a bit more complicated than that, since there's a
> > > distinction between the cluster size and block size.  The cluster size
> > > is the allocation unit.  However, other things are done in units of
> > > the block size, including how we report fiemap results, etc.
> > > 
> > > For example, take a look at generic/206.  It will try to create a file
> > > system where the file system block size is the one fourth of the page
> > > size --- so for x86, 1k.  However, for ext4, the default cluster size
> > > for 16 times the block size, so for this file system the allocation
> > > unit size is 16k.  If we make _get_file_block_size return 64k for all
> > > files, then generic/206 will fail:
> > > 
> > >     pagesz=$(getconf PAGE_SIZE)
> > >     blksz=$((pagesz / 4))
> > >     ...
> > >     _scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
> > >     ...
> > >     real_blksz=$(_get_file_block_size $testdir)
> > 
> > Hmm... I'm wondering is it possible that g/206 need _get_block_size() at here?
> > 
> > Due to from the logic of _get_file_block_size() [1], extN call _get_block_size()
> > directly. So if you feel a specific _ext4_get_file_block_size() isn't suit for
> > g/206, maybe it turely want _get_block_size() at here?

I just checked g/206 and other similar cases, I think they really need
_get_file_block_size, not the _get_block_size.

But for extN, as Ted said "it's a bit more complicated ...". If the
_get_file_block_size should return different allocate size according
to different later operations, how about let _get_file_block_size
support an optional argument, so specify what kind of allocate size
should be returned? XFS part can ignore this optional argument, if
it doesn't care.

Thanks,
Zorro

> > 
> > [1]
> > _get_file_block_size()
> > {
> >         if [ -z $1 ] || [ ! -d $1 ]; then
> >                 echo "Missing mount point argument for _get_file_block_size"
> >                 exit 1
> >         fi
> > 
> >         case "$FSTYP" in
> >         "ocfs2")
> >                 stat -c '%o' $1
> >                 ;;
> >         "xfs")
> >                 _xfs_get_file_block_size $1
> >                 ;;
> >         *)
> >                 _get_block_size $1
> >                 ;;
> >         esac
> > }
> > 
> > >     test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
> > > 
> > > I assume this works for xfs because only files in the real-time block
> > > size will have a larger allocation unit size, but the root directory
> > > has a allocation unit size of the "real" block size?
> > > 
> > > I suppose I could make a hypothetical _ext4_get_file_block_size lie
> > > and return the "real" block size when it's called on the mount point,
> > > but that seems kinda of gross, and it's also a lie, since the
> > > allocation unit size for the root directory actually is the cluster
> > > size, not the block size.
> > > 
> > > If I were going to be doing things from scratch, I'd make a
> > > distinction between _get_file_allocation_size and
> > > _get_file_system_block_size, which would be a lot *clearer* about what
> > 
> > Currently _get_block_size is more like _get_file_system_block_size, and
> > _get_file_block_size is more like _get_file_allocation_size. Actually
> > I'm confused about these two names before :)
> 
> Yes, both statements are correct.  They're both crappily named, one of
> them by me. :(
> 
> > > is going on.  Even then, I could imagine some tests getting confused
> > > with how, say, fiemap behaves with an ext4 file system with a 4k block
> > > size and a 64k allocation unit size, so I'm not sure it's a complete
> > > solution.  And doing this now would require quite a bit of code churn
> > > in xfstests.
> 
> Yes, it has been, uh, fun to fix fstests so that xfs realtime with a 28k
> allocation unit doesn't spray false failures everywhere.  I'm mostly
> done now, I hope? ;)
> 
> (Or at least I haven't heard any complaints from Leah in a solid 2
> months...)
> 
> > > > If this's helpful for your first concern [1], please tell me. Then we can talk
> > > > about your second concern [2], if it's still your main concern now :)
> > > > 
> > > > "This might *[1]* either be because the test didn't know about ext4
> > > >  bigalloc's cluster alignment requirements, *[2]* or because a particular
> > > >  operation might just be *buggy* and being able to run tests as if a
> > > >  particular command wasn't supported was useful."
> > > 
> > > So [1] is a real concern, and at the moment, we just suppress all of
> > > the tests that try to use collapse/insert range.  For example, from
> > > the ext4/bigalloc config file:
> > > 
> > >     # Until we can teach xfstests the difference between cluster size and
> > >     # block size, avoid collapse_range and insert_range since these will
> > >     # fail due the fact that these operations require cluster-aligned
> > >     # ranges.
> > >     export FSX_AVOID="-C -I"
> > >     export FSSTRESS_AVOID="-f collapse=0 -f insert=0"
> > >     export XFS_IO_AVOID="fcollapse finsert"
> > >     TEST_SET_EXCLUDE="-x collapse,insert"
> > 
> > Thanks for pointing this out, I'll help to check all fcollapse and finsert
> > related cases, and add them into collapse or insert group. We're keep improving
> > group problem, most of cases really not take too much care about its group.
> > And I'll pay more attention about the groups when I review patches.
> 
> <nod>
> 
> > > 
> > > That's not ideal, and it's been on my todo list to try to fix it, when
> > > I could get one of those round tuit's.  However, I had assumed that we
> > > would split _get_file_block_size somehow, given the observation I've
> > > made above.  So this was always been something that has put me off,
> > > because it looked like a much larger project than say, "gee, I have an
> > > hour or two on a weekend, let me see if I can fix this".
> > 
> > I'd like to help your team to deal with the fstests problems you hit in your
> > using procedure, feel free to tell us the part you hope to fix/improve. I
> > have to care about other teams too, so might need more time to evaluate and
> > talk, sorry about that.
> > 
> > > 
> > > [2] is practically not _really_ a concern any more.  It used to be
> > > that one of the ways that I would root cause a failing test was to
> > > suppress one of the advanced fallocate modes, whether it be
> > > collapse/insert range, or going even further back, punch hole.  If
> > > test then passed, then I could say, "ah, hah; the problem can probably
> > > be localized to a certain part of the fs code."
> > > 
> > > However, that's mainly tests that are using fsstress and fsx, and we
> > > have solutions for that.  And for other tests, I can examine the test
> > > and see whether or not it's using collapse/insert range by inspection,
> > > so it's really not that big of a deal.  I could imagine other file
> > > systems who might find this useful in the future, if they were trying
> > > to growing support for the more advanced fallocate modes --- but that
> > > wouldn't *my* concern, and arguably those file systems could solve
> > > problems alternate ways, such as having mount options that suppress
> > > those fallocate modes entirely which could be used when running
> > > xfstests.
> > > 
> > > 						- Ted
> > > 
> > > P.S.  I have noticed some tests that use collapse/insert range but
> > > don't declare that they are in the collapse or insert groups.
> > > Fortunately, all of these tests are also in the clone group, and so
> > > they don't apply to ext4, so _I_ don't care.  :-)
> > 
> > Thanks, I'll try to check all collapse/insert related cases.
> 
> <nod> Bad throwback to the days when we didn't scrutinize group names
> all that closely.  Someone probably ought to write a dumb linter that
> can look for obvious patterns in a testcase and nominate group names.
> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > 
> 

