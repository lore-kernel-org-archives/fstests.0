Received: from mx1.redhat.com ([209.132.183.28]:58772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbdBCJfa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 04:35:30 -0500
Date: Fri, 3 Feb 2017 17:35:27 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: cleanup $TEST_DIR/$seq* files
Message-ID: <20170203093527.GB1859@eguan.usersys.redhat.com>
References: <1485513589-7416-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485513589-7416-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 27, 2017 at 12:39:49PM +0200, Amir Goldstein wrote:
> Test generic/007 was failing after running test overlay/007,
> because the latter left behind a directory named 007 in test dir
> and the former failed to mkdir a directory with the same name.
> 
> Greping the tests for the pattern $TEST_DIR/$seq* found some more
> files/dirs of this sort that were not being cleaned up.
> 
> Clean those files/dir on _cleanup trap to fix the 007 tests collision
> and avoid similar collisions in future tests.
> 
> Left the directories $TEST_DIR/$seq.mnt in tact, because they are
> always empty and created with mkdir -p.
> 
> There are more files left behind as can be seen in any aged test dir.

TEST_DIR is supposed to be aged over multiple runs, so leaving test
files in it should be just fine, unless these files are consuming a lot
of free space and would block subsequent tests.

For tests that need an empty dir or a newly created file in TEST_DIR,
they could just remove the dir or file in test setup phase before doing
any actual setups.

So I think adding "-p" to mkdir command in generic/007 looks sufficient.

Thanks,
Eryu
