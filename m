Return-Path: <SRS0=39K/=5Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E922C2D0EE
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93F020658
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 09:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgCaJU0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731846AbgCaJOh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 31 Mar 2020 05:14:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CF5CABAE;
        Tue, 31 Mar 2020 09:14:36 +0000 (UTC)
Received: from localhost (webern.olymp [local])
        by webern.olymp (OpenSMTPD) with ESMTPA id e70b585e;
        Tue, 31 Mar 2020 10:14:35 +0100 (WEST)
Date:   Tue, 31 Mar 2020 10:14:35 +0100
From:   Luis Henriques <lhenriques@suse.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/258: check filesystem support for negative
 timestamps
Message-ID: <20200331091435.GA90121@suse.com>
References: <20200304161120.25764-1-lhenriques@suse.com>
 <CAOQ4uxjZTV6oZ426WSemigcaT=avF8V19bJU45L9=CHH8ZsFzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjZTV6oZ426WSemigcaT=avF8V19bJU45L9=CHH8ZsFzQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 04, 2020 at 08:28:40PM +0200, Amir Goldstein wrote:
> On Wed, Mar 4, 2020 at 6:11 PM Luis Henriques <lhenriques@suse.com> wrote:
> >
> > Some filesystems do not support negative c/m/atime timestamps.  And for
> > these filesystems, generic/258 will fail.  Since there's currently no way
> > to check sb->s_time_min from userspace, this patch adds a new common/rc
> > function _require_negative_timestamps() that will _notrun depending on the
> > $FSTYP variable.
> >
> > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> 
> Looks fine,
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Hi Eryu,

I forgot Cc'ing you in the initial email.  Has this patch fell between the
cracks, or is it not really acceptable?

Cheers,
--
Luis

> 
> > ---
> > Hi!
> >
> > I'm only adding 'ceph' to the _require_negative_timestamps() case because
> > that was the only filesystem with s_time_min = 0 that I was able to test.
> > However, a simple grep indicates there are a few other filesystems that
> > would also be required there (e.g. nfs version < 4).
> >
> > Cheers,
> > --
> > Luis
> >
> >  common/rc         | 8 ++++++++
> >  tests/generic/258 | 1 +
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/common/rc b/common/rc
> > index 0306e93cb1ca..067f30cecde7 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4157,6 +4157,14 @@ _check_xfs_scrub_does_unicode() {
> >         return 0
> >  }
> >
> > +_require_negative_timestamps() {
> > +       case "$FSTYP" in
> > +       ceph)
> > +               _notrun "$FSTYP does not support negative timestamps"
> > +               ;;
> > +       esac
> > +}
> > +
> >  init_rc
> >
> >  ################################################################################
> > diff --git a/tests/generic/258 b/tests/generic/258
> > index 68b8155d4a9f..dab1a476ed20 100755
> > --- a/tests/generic/258
> > +++ b/tests/generic/258
> > @@ -30,6 +30,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
> >  _supported_fs generic
> >  _supported_os Linux
> >  _require_test
> > +_require_negative_timestamps
> >
> >  TESTFILE=$TEST_DIR/timestamp-test.txt
> >
