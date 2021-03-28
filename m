Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C4DC433C1
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 12:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FBA6196D
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 12:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhC1M4A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 08:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhC1Mzm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 08:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616936141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EieahCA1lWp7xkcc2ixHlkR3/KU57pahnoSFJxQiKVw=;
        b=hYovuXUiNv2jLFYt3/ny+3SxlYwYGwl4wP3gO7AxN0b1ouFUfGWVy9u733z9LU2MlLcwrF
        snmTPOY4Mfx7p9eqgUOITODc5tqWDxpjPzcBqJjhuWWpv/CY6DAxabIaci859BKebsn96W
        gZKyG/6jpSkhStKC4m+rVy2O1gCw3EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Bb3DyjrmMbWrGZFnM8GeDA-1; Sun, 28 Mar 2021 08:55:39 -0400
X-MC-Unique: Bb3DyjrmMbWrGZFnM8GeDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E30DF18C89CC
        for <fstests@vger.kernel.org>; Sun, 28 Mar 2021 12:55:38 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57A3A60C21;
        Sun, 28 Mar 2021 12:55:38 +0000 (UTC)
Date:   Sun, 28 Mar 2021 21:12:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org,
        xzhou@redhat.com
Subject: Re: [PATCH 4/5] generic/554: hide permision warning on exfat
Message-ID: <20210328131206.GN13946@localhost.localdomain>
Mail-Followup-To: Pavel Reichl <preichl@redhat.com>,
        fstests@vger.kernel.org, xzhou@redhat.com
References: <20210326154134.309159-1-preichl@redhat.com>
 <20210326154134.309159-5-preichl@redhat.com>
 <20210328130617.GM13946@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328130617.GM13946@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 28, 2021 at 09:06:17PM +0800, Zorro Lang wrote:
> On Fri, Mar 26, 2021 at 04:41:33PM +0100, Pavel Reichl wrote:
> > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > ---
> >  tests/generic/554 | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/554 b/tests/generic/554
> 
> If you'd like to filter this warning, besides generic/554, generic/472 [1] and
> generic/495 [2] have this warning too. But g/495 has more failures. I'm wondering

Oh, sorry, I read this patch before [PATCH 3/5]. Ignore this suggestion about
g/472 and g/495.

> is that worth testing swap on exfat filesystem ...
> 
> Thanks,
> Zorro
> 
> [1]
> --- /dev/fd/63	2021-03-18 04:33:53.788956817 -0400
> +++ generic/472.out.bad	2021-03-18 04:33:53.608956319 -0400
> @@ -1,4 +1,5 @@
>  QA output created by 472
> +mkswap: /mnt/xfstests/scratch/swap: insecure permissions 0755, 0600 suggested.
> ...
> 
> [2]
> --- /dev/fd/63	2021-03-18 04:53:17.762100589 -0400
> +++ generic/495.out.bad	2021-03-18 04:53:17.542100020 -0400
> @@ -1,5 +1,5 @@
>  QA output created by 495
> +mkswap: /mnt/xfstests/scratch/swap: insecure permissions 0755, 0600 suggested.
>  File with holes
> -swapon: Invalid argument
> ...
> 
> > index fa4f97d2..365628e2 100755
> > --- a/tests/generic/554
> > +++ b/tests/generic/554
> > @@ -46,7 +46,15 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $SCRATCH_MNT/file >> $seqres.full 2>&
> >  
> >  echo swap files return ETXTBUSY
> >  _format_swapfile $SCRATCH_MNT/swapfile 16m
> > -swapon $SCRATCH_MNT/swapfile
> > +if [ "$FSTYP" = "exfat" ]; then
> > +	# exfat does not support posix file permisions, so warning is
> > +	# to be expected
> > +	swapon $SCRATCH_MNT/swapfile 2>&1 |\
> > +		grep -v 'insecure permission' >> $seqres.full
> > +else
> > +	swapon $SCRATCH_MNT/swapfile
> > +fi
> > +
> >  $XFS_IO_PROG -f -c "copy_range -l 32k $SCRATCH_MNT/file" $SCRATCH_MNT/swapfile
> >  swapoff $SCRATCH_MNT/swapfile
> >  
> > -- 
> > 2.30.2
> > 

