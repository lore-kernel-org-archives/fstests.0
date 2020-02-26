Return-Path: <SRS0=K+9V=4O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB3C4BA0B
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Feb 2020 07:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC2C21D7E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Feb 2020 07:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eu+p5AND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBZHjj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:39:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47241 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726903AbgBZHjj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Feb 2020 02:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582702778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRhA0nrd483E18v5kQg94BNESCEGqV9c1eIWV3FQHu4=;
        b=Eu+p5AND2BRbcg5g27KIQWb0o9PtANbcKXPHXUJ5i0NQOhstcHrXu2QOUypvHHyG5v8nrn
        CQnm5mQeRuAnsyQMi6npk3UH9woBZ+FBKtaTDmH/HICsmjSbQbSGXhVQX/VWUw3COU/KWI
        OpBs2go4frYXervv++c0Red4uu3VsTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-NDrZfCpfPi6nzwJDsbEByw-1; Wed, 26 Feb 2020 02:39:36 -0500
X-MC-Unique: NDrZfCpfPi6nzwJDsbEByw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81F91800EBB;
        Wed, 26 Feb 2020 07:39:35 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB77C909E9;
        Wed, 26 Feb 2020 07:39:34 +0000 (UTC)
Date:   Wed, 26 Feb 2020 15:50:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xzhou@redhat.com
Cc:     fstests@vger.kernel.org, jlayton@kernel.org,
        hristoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xfstests: remove generic/484
Message-ID: <20200226075009.GT14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: xzhou@redhat.com, fstests@vger.kernel.org,
        jlayton@kernel.org, hristoph Hellwig <hch@lst.de>
References: <20200224222926.694991-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224222926.694991-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 24, 2020 at 02:29:26PM -0800, Christoph Hellwig wrote:
> Generic/484 tests functionality that isn't really related to file
> systems, and has failed every since it was added.  Remove it as it
> serves no puropse in xfstests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

CC the original author of this case. To make sure if he has more
opinions about this change, and if he'd like to shift it to LTP
if xfstests decides to remove this case at last.

>  tests/generic/484     | 51 -------------------------------------------
>  tests/generic/484.out |  2 --
>  tests/generic/group   |  1 -
>  3 files changed, 54 deletions(-)
>  delete mode 100755 tests/generic/484
>  delete mode 100644 tests/generic/484.out
> 
> diff --git a/tests/generic/484 b/tests/generic/484
> deleted file mode 100755
> index d83380ac..00000000
> --- a/tests/generic/484
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
> -#
> -# FS QA Test 484
> -#
> -# POSIX requires that record locks are preserved across an execve(2). But
> -# there's bug that record locks are released if process is multithreaded at the
> -# time that execve is called.
> -#
> -# Fixed by patch from Jeff Layton:
> -# locks: change POSIX lock ownership on execve when files_struct is displaced
> -#
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> -
> -here=`pwd`
> -tmp=/tmp/$$
> -status=1	# failure is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -}
> -
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> -
> -# remove previous $seqres.full before test
> -rm -f $seqres.full
> -
> -# real QA test starts here
> -_supported_fs generic
> -_supported_os Linux
> -_require_test
> -_require_test_program "t_locks_execve"
> -
> -# prepare a 4k testfile in TEST_DIR
> -$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> -	$TEST_DIR/t_lock_execve_file >> $seqres.full 2>&1
> -
> -$here/src/t_locks_execve $TEST_DIR/t_lock_execve_file
> -
> -# success, all done
> -echo "Silence is golden"
> -status=0
> -exit
> diff --git a/tests/generic/484.out b/tests/generic/484.out
> deleted file mode 100644
> index 94f2f0bd..00000000
> --- a/tests/generic/484.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 484
> -Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index ff79a597..dc95b77b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -486,7 +486,6 @@
>  481 auto quick log metadata
>  482 auto metadata replay
>  483 auto quick log metadata
> -484 auto quick
>  485 auto quick insert
>  486 auto quick attr
>  487 auto quick eio
> -- 
> 2.24.1
> 

