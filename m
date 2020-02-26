Return-Path: <SRS0=K+9V=4O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26678C4BA12
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03BC24680
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6pRUoMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBZPWh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:22:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727023AbgBZPWh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Feb 2020 10:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582730556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4cWIYlE0cDTSfrmMYy1vHSCG7GzFaSdgArNXnl0b/ak=;
        b=i6pRUoMdweQ4fOmw8DalFxxETQknf7dKe3E32k+RyILAJhTdd3ywob6ZKwvbmrKVXiA3NW
        6uUxPK8MaROM5gAQY26wnixRxvFUzh47dae/ktKZQ8YQdNvGzt58ZAvkz5qt9QHQ1yF92b
        vtU/6O38aw1yqHc0UalisYybrnBPVj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-Ei278edqN_GYJwpGh7fktw-1; Wed, 26 Feb 2020 10:22:31 -0500
X-MC-Unique: Ei278edqN_GYJwpGh7fktw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E7F51902EA7;
        Wed, 26 Feb 2020 15:22:30 +0000 (UTC)
Received: from localhost (dhcp-12-196.nay.redhat.com [10.66.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 033CC5D9CD;
        Wed, 26 Feb 2020 15:22:29 +0000 (UTC)
Date:   Wed, 26 Feb 2020 23:22:28 +0800
From:   Murphy Zhou <xzhou@redhat.com>
To:     xzhou@redhat.com, fstests@vger.kernel.org, jlayton@kernel.org,
        hristoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xfstests: remove generic/484
Message-ID: <20200226152228.wvirdfawhgrvdt5e@xzhoux.usersys.redhat.com>
References: <20200224222926.694991-1-hch@lst.de>
 <20200226075009.GT14282@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226075009.GT14282@dhcp-12-102.nay.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 26, 2020 at 03:50:09PM +0800, Zorro Lang wrote:
> On Mon, Feb 24, 2020 at 02:29:26PM -0800, Christoph Hellwig wrote:
> > Generic/484 tests functionality that isn't really related to file
> > systems, and has failed every since it was added.  Remove it as it
> > serves no puropse in xfstests.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> CC the original author of this case. To make sure if he has more
> opinions about this change, and if he'd like to shift it to LTP
> if xfstests decides to remove this case at last.

Okay for me to remove it. It seems very hard to fix.

I'll try LTP, :)

Thanks.
> 
> >  tests/generic/484     | 51 -------------------------------------------
> >  tests/generic/484.out |  2 --
> >  tests/generic/group   |  1 -
> >  3 files changed, 54 deletions(-)
> >  delete mode 100755 tests/generic/484
> >  delete mode 100644 tests/generic/484.out
> > 
> > diff --git a/tests/generic/484 b/tests/generic/484
> > deleted file mode 100755
> > index d83380ac..00000000
> > --- a/tests/generic/484
> > +++ /dev/null
> > @@ -1,51 +0,0 @@
> > -#! /bin/bash
> > -# SPDX-License-Identifier: GPL-2.0
> > -# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
> > -#
> > -# FS QA Test 484
> > -#
> > -# POSIX requires that record locks are preserved across an execve(2). But
> > -# there's bug that record locks are released if process is multithreaded at the
> > -# time that execve is called.
> > -#
> > -# Fixed by patch from Jeff Layton:
> > -# locks: change POSIX lock ownership on execve when files_struct is displaced
> > -#
> > -seq=`basename $0`
> > -seqres=$RESULT_DIR/$seq
> > -echo "QA output created by $seq"
> > -
> > -here=`pwd`
> > -tmp=/tmp/$$
> > -status=1	# failure is the default!
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> > -
> > -_cleanup()
> > -{
> > -	cd /
> > -	rm -f $tmp.*
> > -}
> > -
> > -# get standard environment, filters and checks
> > -. ./common/rc
> > -. ./common/filter
> > -
> > -# remove previous $seqres.full before test
> > -rm -f $seqres.full
> > -
> > -# real QA test starts here
> > -_supported_fs generic
> > -_supported_os Linux
> > -_require_test
> > -_require_test_program "t_locks_execve"
> > -
> > -# prepare a 4k testfile in TEST_DIR
> > -$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> > -	$TEST_DIR/t_lock_execve_file >> $seqres.full 2>&1
> > -
> > -$here/src/t_locks_execve $TEST_DIR/t_lock_execve_file
> > -
> > -# success, all done
> > -echo "Silence is golden"
> > -status=0
> > -exit
> > diff --git a/tests/generic/484.out b/tests/generic/484.out
> > deleted file mode 100644
> > index 94f2f0bd..00000000
> > --- a/tests/generic/484.out
> > +++ /dev/null
> > @@ -1,2 +0,0 @@
> > -QA output created by 484
> > -Silence is golden
> > diff --git a/tests/generic/group b/tests/generic/group
> > index ff79a597..dc95b77b 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -486,7 +486,6 @@
> >  481 auto quick log metadata
> >  482 auto metadata replay
> >  483 auto quick log metadata
> > -484 auto quick
> >  485 auto quick insert
> >  486 auto quick attr
> >  487 auto quick eio
> > -- 
> > 2.24.1
> > 

-- 
Murphy

