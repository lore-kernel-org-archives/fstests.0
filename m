Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1001C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jun 2022 14:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiFGOaR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiFGOaP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jun 2022 10:30:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90951CE5C9
        for <fstests@vger.kernel.org>; Tue,  7 Jun 2022 07:30:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DA941F9B2;
        Tue,  7 Jun 2022 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654612213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYIytzpMLZzWQK02Azzxsya6ICCS/gc03kvF6uSKVMA=;
        b=xKCqqRCsm+CPY2jlx3knKqGV54kqV9Cuh4upMEXXmkKlVnUH7fLhIvRbLu0+HB1/AEg14e
        Nx9ocTX5oXIX/MNxNsjxzlwf2vSfklJ7D8lZ3DM/Nu1ORYZg9LdfSy60XVii6pVllB0v+k
        q2sNIvhdEVqWk0XiQPQ8XkAVYb+HifA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654612213;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYIytzpMLZzWQK02Azzxsya6ICCS/gc03kvF6uSKVMA=;
        b=lKdBJ4ERPZcii7mmG4ZbGqGI+VWyClowmTv5VuzLqRGxm0XOthn56fuJj2I7BVjteM2YWR
        Y7GU290FbjKkiXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0312513638;
        Tue,  7 Jun 2022 14:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +gW3OPRgn2IaRwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 07 Jun 2022 14:30:12 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c0f63e5d;
        Tue, 7 Jun 2022 14:30:54 +0000 (UTC)
Date:   Tue, 7 Jun 2022 15:30:54 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ceph/002: fix test expected output
Message-ID: <Yp9hHodpGwM+5ZKK@suse.de>
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
> 

Ping.  Looks like this hasn't yet been merged.  

Cheers,
--
Luís

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

