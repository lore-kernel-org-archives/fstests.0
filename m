Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE6DC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 23 May 2022 08:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiEWIKH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 May 2022 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiEWIKG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 May 2022 04:10:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EC3D5B
        for <fstests@vger.kernel.org>; Mon, 23 May 2022 01:10:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B16D21A11;
        Mon, 23 May 2022 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653293403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztsDDY/UgCsCi/AxVYbHfVyqVV20C5Q2vdqoLBrOJrM=;
        b=xIufwwbyTgLtWPd7f2tryG0SJ1W0/ET5webl1hmJdnnDFr3I4rU7m5EOFxrp546GbBn58C
        74F9hAAtaICI2WpgpJyq2gpTJLk5TMiqRAdRHyPjNuIOnPUc6Bq94d0eV0Vmyc/C4J4Sht
        omFp5fpe/i2zzoThdfV2gPOEkwyGFxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653293403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztsDDY/UgCsCi/AxVYbHfVyqVV20C5Q2vdqoLBrOJrM=;
        b=fbfpGqjH/rwmUBHnOJ5OaqhmwU+fDmqRiL0t7ib6XapCg5CpUElSGwpTp1TnC9qR3DgAup
        vsJgW9xquyDUGpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC29C13AA5;
        Mon, 23 May 2022 08:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c0EOM1pBi2JAOQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 23 May 2022 08:10:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id db32a75c;
        Mon, 23 May 2022 08:10:41 +0000 (UTC)
Date:   Mon, 23 May 2022 09:10:41 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ceph/002: fix test expected output
Message-ID: <YotBgUpOvgqNbGot@suse.de>
References: <20220520094709.30365-1-lhenriques@suse.de>
 <20220520123747.cbpeg6ox7orxmiqp@zlang-mailbox>
 <20220522095628.hgkhd2xchud4p3c5@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220522095628.hgkhd2xchud4p3c5@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 22, 2022 at 05:56:28PM +0800, Zorro Lang wrote:
> On Fri, May 20, 2022 at 08:37:47PM +0800, Zorro Lang wrote:
> > On Fri, May 20, 2022 at 10:47:09AM +0100, Luís Henriques wrote:
> > > Commit daa0c0146c7d ("fstests: replace hexdump with od command") broke
> > > ceph/002 by adding an extra '0' in the offset column.  Fix it.
> > > 
> > > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > > ---
> > 
> > Oh, that's my bad, I changed that in daa0c014 ("fstests: replace hexdump
> > with od command"), but write an extra '0' for ceph/002.out [1]. And due to
> > I don't test cephfs, so missed this failure. Thanks for fixing it!
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Hi Luís,
> 
> Sorry, I just noticed that I missed this one in this week fstests release, I'll
> merge and push it in next weekend (05.29) :)

Sure, no worries.  Thanks.

Cheers,
--
Luís

> 
> Thanks,
> Zorro
> 
> > 
> > [1]
> > ...
> > diff --git a/tests/ceph/002.out b/tests/ceph/002.out
> > index 6f067250..f7f1c0ba 100644
> > --- a/tests/ceph/002.out
> > +++ b/tests/ceph/002.out
> > @@ -1,8 +1,8 @@
> >  QA output created by 002
> > -0000000 6161 6161 6161 6161 6161 6161 6161 6161
> > +000000 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61  >aaaaaaaaaaaaaaaa<
> >  *
> > -0400000 6262 6262 6262 6262 6262 6262 6262 6262
> > +400000 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62  >bbbbbbbbbbbbbbbb<
> >  *
> > -0800000 6363 6363 6363 6363 6363 6363 6363 6363
> > +800000 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63  >cccccccccccccccc<
> >  *
> > -0c00000
> > +c000000
> > ...
> > 
> > >  tests/ceph/002.out | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/ceph/002.out b/tests/ceph/002.out
> > > index f7f1c0ba8487..4f766c257a9c 100644
> > > --- a/tests/ceph/002.out
> > > +++ b/tests/ceph/002.out
> > > @@ -5,4 +5,4 @@ QA output created by 002
> > >  *
> > >  800000 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63  >cccccccccccccccc<
> > >  *
> > > -c000000
> > > +c00000
> > > 
