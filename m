Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B7CC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 22 May 2022 09:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiEVJ4s (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 May 2022 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiEVJ4h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 May 2022 05:56:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C436A2B247
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 02:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69C8EB80AC0
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 09:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449C5C385AA;
        Sun, 22 May 2022 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653213393;
        bh=h+O2XSdXNv3pZwpjJxvw6iLFaVLJL0GrLc8xPJ1xARg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlyTbr3g2qrVWHjm2Ke+dTgjYI/Uj9eSKCMOkVySRFfTs4PVE4LS40FWdxBHQhdYt
         8mHqZAeViGFQ0pUis0IpiQnJDSJpw00NU8uAm/YTZpt3EPBW+fa+j02TAd8Aq9SohD
         pVcRdZ0BeXmT2sOTUOFR5wBcuEJ8aBywfMvqs/zUAFeJkz/KP0KKk5ooTivvzjQzVZ
         vQpdDudH8lBXr1HnYgwqux3wHIcl/lPixBAj5t4gp57P6rkpbdhqgKJRVEvAtTICX8
         RSj0fpZ2PGwJu8+Po6wbNV9sVrgxD+sysPtLTgmkYG8fLD5yOBZL2YZsuFdkS2W7iN
         2ruVoW1qeP2Ww==
Date:   Sun, 22 May 2022 17:56:28 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ceph/002: fix test expected output
Message-ID: <20220522095628.hgkhd2xchud4p3c5@zlang-mailbox>
References: <20220520094709.30365-1-lhenriques@suse.de>
 <20220520123747.cbpeg6ox7orxmiqp@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520123747.cbpeg6ox7orxmiqp@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 08:37:47PM +0800, Zorro Lang wrote:
> On Fri, May 20, 2022 at 10:47:09AM +0100, Luís Henriques wrote:
> > Commit daa0c0146c7d ("fstests: replace hexdump with od command") broke
> > ceph/002 by adding an extra '0' in the offset column.  Fix it.
> > 
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> 
> Oh, that's my bad, I changed that in daa0c014 ("fstests: replace hexdump
> with od command"), but write an extra '0' for ceph/002.out [1]. And due to
> I don't test cephfs, so missed this failure. Thanks for fixing it!
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Hi Luís,

Sorry, I just noticed that I missed this one in this week fstests release, I'll
merge and push it in next weekend (05.29) :)

Thanks,
Zorro

> 
> [1]
> ...
> diff --git a/tests/ceph/002.out b/tests/ceph/002.out
> index 6f067250..f7f1c0ba 100644
> --- a/tests/ceph/002.out
> +++ b/tests/ceph/002.out
> @@ -1,8 +1,8 @@
>  QA output created by 002
> -0000000 6161 6161 6161 6161 6161 6161 6161 6161
> +000000 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61  >aaaaaaaaaaaaaaaa<
>  *
> -0400000 6262 6262 6262 6262 6262 6262 6262 6262
> +400000 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62  >bbbbbbbbbbbbbbbb<
>  *
> -0800000 6363 6363 6363 6363 6363 6363 6363 6363
> +800000 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63  >cccccccccccccccc<
>  *
> -0c00000
> +c000000
> ...
> 
> >  tests/ceph/002.out | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/ceph/002.out b/tests/ceph/002.out
> > index f7f1c0ba8487..4f766c257a9c 100644
> > --- a/tests/ceph/002.out
> > +++ b/tests/ceph/002.out
> > @@ -5,4 +5,4 @@ QA output created by 002
> >  *
> >  800000 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63  >cccccccccccccccc<
> >  *
> > -c000000
> > +c00000
> > 
