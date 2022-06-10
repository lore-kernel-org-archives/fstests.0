Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18689C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jun 2022 05:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbiFJFMI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Jun 2022 01:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiFJFMF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Jun 2022 01:12:05 -0400
Received: from out20-87.mail.aliyun.com (out20-87.mail.aliyun.com [115.124.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979951C4B10
        for <fstests@vger.kernel.org>; Thu,  9 Jun 2022 22:12:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04801152|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0886555-0.00258385-0.908761;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.O1S0Stv_1654837919;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O1S0Stv_1654837919)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 13:11:59 +0800
Date:   Fri, 10 Jun 2022 13:12:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/297: fix the delta time based on stat
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
In-Reply-To: <20220610050302.GX1098723@dread.disaster.area>
References: <20220610123623.D773.409509F4@e16-tech.com> <20220610050302.GX1098723@dread.disaster.area>
Message-Id: <20220610131203.887B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

> On Fri, Jun 10, 2022 at 12:36:24PM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > On Fri, Jun 10, 2022 at 10:35:53AM +0800, Wang Yugui wrote:
> > > > stat -c '%Y' report seconds as int, so the delta 2.01s may result as 3s.
> > > > 
> > > > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > > > ---
> > > >  tests/generic/297 | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tests/generic/297 b/tests/generic/297
> > > > index 6bdc3e1c..e3082202 100755
> > > > --- a/tests/generic/297
> > > > +++ b/tests/generic/297
> > > > @@ -51,7 +51,7 @@ for i in $(seq 0 $fnr); do
> > > >  	touch $TEST_DIR/after
> > > >  	before=$(stat -c '%Y' $TEST_DIR/before)
> > > >  	after=$(stat -c '%Y' $TEST_DIR/after)
> > > > -	delta=$((after - before))
> > > > +	delta=$((after - before -1)) # 2.01s may result as 3s; so -1
> > > 
> > > What issue is this change trying to fix? "timeout=8"s is not long enough?
> > 
> > for the command
> > $TIMEOUT_PROG -s INT ${kill_after}s
> > 
> > delta=$((after - before )) may report 'kill_after+1' in some case.
> 
> Yes, that's what it is supposed to report. The process is
> killed 2s after the test starts, so delta is going to be kill_after
> + the delay for the task to exit and the 'touch $TEST_DIR/after'
> command to run. This can take a second or two, depending on how fast
> the reflink operation is proceeding (e.g. waiting on IO).
> 
> > so no relationship to "timeout=8" or "timeout=2".
> 
> If the reflink doesn't get killed within 6s then delta will be
> greater than the timeout (8) and the test fails. So if delta is 2 or
> 3, then it makes no difference to the test result, right?
> 
> > '$XFS_IO_PROG -f -c reflink' without '$TIMEOUT_PROG -s INT ${kill_after}s'
> > may take 20s because this is a very complex reflink.
> 
> Yes, and if it takes 20s (i.e. delta=20s) then it means that the
> kill signal was not delivered and acted upon correctly and so the
> test should fail.

If we want to detect the 'timeout', a simple way it to check
the return value of '$TIMEOUT_PROG '

#timeout exit with status 124.

now we just fix this delta value error because of float/int.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/10


