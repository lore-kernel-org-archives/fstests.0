Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF8C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Dec 2021 19:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhLOTDn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 14:03:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56026 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbhLOTDn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 14:03:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F29E8B81999
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 19:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D641C36AE2;
        Wed, 15 Dec 2021 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639595020;
        bh=w41nSjpMh+jAROO0LGalmMiKkrEPkxYmgqBZ6M9SvH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FvaGlmq7SUdErUNwv5bBEvqzhFX+g1yTESXKNqR6CX0sZxasZFVJeqoZXzo/5msDX
         opHp4R6QRG1hWVvvmF4U2xLq9Z+NB5UyIRMGYZLiCf2gPfpmMTUmgJP4pF+8uT7V7/
         FgzeBCyFgyPXoa+26yflfRr9d2EvkWJtvLKEnlsNuKfLrSl4EY2upD3/Av/hGOP4K7
         eD+8zuavnEhEsHqXwicg5boiFSjaas9QTyTgEc2xGdkkCYGyyZ1ul9kyFWSLVNm5Qa
         io5qsG+EjfwW+ulADy/TRXA2Wd6KFWpj8VMeJm5m00gsp/xRQULJ1Fc8s+S6mkyH06
         5VGMVoQl9l+Ew==
Message-ID: <5bab26b704ab5012df97d298909c6a84a69475d0.camel@kernel.org>
Subject: Re: [PATCH] common/rc, ceph: add _require_not_encrypted test
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org
Date:   Wed, 15 Dec 2021 14:03:39 -0500
In-Reply-To: <YboRRjoPEVkdrzwe@suse.de>
References: <20211215142047.66403-1-jlayton@kernel.org>
         <YboRRjoPEVkdrzwe@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 2021-12-15 at 16:01 +0000, Luís Henriques wrote:
> Hi Jeff,
> 
> On Wed, Dec 15, 2021 at 09:20:47AM -0500, Jeff Layton wrote:
> > Some tests on ceph require changing the layout of new files, which is
> > forbidden when the files are encrypted. Add a test that touches a file
> > in $TEST_DIR and then tests it to see if it reports the
> > STATX_ATTR_ENCRYPTED flag, and does a _notrun if it's present.
> > 
> > Also add this requirement to the two ceph tests that change the layout.
> 
> Aren't you forgetting ceph/001?
> 
> > Cc: Luis Henriques <lhenriques@suse.de>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  common/rc      | 17 +++++++++++++++++
> >  tests/ceph/002 |  1 +
> >  tests/ceph/003 |  1 +
> >  3 files changed, 19 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 7973ceb5fdf8..9165325dc478 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4782,6 +4782,23 @@ _require_kernel_config()
> >  	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
> >  }
> >  
> > +_require_not_encrypted()
> > +{
> > +	local target=$TEST_DIR/require_not_encrypted.$$
> > +	local ret=0
> > +
> > +	#
> > +	# The top-level directory mounted with test_dummy_encryption is not
> > +	# itself encrypted. Only new files and directories created under it
> > +	# are.
> > +	touch $target
> > +	local attrs=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
> > +	rm -f $target
> > +
> > +	# STATX_ATTR_ENCRYPTED == 0x800
> > +	[ $(( attrs & 0x800 )) -eq 0 ] || _notrun "Filesystem is encrypted"
> > +}
> > +
> 
> Maybe this function could be in the 'common/encrypt' file instead.
> 
> Other than these 2 comments, I also agree that this approach is better
> than hooking into the _ceph_create_file_layout() function.
> 
> Cheers,
> --
> Luís
> 

v3 patch sent that should address your comments.

Thanks!

> >  init_rc
> >  
> >  ################################################################################
> > diff --git a/tests/ceph/002 b/tests/ceph/002
> > index 9bc728fd2e18..be5c0f8c644d 100755
> > --- a/tests/ceph/002
> > +++ b/tests/ceph/002
> > @@ -30,6 +30,7 @@ _begin_fstest auto quick copy_range
> >  _supported_fs ceph
> >  
> >  _require_xfs_io_command "copy_range"
> > +_require_not_encrypted
> >  _require_attrs
> >  _require_test
> >  
> > diff --git a/tests/ceph/003 b/tests/ceph/003
> > index faedb48cfeea..c8aefc4ad06f 100755
> > --- a/tests/ceph/003
> > +++ b/tests/ceph/003
> > @@ -18,6 +18,7 @@ _begin_fstest auto quick copy_range
> >  _supported_fs ceph
> >  
> >  _require_xfs_io_command "copy_range"
> > +_require_not_encrypted
> >  _require_attrs
> >  _require_test
> >  
> > -- 
> > 2.33.1
> > 

-- 
Jeff Layton <jlayton@kernel.org>
