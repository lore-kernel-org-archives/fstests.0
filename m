Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F0C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 14:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiGHO4d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiGHO4b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 10:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2401F2F01A
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657292189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lADh6PzdBC167z9QTFgK04ZSS0jq0bgWIs1Uzt+2zkA=;
        b=J02AxHjabWOwU4B3+5ZzDKaiT/2NJF7wsQYWJLjNDBV8MsNrhfzjyNNlydyl0u478xR/GT
        DoEVrEA77rIbuAnm9EZSYJ/puWPZcfZLPttezsYVT80EHhSWbStNrWwjOTGm/IS9AP3ZRh
        HX+s8E/BaN154u1vfgJdEzRtw8HdhnU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-tZCRfW3RPu6ga8f1lnHhfg-1; Fri, 08 Jul 2022 10:56:26 -0400
X-MC-Unique: tZCRfW3RPu6ga8f1lnHhfg-1
Received: by mail-qk1-f200.google.com with SMTP id bk12-20020a05620a1a0c00b006b194656099so21054827qkb.5
        for <fstests@vger.kernel.org>; Fri, 08 Jul 2022 07:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lADh6PzdBC167z9QTFgK04ZSS0jq0bgWIs1Uzt+2zkA=;
        b=jFCZZO/xpea3jEu4NDtEKWgXqrG76nBHrCJ9YrlyWoFzR7gdRvXx/m43mNJ+W3uxzg
         GoiKTUx4q84vm4l+vOCbtS7HY5el3b/WC9u0TA+T2aRgSPwMb01DLyW4i1+4VsP4X5vy
         QchA/CM3bc/pYl33s6cCcKjTzOhwolbtImPoTjhg9138qBsaQIHBKLdOFJmvZAl2keSM
         TeKhEPHH89staN3kxcYv8kti186vKDRLND5FjOzlMozLgRXTNpxv8nV5BOGwgbS0tNiM
         Jp59MOdKcl9SnGKmKYoyn0jpwuOtZ/RjvNfAeLzJC/Y1K4/BNlVXYFGYHZLShfZbfgDr
         +iWA==
X-Gm-Message-State: AJIora9fxKh9Tp/w4qN3vUZ/CQgXK9LDhWSU8twqH1cnEljJYgg92JEv
        W4DA/NXtU6+HqDgzl1otVJ+Ev6nUPhoKb1bW4PVWJ+Spkx3Y/Xt1G7LvGO2FGVrvMC6GAjnzAOz
        xDEgVFGSvemtNPgKuXA==
X-Received: by 2002:a05:622a:188b:b0:31a:f57e:75c3 with SMTP id v11-20020a05622a188b00b0031af57e75c3mr3277878qtc.619.1657292185355;
        Fri, 08 Jul 2022 07:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s7z0EfziPI48HUZwQgiO5SOG5C7Bf0cDoKWGmkrMAbSTXPJjcPATpexwB4nQCOX26gFB68zA==
X-Received: by 2002:a05:622a:188b:b0:31a:f57e:75c3 with SMTP id v11-20020a05622a188b00b0031af57e75c3mr3277854qtc.619.1657292185058;
        Fri, 08 Jul 2022 07:56:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id fw3-20020a05622a4a8300b0031e7b06edbasm9420974qtb.67.2022.07.08.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:56:24 -0700 (PDT)
Date:   Fri, 8 Jul 2022 22:56:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/547: fix problems with realtime
Message-ID: <20220708145619.tlkwzme3xf3opyg5@zlang-mailbox>
References: <165705852280.2820493.17559217951744359102.stgit@magnolia>
 <165705853976.2820493.11634341636419465537.stgit@magnolia>
 <20220707131527.g73ablzdf7p7pmsu@zlang-mailbox>
 <YscgZQsgDjkgEkQM@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YscgZQsgDjkgEkQM@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 07, 2022 at 11:05:25AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 07, 2022 at 09:15:27PM +0800, Zorro Lang wrote:
> > On Tue, Jul 05, 2022 at 03:02:19PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > This test needs to fragment the free space on the data device so that
> > > each block added to the attr fork gets its own mapping.  If the test
> > > configuration sets up a rt device and rtinherit=1 on the root dir, the
> > > test will erroneously fragment space on the *realtime* volume.  When
> > > this happens, attr fork allocations are contiguous and get merged into
> > > fewer than 10 extents and the test fails.
> > > 
> > > Fix this test to force all allocations to be on the data device, and fix
> > > incorrect variable usage in the error messages.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/xfs/547 |   14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > 
> > > diff --git a/tests/xfs/547 b/tests/xfs/547
> > > index 9d4216ca..60121eb9 100755
> > > --- a/tests/xfs/547
> > > +++ b/tests/xfs/547
> > > @@ -33,6 +33,10 @@ for nrext64 in 0 1; do
> > >  		      >> $seqres.full
> > >  	_scratch_mount >> $seqres.full
> > >  
> > > +	# Force data device extents so that we can fragment the free space
> > > +	# and force attr fork allocations to be non-contiguous
> > > +	_xfs_force_bdev data $SCRATCH_MNT
> > > +
> > >  	bsize=$(_get_file_block_size $SCRATCH_MNT)
> > >  
> > >  	testfile=$SCRATCH_MNT/testfile
> > > @@ -76,13 +80,15 @@ for nrext64 in 0 1; do
> > >  	acnt=$(_scratch_xfs_get_metadata_field core.naextents \
> > >  					       "path /$(basename $testfile)")
> > >  
> > > -	if (( $dcnt != 10 )); then
> > > -		echo "Invalid data fork extent count: $dextcnt"
> > > +	echo "nrext64: $nrext64 dcnt: $dcnt acnt: $acnt" >> $seqres.full
> > > +
> > > +	if [ -z "$dcnt" ] || (( $dcnt != 10 )); then
> > 
> > I'm wondering why we need to use bash ((...)) operator at here, is $dcnt
> > an expression? Can [ "$dcnt" != "10" ] help that?
> 
> dcnt should be a decimal number, or the empty string if the xfs_db
> totally failed.  The fancy comparison protects against xfs_db someday
> returning results in hexadecimal or a non-number string, but I don't

Oh, it might be hexadecimal. OK, I'd like to respect the history reason.
So this looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> think it'll ever do that.  I think your suggestion would work for this
> case.
> 
> I don't think it works so well for the second case, since the fancy
> comparison "(( $acnt < 10 ))" apparently returns false even if acnt is
> non-numeric, whereas "[ $acnt -lt 10 ]" would error out.
> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > +		echo "Invalid data fork extent count: $dcnt"
> > >  		exit 1
> > >  	fi
> > >  
> > > -	if (( $acnt < 10 )); then
> > > -		echo "Invalid attr fork extent count: $aextcnt"
> > > +	if [ -z "$acnt" ] || (( $acnt < 10 )); then
> > > +		echo "Invalid attr fork extent count: $acnt"
> > >  		exit 1
> > >  	fi
> > >  done
> > > 
> > 
> 

