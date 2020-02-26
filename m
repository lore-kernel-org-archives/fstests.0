Return-Path: <SRS0=K+9V=4O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06683C4BA0A
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Feb 2020 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45024650
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Feb 2020 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmOub0YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBZHcP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:32:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37298 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726903AbgBZHcP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Feb 2020 02:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582702334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KV5o+9PEGjiymDArFRgmcU3pMgNLdV19iuscLLAmRow=;
        b=KmOub0YVGbdj1Oyta/NUTgOCZ6XrWygiDusuJxwS/OVSzCWHh7384qM/w73nwXhCzqVV5n
        BWfgqo2iu4iCm7pHj8Q7Harxbr5TtRvXRI9aMZGqfOJt8GikLQRawQx5VTtqhRpH42rZVY
        xfNBXMz03tN6K07gY5sdxheyDBqrFxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-tt25OrrJOD6B_pMwDBVuww-1; Wed, 26 Feb 2020 02:32:12 -0500
X-MC-Unique: tt25OrrJOD6B_pMwDBVuww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B48F800D53
        for <fstests@vger.kernel.org>; Wed, 26 Feb 2020 07:32:11 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E90F9100164D
        for <fstests@vger.kernel.org>; Wed, 26 Feb 2020 07:32:10 +0000 (UTC)
Date:   Wed, 26 Feb 2020 15:42:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH V2 3/3] xfs/300: modify test to work on any fs block size
Message-ID: <20200226074245.GS14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <20200220200632.14075-1-jmoyer@redhat.com>
 <20200220200632.14075-4-jmoyer@redhat.com>
 <20200222053152.GM14282@dhcp-12-102.nay.redhat.com>
 <x49ftf0p073.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49ftf0p073.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 24, 2020 at 08:46:40AM -0500, Jeff Moyer wrote:
> Zorro Lang <zlang@redhat.com> writes:
> 
> > On Thu, Feb 20, 2020 at 03:06:32PM -0500, Jeff Moyer wrote:
> >> The test currently assumes a file system block size of 4k.  It will
> >> work just fine on any user-specified block size, though.
> >> 
> >> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> >> ---
> >>  tests/xfs/300 | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/tests/xfs/300 b/tests/xfs/300
> >> index 28608b81..4f1c927a 100755
> >> --- a/tests/xfs/300
> >> +++ b/tests/xfs/300
> >> @@ -50,8 +50,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 0 4096" $SCRATCH_MNT/attrvals >> $seqres.full
> >>  cat $SCRATCH_MNT/attrvals | attr -s name $SCRATCH_MNT/$seq.test >> $seqres.full 2>&1
> >>  
> >>  # Fragment the file by writing backwards
> >> +bs=$(_get_file_block_size $SCRATCH_MNT)
> >>  for I in `seq 6 -1 0`; do
> >> -	dd if=/dev/zero of=$SCRATCH_MNT/$seq.test seek=$I bs=4k \
> >> +	dd if=/dev/zero of=$SCRATCH_MNT/$seq.test seek=$I bs=${bs} \
> >
> > Although the original case won't fail on 64k test. But this change makes
> > more sense.
> 
> It will fail for the case mentioned in the cover letter.  That is:
> 
> MKFS_OPTIONS="-m reflink=0 -b size=65536" MOUNT_OPTIONS="-o dax"
> 
> on a system with >4k page size (xfs, in this case).

Thanks, good to know that :)

> 
> Thanks,
> Jeff
> 

