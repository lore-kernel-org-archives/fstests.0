Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B688C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 17:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbiAFRUz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiAFRUz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jan 2022 12:20:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849CFC061245
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 09:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BDB72CE2647
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 17:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208ADC36AED;
        Thu,  6 Jan 2022 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641489650;
        bh=SXCWjddbyTbBAWZW8z2W0DSYzrKubqkQRaWdUGiy8/c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HTYLueUCmGolrs7yToBZRWhxmWyKb/uIqmqwzGNJ38SCvk/q+Wj9r0KKhlpDeTHu4
         bq+MntPuyUJEiOpKa6SihkGoEp0WSr/IcEz1gX35jKKvMfUPBAlExHbVY6PUwVe48V
         dPsqpKBbH1kSV/EgUrjio/p1Xym4An7hIvm2OsGuG6CJtheYCHqRhFLKZEihTIJS8e
         zUKJzVzaxtDaR0WSROAyUBkym06gBtMv5hITk1cr2CFPnWjRMkYLoejUhZDB2BLPuS
         wfZ2asnbt3hJPXimAdvp3WFSK0g0XyZExbbYJcHwgh7KolfauEyG/rcwh7BM01VR7s
         DQl6z2bQpVVpQ==
Message-ID: <268210c68c2849a0d2d06f4150ebd934fa0647dc.camel@kernel.org>
Subject: Re: [PATCH v2] common: handle ceph's new mount syntax
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, guan@eryu.me
Date:   Thu, 06 Jan 2022 12:20:49 -0500
In-Reply-To: <20220106170956.f7bxe265wghmbqbh@zlang-mailbox>
References: <20220106112316.6790-1-jlayton@kernel.org>
         <20220106170956.f7bxe265wghmbqbh@zlang-mailbox>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, 2022-01-07 at 01:09 +0800, Zorro Lang wrote:
> On Thu, Jan 06, 2022 at 06:23:16AM -0500, Jeff Layton wrote:
> > Cephfs is introducing a new mount device syntax. Fix the fstests
> > infrastructure to handle the new syntax correctly.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  common/config |  8 ++++++++
> >  common/rc     | 34 ++++++++++++++++++++++++++++++++--
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> > 
> > v2: more rigorous check for ceph mount device in _check_device
> > 
> > diff --git a/common/config b/common/config
> > index e0a5c5df58ff..2b357746476b 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -537,6 +537,14 @@ _check_device()
> >  		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
> >  		# tmpfs doesn't use mount source, ignore
> >  		;;
> > +	ceph)
> > +		# ceph has two different possible syntaxes for mount devices. The
> > +		# network URL check above catches the legacy syntax. Check for the
> > +		# new-style syntax here.
> > +		if ( echo $dev | grep -qEv "=/" ); then
> > +			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
> > +		fi
> > +		;;
> 
> I have not objection with this, if the maintainer prefer:
> 
> -       if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
> +       if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//|=/" ); then
>                 # block device or a network url
>                 return 0
>         fi
> 

The "=/" part of the syntax is (so far) ceph-specific. I don't think we
want to accept that for (e.g.) NFS, so it's probably best to allow that
only when FSTYP=ceph.

> >  	overlay)
> >  		if [ ! -d "$dev" ]; then
> >  			_fatal "common/config: $name ($dev) is not a directory for overlay"
> > diff --git a/common/rc b/common/rc
> > index 7973ceb5fdf8..4fa0b818d840 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1592,7 +1592,7 @@ _require_scratch_nocheck()
> >  			_notrun "this test requires a valid \$SCRATCH_MNT"
> >  		fi
> >  		;;
> > -	nfs*|ceph)
> > +	nfs*)
> >  		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
> >  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> >  			_notrun "this test requires a valid \$SCRATCH_DEV"
> > @@ -1601,6 +1601,21 @@ _require_scratch_nocheck()
> >  			_notrun "this test requires a valid \$SCRATCH_MNT"
> >  		fi
> >  		;;
> > +	ceph)
> > +		if [ -z "$SCRATCH_DEV" ]; then
> > +			_notrun "this test requires a valid \$SCRATCH_DEV"
> > +		fi
> > +		echo $SCRATCH_DEV | grep -q "=/" > /dev/null 2>&1
> > +		if [ "$?" != "0" ]; then
> > +			echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
> > +			if [ "$?" != "0" ]; then
> 
> Why not combine two "if condition" into one, likes:
>   echo $SCRATCH_DEV | grep -Eq "=/|:/" >/dev/null 2>&1
>   if [ "$?" != "0" ] ....
> 
> (Sorry I didn't metion this last time...)
> 
> Same below:
>  

Fair enough -- that's more efficient too. I'll respin with that.

> > +				_notrun "this test requires a valid \$SCRATCH_DEV"
> > +			fi
> > +		fi
> > +		if [ ! -d "$SCRATCH_MNT" ]; then
> > +			_notrun "this test requires a valid \$SCRATCH_MNT"
> > +		fi
> > +		;;
> >  	pvfs2)
> >  		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
> >  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> > @@ -1770,7 +1785,7 @@ _require_test()
> >  			_notrun "this test requires a valid \$TEST_DIR"
> >  		fi
> >  		;;
> > -	nfs*|ceph)
> > +	nfs*)
> >  		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
> >  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> >  			_notrun "this test requires a valid \$TEST_DEV"
> > @@ -1779,6 +1794,21 @@ _require_test()
> >  			_notrun "this test requires a valid \$TEST_DIR"
> >  		fi
> >  		;;
> > +	ceph)
> > +		if [ -z "$TEST_DEV" ]; then
> > +			_notrun "this test requires a valid \$TEST_DEV"
> > +		fi
> > +		echo $TEST_DEV | grep -q "=/" > /dev/null 2>&1
> > +		if [ "$?" != "0" ]; then
> > +			echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
> > +			if [ "$?" != "0" ]; then
> > +				_notrun "this test requires a valid \$TEST_DEV"
> > +			fi
> > +		fi
> > +		if [ ! -d "$TEST_DIR" ]; then
> > +			_notrun "this test requires a valid \$TEST_DIR"
> > +		fi
> > +		;;
> >  	cifs)
> >  		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
> >  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> > -- 
> > 2.33.1
> > 
> 

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
