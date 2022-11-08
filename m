Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A597C4332F
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Nov 2022 15:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiKHP5H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Nov 2022 10:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiKHP5G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Nov 2022 10:57:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33512748
        for <fstests@vger.kernel.org>; Tue,  8 Nov 2022 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667922972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+TBuvXfRI0FKiAm4wFJ8FcaaOn1Aa6nohaB9d9UmKY=;
        b=EVJryludXgDiR/GBkT0MQN8yyj0ER1TT5F0gy6z7brJYmc+xVCHWxP+gbXMC+N2klwpyXK
        kWlllsDjYmD1aWI5bI1SREFntyf6SmYbkrCjXPh3wDi70Yoo0XH/nTNqFkAsMzso/jLtb8
        P574oLvyZzy1YoCnRKP/6/Nm3vTHUxI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-GWXeX23RNHmiYPv1oYiOmQ-1; Tue, 08 Nov 2022 10:56:11 -0500
X-MC-Unique: GWXeX23RNHmiYPv1oYiOmQ-1
Received: by mail-qv1-f71.google.com with SMTP id h1-20020a0ceda1000000b004b899df67a4so9819407qvr.1
        for <fstests@vger.kernel.org>; Tue, 08 Nov 2022 07:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+TBuvXfRI0FKiAm4wFJ8FcaaOn1Aa6nohaB9d9UmKY=;
        b=buFdrex+l46KilD7sCdCpArrLuiaCOg6+xLMNwrSN2BtbwIvfD5KFpvoLAsr8W33XL
         YLDedznjHqO/vCbzP3z2tZxRZeIIUeJtM8wC897UXhJ5sNyzOIGpYdTlG0HcRaIfquf0
         63vF+wvhuQCRyQiV4eu//WuluGJSFe0gG0I3W2ikDFG5Vhak4Zn0/F9Ad/KgJiuru4yh
         3S15PY7WBiPI/ubBYunAGVqjrCuBQjeTu2wkGQylWEsg4tP/MbQQ2N84eNpwDhE9814u
         +p6zsW8w+mJ8kWrswwywHneV+044vg0YGMhNixLX5TvGsbfXgik7xLWp0Y6PpAnGuc0f
         mMpA==
X-Gm-Message-State: ACrzQf3ehc2BlgpcNT1SDLT7oPz+OP1f7KzHca+/TW4W6uAnig3AI1QD
        Fvp+REhulRz4S5LY7IHZp/bh1Wg9LfbUkKYe2VTCMrZsa2ITA8u1UJLB8W+ugfvs3GNHjYp3yK2
        ow37YojLH+oirsMyabA==
X-Received: by 2002:a0c:da13:0:b0:4bb:5f2e:feb1 with SMTP id x19-20020a0cda13000000b004bb5f2efeb1mr51304045qvj.129.1667922970915;
        Tue, 08 Nov 2022 07:56:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5xNnpM37Bax9rH6FipXPXBaHkzCMeheRJXoDoZhMEu0T4NaSPuqEaLC8HPXiBLh0aCJBjjoA==
X-Received: by 2002:a0c:da13:0:b0:4bb:5f2e:feb1 with SMTP id x19-20020a0cda13000000b004bb5f2efeb1mr51304017qvj.129.1667922970657;
        Tue, 08 Nov 2022 07:56:10 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a44d600b006f9c2be0b4bsm9696402qkp.135.2022.11.08.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:56:09 -0800 (PST)
Date:   Tue, 8 Nov 2022 23:56:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20221108155605.faqf7knxrdcdin4n@zlang-mailbox>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
 <Y2lmFoNQ2ByXzCW0@magnolia>
 <20221108024455.6lhdrbfoqq53wj4p@zlang-mailbox>
 <Y2pw08wrQbAfAtT5@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pw08wrQbAfAtT5@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 08, 2022 at 10:08:03AM -0500, Theodore Ts'o wrote:
> On Tue, Nov 08, 2022 at 10:44:55AM +0800, Zorro Lang wrote:
> > > If it's collapse/insert range you're specifically worried about, perhaps
> > > its time to implement _get_file_block_size for ext4 so that
> > > _test_congruent_file_oplen can exclude those tests that will get the
> > > alignment wrong?
> > 
> > Thanks Darrick, I'm thinking about this helper you wrote recently :)
> > (The real name is _require_congruent_file_oplen in common/rc.)
> > 
> > Hi Ted, is this helpful if you write a _ext4_get_file_block_size (refer to
> > _xfs_get_file_block_size in common/xfs), then call it in _get_file_block_size
> > to help _require_congruent_file_oplen to get the correct length which is an
> > integer multiple of the file's allocation unit size ?
> 
> Well, it's a bit more complicated than that, since there's a
> distinction between the cluster size and block size.  The cluster size
> is the allocation unit.  However, other things are done in units of
> the block size, including how we report fiemap results, etc.
> 
> For example, take a look at generic/206.  It will try to create a file
> system where the file system block size is the one fourth of the page
> size --- so for x86, 1k.  However, for ext4, the default cluster size
> for 16 times the block size, so for this file system the allocation
> unit size is 16k.  If we make _get_file_block_size return 64k for all
> files, then generic/206 will fail:
> 
>     pagesz=$(getconf PAGE_SIZE)
>     blksz=$((pagesz / 4))
>     ...
>     _scratch_mkfs_blocksized $blksz > $seqres.full 2>&1
>     ...
>     real_blksz=$(_get_file_block_size $testdir)

Hmm... I'm wondering is it possible that g/206 need _get_block_size() at here?

Due to from the logic of _get_file_block_size() [1], extN call _get_block_size()
directly. So if you feel a specific _ext4_get_file_block_size() isn't suit for
g/206, maybe it turely want _get_block_size() at here?

[1]
_get_file_block_size()
{
        if [ -z $1 ] || [ ! -d $1 ]; then
                echo "Missing mount point argument for _get_file_block_size"
                exit 1
        fi

        case "$FSTYP" in
        "ocfs2")
                stat -c '%o' $1
                ;;
        "xfs")
                _xfs_get_file_block_size $1
                ;;
        *)
                _get_block_size $1
                ;;
        esac
}

>     test $real_blksz != $blksz && _notrun "Failed to format with small blocksize."
> 
> I assume this works for xfs because only files in the real-time block
> size will have a larger allocation unit size, but the root directory
> has a allocation unit size of the "real" block size?
> 
> I suppose I could make a hypothetical _ext4_get_file_block_size lie
> and return the "real" block size when it's called on the mount point,
> but that seems kinda of gross, and it's also a lie, since the
> allocation unit size for the root directory actually is the cluster
> size, not the block size.
> 
> If I were going to be doing things from scratch, I'd make a
> distinction between _get_file_allocation_size and
> _get_file_system_block_size, which would be a lot *clearer* about what

Currently _get_block_size is more like _get_file_system_block_size, and
_get_file_block_size is more like _get_file_allocation_size. Actually
I'm confused about these two names before :)

> is going on.  Even then, I could imagine some tests getting confused
> with how, say, fiemap behaves with an ext4 file system with a 4k block
> size and a 64k allocation unit size, so I'm not sure it's a complete
> solution.  And doing this now would require quite a bit of code churn
> in xfstests.
> 
> > If this's helpful for your first concern [1], please tell me. Then we can talk
> > about your second concern [2], if it's still your main concern now :)
> > 
> > "This might *[1]* either be because the test didn't know about ext4
> >  bigalloc's cluster alignment requirements, *[2]* or because a particular
> >  operation might just be *buggy* and being able to run tests as if a
> >  particular command wasn't supported was useful."
> 
> So [1] is a real concern, and at the moment, we just suppress all of
> the tests that try to use collapse/insert range.  For example, from
> the ext4/bigalloc config file:
> 
>     # Until we can teach xfstests the difference between cluster size and
>     # block size, avoid collapse_range and insert_range since these will
>     # fail due the fact that these operations require cluster-aligned
>     # ranges.
>     export FSX_AVOID="-C -I"
>     export FSSTRESS_AVOID="-f collapse=0 -f insert=0"
>     export XFS_IO_AVOID="fcollapse finsert"
>     TEST_SET_EXCLUDE="-x collapse,insert"

Thanks for pointing this out, I'll help to check all fcollapse and finsert
related cases, and add them into collapse or insert group. We're keep improving
group problem, most of cases really not take too much care about its group.
And I'll pay more attention about the groups when I review patches.

> 
> That's not ideal, and it's been on my todo list to try to fix it, when
> I could get one of those round tuit's.  However, I had assumed that we
> would split _get_file_block_size somehow, given the observation I've
> made above.  So this was always been something that has put me off,
> because it looked like a much larger project than say, "gee, I have an
> hour or two on a weekend, let me see if I can fix this".

I'd like to help your team to deal with the fstests problems you hit in your
using procedure, feel free to tell us the part you hope to fix/improve. I
have to care about other teams too, so might need more time to evaluate and
talk, sorry about that.

> 
> [2] is practically not _really_ a concern any more.  It used to be
> that one of the ways that I would root cause a failing test was to
> suppress one of the advanced fallocate modes, whether it be
> collapse/insert range, or going even further back, punch hole.  If
> test then passed, then I could say, "ah, hah; the problem can probably
> be localized to a certain part of the fs code."
> 
> However, that's mainly tests that are using fsstress and fsx, and we
> have solutions for that.  And for other tests, I can examine the test
> and see whether or not it's using collapse/insert range by inspection,
> so it's really not that big of a deal.  I could imagine other file
> systems who might find this useful in the future, if they were trying
> to growing support for the more advanced fallocate modes --- but that
> wouldn't *my* concern, and arguably those file systems could solve
> problems alternate ways, such as having mount options that suppress
> those fallocate modes entirely which could be used when running
> xfstests.
> 
> 						- Ted
> 
> P.S.  I have noticed some tests that use collapse/insert range but
> don't declare that they are in the collapse or insert groups.
> Fortunately, all of these tests are also in the clone group, and so
> they don't apply to ext4, so _I_ don't care.  :-)

Thanks, I'll try to check all collapse/insert related cases.

Thanks,
Zorro

> 

