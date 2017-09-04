Received: from mx1.redhat.com ([209.132.183.28]:38566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbdIDIHi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 4 Sep 2017 04:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4394C806A1
        for <fstests@vger.kernel.org>; Mon,  4 Sep 2017 08:07:38 +0000 (UTC)
Received: from localhost (dhcp-12-147.nay.redhat.com [10.66.12.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96DA87F547
        for <fstests@vger.kernel.org>; Mon,  4 Sep 2017 08:07:37 +0000 (UTC)
Date: Mon, 4 Sep 2017 16:07:36 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 948b1881f6ee
Message-ID: <20170904080736.GX27835@eguan.usersys.redhat.com>
References: <59ac1041.1389620a.c9918.3905@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ac1041.1389620a.c9918.3905@mx.google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 03, 2017 at 10:22:52PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. Notably, fsx was fixed so that random seed could do its
> work, previously all tests ran fsx were running the same operation sequences.
> And fsstress was fixed so that it could run direct I/O on non-XFS filesystems.
> These two widely used test programs are changing there behaviors, so there're
> changes new bugs can be found, though I didn't see any in my release testing.
> Other commits are normal new tests, bug fixes and improvements.
> 
> It was a busy week last week, many patches were posted for review, 20 of them
> are reviewed & accepted in this update. Thanks a lot to who have contributed
> patches and/or helped review patches. But there're still some outstanding
> patches waiting for review, especially patches from Amir/Josef that add power
> failure test frame work using dm-log-write target. Hopefully I'll get them
> reviewed in the comming week.
> 
> Though there're many updates, I didn't see any new failures in auto group when
> running tests with 4.13-rc7 kernel and for-next branch of upstream xfsprogs. If

Sorry, this is wrong. generic/451 may fail on XFS and extN filesystems,
the fix is already reviewed in fsdevel list. And generic/452 fails with
dax mounted extN filesystems (driven by ext4 driver).

I updated my test description file but forgot to point the jobs to fetch
from the test branch of my internal fstests git repo, so I tested
against master branch which didn't contain the new commits.. I've fixed
up my test description file now.

Thanks,
Eryu
