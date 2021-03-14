Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E2C433E6
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 14:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D5A64EEC
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 14:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCNOQs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Mar 2021 10:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232431AbhCNOQi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Mar 2021 10:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615731397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/G4uFTWAA86FO4d1uqX0bwxWej8l95TkjnAhwbMm0ps=;
        b=MHJ294F9cTnlTT1ZrWXi19GU/A9c/1NMSUZWmJPQ6VkZheEXMHMmIWeSqJBBHurCrAntzV
        2SXsi3MYYFCe5BdeZsIl5T3rUhSd7c0OGqUJwNyOAfe3OfAzn7NIWsVL20nHApRVe0azqT
        E8YP+G3c7DJ90F2vcPgXsr6ZAKWEf0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-QPYS8XGiMQ6YFcVMpUnR5g-1; Sun, 14 Mar 2021 10:16:33 -0400
X-MC-Unique: QPYS8XGiMQ6YFcVMpUnR5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B010E8015BD;
        Sun, 14 Mar 2021 14:16:32 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2760460861;
        Sun, 14 Mar 2021 14:16:31 +0000 (UTC)
Date:   Sun, 14 Mar 2021 22:34:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: specifically make new xfs in _test_mkfs
Message-ID: <20210314143458.GM3499219@localhost.localdomain>
Mail-Followup-To: Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
References: <20210311121213.1348303-1-zlang@redhat.com>
 <YE32jkUjOxc0pc1Z@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE32jkUjOxc0pc1Z@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 14, 2021 at 07:42:06PM +0800, Eryu Guan wrote:
> On Thu, Mar 11, 2021 at 08:12:13PM +0800, Zorro Lang wrote:
> > When we test different filesystems with different sections in config
> > file, always hit below failure:
> >    ...
> >    our local _test_mkfs routine ...
> >    mkfs.xfs: /dev/vdb1 appears to contain an existing filesystem (xfs)
> >    mkfs.xfs: Use the -f option to force overwrite.
> >    check: failed to mkfs $TEST_DEV using specified options
> >    ...
> > 
> > To fix this problem, change the _test_mkfs to deal with xfs creation
> > properly. Due to xfstests uses _test_mkfs rarely, currently only in
> > check program, so I don't intend to write a whole new series of
> > _test_mkfs_xfs_* functions likes what _scratch_mkfs_xfs_* does.
> > 
> > Reported-by: Carlos Maiolino <cmaiolino@redhat.com>
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> I also have defined different test sections in config file to test
> different filesysms, but I didn't hit this failure. And it turns out
> that I have "-f" in MKFS_OPTIONS, e.g.
> 
> 	[xfs_prjquota_crc]
> 	FSTYP=xfs
> 	MKFS_OPTIONS="-f -b size=4k -m crc=1"
> 	MOUNT_OPTIONS="-o prjquota"
> 
> 	[xfs_allquota_reflink]
> 	FSTYP=xfs
> 	MKFS_OPTIONS="-f -b size=4k -m crc=1,reflink=1,rmapbt=1"
> 	MOUNT_OPTIONS="-o usrquota,grpquota,prjquota"

Yes, set "-f" in MKFS_OPTIONS will help.

BTW, according to below logic:

    if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
        ...
        if ! _test_mkfs >$tmp.err 2>&1

Your TEST_DEV might not be re-created, except you set RECREATE_TEST_DEV=ture.
I hit this failure due to I set:
[ext4]
FSTYP=ext4
...

[xfs]
FSTYP=xfs
...

And ext4 use "-F" by default, but xfs doesn't.

    ext2|ext3|ext4)
        $MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV

This patch isn't necessary, due to there's workaround. I'm fine if you'd like
to Nack it.

Thanks,
Zorro

> 
> And I think that's the way to fix it.
> 
> Thanks,
> Eryu
> 
> > ---
> >  common/rc | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 0ce3cb0d..c783def7 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -258,6 +258,7 @@ _test_options()
> >  
> >      case $type in
> >      mkfs)
> > +	TEST_OPTIONS="$TEST_OPTIONS -f"
> >  	rt_opt="-r"
> >          log_opt="-l"
> >  	;;
> > @@ -633,6 +634,15 @@ _test_mkfs()
> >      ext2|ext3|ext4)
> >  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> >  	;;
> > +    xfs)
> > +	local mkfs_opts=$*
> > +
> > +	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
> > +		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+\S\+//g"`
> > +	fi
> > +	_test_options mkfs
> > +	$MKFS_XFS_PROG $TEST_OPTIONS $MKFS_OPTIONS $mkfs_opts $TEST_DEV
> > +	;;
> >      *)
> >  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> >  	;;
> > -- 
> > 2.29.2
> 

