Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA8EB64DD
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Aug 2023 02:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHHCkN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Aug 2023 22:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHHCkJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2023 22:40:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57F1715
        for <fstests@vger.kernel.org>; Mon,  7 Aug 2023 19:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E25E62398
        for <fstests@vger.kernel.org>; Tue,  8 Aug 2023 02:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E20C433C7;
        Tue,  8 Aug 2023 02:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691462385;
        bh=g9o640JAR/smtwvF4fLL1HtY0/UmrUAe01tMBTtKhKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVJjV2k6PA/5XBJKHjcv9bVyypQMiKyl+ddwO5/xi+DsIPV/O/XJngxEurz4Ch8GN
         xlyeJwdz3mhn25Zc5g0IVM3n1BVUDD4JJ9UMeOa70ugWGeXCnD7ndakNKGiyK5xAM1
         XDTZJ91HGvz5dypbUR7VzpY7J0j8OU+ds/nIRuGW+DdctH0+zwSSWxKNPTWoFEKyeW
         U9McjXQhpbILLmR7NGTvFyI0zZUSkSnH9iWwhcpzteizGBlYzz8g6GMYTuBXlaqLof
         8sGMsjxWHouC0tde6BeKIYxyKOLkdMLCdatwDHbgh/rG3nA1D4kL+ww9U4QaoR1rmY
         BqyaCmiAWd/JQ==
Date:   Mon, 7 Aug 2023 19:39:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org,
        linkinjeon@kernel.org, sj1557.seo@samsung.com,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] common/rc: drop '-f' parameter from fsck.exfat
Message-ID: <20230808023944.GP11340@frogsfrogsfrogs>
References: <20230807112850.9198-1-ddiss@suse.de>
 <20230807174835.moxyuvx4mp47pvky@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807174835.moxyuvx4mp47pvky@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 08, 2023 at 01:48:35AM +0800, Zorro Lang wrote:
> On Mon, Aug 07, 2023 at 01:28:50PM +0200, David Disseldorp wrote:
> > fsck.exfat doesn't support the '-f' flag, so add a special case to
> > _repair_test_fs().
> 
> I'm wondering why _repair_scratch_fs() doesn't have the '-f', but the
> _repair_test_fs() has it. Looks like the '-f' option was for extN fs
> originally, it's not a fsck common option, but in fsck.ext4.
> 
> So I think the '-f' might not be a necessary option. As _repair_scratch_fs
> works without it, can we just remove the '-f' from _repair_test_fs()?
> 
> As _repair_test_fs was added by Ted, and _repair_scratch_fs was added
> by Darrick, so CC them to get more review -- do we real need the '-f'
> or not by default :)

I suspect that was just an ext4ism, since fsck itself doesn't document
any such option.

--D

> Thanks,
> Zorro
> 
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  common/rc | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 5c4429ed..ac7e50f1 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1229,6 +1229,14 @@ _repair_test_fs()
> >  			res=$?
> >  		fi
> >  		;;
> > +	exfat)
> > +		# exfat doesn't support -f
> > +		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
> > +		res=$?
> > +		if ((res < 4)); then
> > +			res=0
> > +		fi
> > +		;;
> >  	*)
> >  		# Let's hope fsck -y suffices...
> >  		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
> > -- 
> > 2.35.3
> > 
> 
