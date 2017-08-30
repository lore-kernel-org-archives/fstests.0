Received: from mx1.redhat.com ([209.132.183.28]:33312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbdH3LJg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 30 Aug 2017 07:09:36 -0400
Date: Wed, 30 Aug 2017 19:09:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] btrfs/029: fix wrong usage of name filter
Message-ID: <20170830110934.GF27835@eguan.usersys.redhat.com>
References: <2a13313b-d8f5-b6fd-58cb-72e05f5925c9@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a13313b-d8f5-b6fd-58cb-72e05f5925c9@jp.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 30, 2017 at 04:38:16PM +0900, Misono, Tomohiro wrote:
> btrfs/029 uses _filter_testdirs() to filter the name of $TEST_DIR and
> $SCRATCH_MNT directory.
> 
> In this function, it calls both _filter_test_dir and _filter_scratch
> concatenated by pipe. Therefore if $TEST_DIR is a prefix of
> $SCRATCH_MNT, this filter function gives wrong filtered name for
> $SCRATCH_MNT and the test fails.

Sorry, I'm a bit confused, how could $TEST_DIR be a prefix of
$SCRATCH_MNT? Won't that fail the test at setup time?

Thanks,
Eryu
