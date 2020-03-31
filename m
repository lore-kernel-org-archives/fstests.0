Return-Path: <SRS0=39K/=5Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06E3C43331
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C84F20675
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 12:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgCaMeB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:34:01 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60109 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730562AbgCaMeB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Mar 2020 08:34:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tu9aBIb_1585658023;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Tu9aBIb_1585658023)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Mar 2020 20:33:44 +0800
Date:   Tue, 31 Mar 2020 20:33:43 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, Goldstein <amir73il@gmail.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/258: check filesystem support for negative
 timestamps
Message-ID: <20200331123343.GJ47669@e18g06458.et15sqa>
References: <20200304161120.25764-1-lhenriques@suse.com>
 <CAOQ4uxjZTV6oZ426WSemigcaT=avF8V19bJU45L9=CHH8ZsFzQ@mail.gmail.com>
 <20200331091435.GA90121@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331091435.GA90121@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 31, 2020 at 10:14:35AM +0100, Luis Henriques wrote:
> On Wed, Mar 04, 2020 at 08:28:40PM +0200, Amir Goldstein wrote:
> > On Wed, Mar 4, 2020 at 6:11 PM Luis Henriques <lhenriques@suse.com> wrote:
> > >
> > > Some filesystems do not support negative c/m/atime timestamps.  And for
> > > these filesystems, generic/258 will fail.  Since there's currently no way
> > > to check sb->s_time_min from userspace, this patch adds a new common/rc
> > > function _require_negative_timestamps() that will _notrun depending on the
> > > $FSTYP variable.
> > >
> > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > 
> > Looks fine,
> > 
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Hi Eryu,
> 
> I forgot Cc'ing you in the initial email.  Has this patch fell between the
> cracks, or is it not really acceptable?

I missed it totally.. Thanks for the heads up! I'll pick it up in this
week's update.

Thanks,
Eryu

> 
> Cheers,
> --
> Luis
> 
> > 
> > > ---
> > > Hi!
> > >
> > > I'm only adding 'ceph' to the _require_negative_timestamps() case because
> > > that was the only filesystem with s_time_min = 0 that I was able to test.
> > > However, a simple grep indicates there are a few other filesystems that
> > > would also be required there (e.g. nfs version < 4).
> > >
> > > Cheers,
> > > --
> > > Luis
> > >
> > >  common/rc         | 8 ++++++++
> > >  tests/generic/258 | 1 +
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 0306e93cb1ca..067f30cecde7 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -4157,6 +4157,14 @@ _check_xfs_scrub_does_unicode() {
> > >         return 0
> > >  }
> > >
> > > +_require_negative_timestamps() {
> > > +       case "$FSTYP" in
> > > +       ceph)
> > > +               _notrun "$FSTYP does not support negative timestamps"
> > > +               ;;
> > > +       esac
> > > +}
> > > +
> > >  init_rc
> > >
> > >  ################################################################################
> > > diff --git a/tests/generic/258 b/tests/generic/258
> > > index 68b8155d4a9f..dab1a476ed20 100755
> > > --- a/tests/generic/258
> > > +++ b/tests/generic/258
> > > @@ -30,6 +30,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
> > >  _supported_fs generic
> > >  _supported_os Linux
> > >  _require_test
> > > +_require_negative_timestamps
> > >
> > >  TESTFILE=$TEST_DIR/timestamp-test.txt
> > >
