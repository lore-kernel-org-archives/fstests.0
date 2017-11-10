Received: from mx1.redhat.com ([209.132.183.28]:54656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbdKJGuH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Nov 2017 01:50:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EEF77EAA1
        for <fstests@vger.kernel.org>; Fri, 10 Nov 2017 06:50:07 +0000 (UTC)
Date: Fri, 10 Nov 2017 14:50:05 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/252: fix aiocp buffer alignment
Message-ID: <20171110065005.GX21475@dhcp12-143.nay.redhat.com>
References: <20171109080901.11214-1-zlang@redhat.com>
 <20171110045444.GA17339@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171110045444.GA17339@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 10, 2017 at 12:54:44PM +0800, Eryu Guan wrote:
> On Thu, Nov 09, 2017 at 04:09:01PM +0800, Zorro Lang wrote:
> > g/252 fails on 4k hard sector size disk, due to aiocp.c use 512
> > bytes alignment by default. So use the '-a' option of aiocp, to
> > specify a proper alignment size.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> There're other tests that calls aiocp with direct I/O, I think they can
> be fixed too in one patch.
> 
> $ grep -H DIRECT `grep aiocp tests/* -rI | cut -d: -f1 | sort | uniq`
> tests/generic/252:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
> tests/generic/329:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
> tests/generic/330:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
> tests/xfs/237:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
> tests/xfs/239:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full

OK, I'm going to look into them, to see if there's a better way to fix them all.

> 
> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
