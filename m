Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E8C4338F
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 00:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D85610CE
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Aug 2021 00:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHTAeS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAeS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 20:34:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C44AC061575;
        Thu, 19 Aug 2021 17:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lunfNodRn/PF1/duP/1ysZWMbtVeDKqu+cHsDFKH0B4=; b=SJTAHbP51t7ci0x3tjpnZrGbKI
        YArxhUaKq9w5pI2v1LeGzxPW+Jm/HqhyAFoqZH5QiDqzHcXHR2vtzwprPjT5iRLIIMLWrDDGRGY93
        laY8BPNZ5GhCttE+M5qU+x7SW7zwqnGVo10XW2aEqU7bawVLk72MePjrW+9lWZaipODHApDwpb9yn
        YhjKOl94BFurobd3N9Fr08/IyiDmiKbE3i3lFE7mqf3inx1+TklY5/HEl04SGBuSp529r2tuF8G8v
        TT0AVrbDtBgJVVE2xFVMbRvs9nLyks5FqLOm1S7A0CcqygUk0dHFrhEZlz1Yvx0zO+vQwachfo8qW
        oOlnAiMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGsTb-009oQK-Kb; Fri, 20 Aug 2021 00:33:39 +0000
Date:   Thu, 19 Aug 2021 17:33:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, hare@suse.de, dgilbert@interlog.com,
        jeyu@kernel.org, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] common/scsi_debug: use the patient module remover
Message-ID: <YR74Y+SxIOe/Iob9@bombadil.infradead.org>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
 <20210811154512.1813622-4-mcgrof@kernel.org>
 <YRkJ9rkFPyYUy8p5@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRkJ9rkFPyYUy8p5@desktop>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Sorry for some reason I missed this email. Replies are below.

On Sun, Aug 15, 2021 at 08:35:02PM +0800, Eryu Guan wrote:
> On Wed, Aug 11, 2021 at 08:45:12AM -0700, Luis Chamberlain wrote:
> > If you try to run tests such as generic/108 in a loop
> > you'll eventually see a failure, but the failure can
> > be a false positive and the test was just unable to remove
> > the scsi_debug module.
> > 
> > We need to give some time for the refcnt to become 0. For
> > instance for the test generic/108 the refcnt lingers between
> > 2 and 1. It should be 0 when we're done but a bit of time
> > seems to be required. The chance of us trying to run rmmod
> > when the refcnt is 2 or 1 is low, about 1/30 times if you
> > run the test in a loop on linux-next today.
> > 
> > Likewise, even when its 0 we just need a tiny breather before
> > we can remove the module (sleep 10 suffices) but this is
> > only required on older kernels. Otherwise removing the module
> > will just fail.
> > 
> > Some of these races are documented on the korg#212337, and
> > Doug Gilbert has posted at least one patch attempt to try
> > to help with this [1]. The patch does not resolve all the
> > issues though, it helps though.
> > 
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
> > [1] https://lkml.kernel.org/r/20210508230745.27923-1-dgilbert@interlog.com
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  common/scsi_debug | 6 ++++--
> 
> There're also some "modprobe -r" calls in common/module, should the be
> replaced with _patient_rmmod as well?

Ah, yes well... indeed, that could very well be the case. But that
is another change. It can surely help fix quite a bit of other odd
false positives.

I would prefer if such changes would go in separately.

> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/scsi_debug b/common/scsi_debug
> > index e7988469..3c9cd820 100644
> > --- a/common/scsi_debug
> > +++ b/common/scsi_debug
> > @@ -4,11 +4,13 @@
> >  #
> >  # Functions useful for tests on unique block devices
> >  
> > +. common/module
> > +
> >  _require_scsi_debug()
> >  {
> >  	# make sure we have the module and it's not already used
> >  	modinfo scsi_debug 2>&1 > /dev/null || _notrun "scsi_debug module not found"
> > -	lsmod | grep -wq scsi_debug && (rmmod scsi_debug || _notrun "scsi_debug module in use")
> > +	lsmod | grep -wq scsi_debug && (_patient_rmmod scsi_debug || _notrun "scsi_debug module in use")
> 
> I don't think we should use _patient_rmmod here, if we set timeout to
> forever and there's actually some other process using scsi_debug module,
> we'll loop forever here. And a failure to remove scsi_debug only results
> in _notrun, and won't cause false test failure.

If one sets the timeout to forever and if the module is already loaded
and we cannot remove it, I'd say its working as intended. But indeed,
fstests does not leave modules lingering around... it would be a user
error. I'll add a special case for this.

> >  	# make sure it has the features we need
> >  	# logical/physical sectors plus unmap support all went in together
> >  	modinfo scsi_debug | grep -wq sector_size || _notrun "scsi_debug too old"
> > @@ -53,5 +55,5 @@ _put_scsi_debug_dev()
> >  		$UDEV_SETTLE_PROG
> >  		n=$((n-1))
> >  	done
> 
> I think the above while loop could be removed as well?

Good call, yeah that crap is not needed anymore. I'd still leave in
place the UDEV_SETTLE_PROG though, as I think that's good practice
and we can't loose anything. It can for instance salvage buggy
tests which forgot to use it.

 Luis
