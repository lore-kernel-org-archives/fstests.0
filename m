Received: from mx1.redhat.com ([209.132.183.28]:33906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755871AbdKJEyq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Nov 2017 23:54:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01F14C058EB0
        for <fstests@vger.kernel.org>; Fri, 10 Nov 2017 04:54:46 +0000 (UTC)
Date: Fri, 10 Nov 2017 12:54:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/252: fix aiocp buffer alignment
Message-ID: <20171110045444.GA17339@eguan.usersys.redhat.com>
References: <20171109080901.11214-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109080901.11214-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 09, 2017 at 04:09:01PM +0800, Zorro Lang wrote:
> g/252 fails on 4k hard sector size disk, due to aiocp.c use 512
> bytes alignment by default. So use the '-a' option of aiocp, to
> specify a proper alignment size.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

There're other tests that calls aiocp with direct I/O, I think they can
be fixed too in one patch.

$ grep -H DIRECT `grep aiocp tests/* -rI | cut -d: -f1 | sort | uniq`
tests/generic/252:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
tests/generic/329:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
tests/generic/330:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
tests/xfs/237:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
tests/xfs/239:$AIO_TEST -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full

Thanks,
Eryu
