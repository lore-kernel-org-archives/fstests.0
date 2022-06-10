Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F280EC43334
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jun 2022 04:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiFJEgq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Jun 2022 00:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiFJEgp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Jun 2022 00:36:45 -0400
Received: from out20-37.mail.aliyun.com (out20-37.mail.aliyun.com [115.124.20.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE26B7F9
        for <fstests@vger.kernel.org>; Thu,  9 Jun 2022 21:36:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1573701|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.052543-0.00614935-0.941308;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.O1RQ2rh_1654835780;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O1RQ2rh_1654835780)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 12:36:20 +0800
Date:   Fri, 10 Jun 2022 12:36:24 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/297: fix the delta time based on stat
Cc:     fstests@vger.kernel.org
In-Reply-To: <20220610042405.z2ou4uwwgoiympxx@zlang-mailbox>
References: <20220610023553.24418-1-wangyugui@e16-tech.com> <20220610042405.z2ou4uwwgoiympxx@zlang-mailbox>
Message-Id: <20220610123623.D773.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

> On Fri, Jun 10, 2022 at 10:35:53AM +0800, Wang Yugui wrote:
> > stat -c '%Y' report seconds as int, so the delta 2.01s may result as 3s.
> > 
> > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > ---
> >  tests/generic/297 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/generic/297 b/tests/generic/297
> > index 6bdc3e1c..e3082202 100755
> > --- a/tests/generic/297
> > +++ b/tests/generic/297
> > @@ -51,7 +51,7 @@ for i in $(seq 0 $fnr); do
> >  	touch $TEST_DIR/after
> >  	before=$(stat -c '%Y' $TEST_DIR/before)
> >  	after=$(stat -c '%Y' $TEST_DIR/after)
> > -	delta=$((after - before))
> > +	delta=$((after - before -1)) # 2.01s may result as 3s; so -1
> 
> What issue is this change trying to fix? "timeout=8"s is not long enough?

for the command
$TIMEOUT_PROG -s INT ${kill_after}s

delta=$((after - before )) may report 'kill_after+1' in some case.

so no relationship to "timeout=8" or "timeout=2".

'$XFS_IO_PROG -f -c reflink' without '$TIMEOUT_PROG -s INT ${kill_after}s'
may take 20s because this is a very complex reflink.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/10



