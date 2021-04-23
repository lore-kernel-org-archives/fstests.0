Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A90C433ED
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 12:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B3F61406
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 12:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhDWNAP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 09:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230305AbhDWNAP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 09:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619182778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trBzcXO0qqXfFlph4/0UId6KVMmGuGDaQkt/kqxhjBU=;
        b=ZR4jBRRIE0jP999JSohj6g7B6z6PiFfdpkVfC1ldA9KJLVFZWf0CeJFwoyYOuMCItN8oQf
        x6ExqYMyU1abZJ04doPFAl+aA90F9tvqYHTD5ibeFY5yVGKMyFtO7FNeqZSoQbMPxThPbJ
        X7vox+TM7FBJZFZ6Kclh9W4ISC8o8O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56--3M1I4wgMKe5ReJ0oTMUaQ-1; Fri, 23 Apr 2021 08:59:36 -0400
X-MC-Unique: -3M1I4wgMKe5ReJ0oTMUaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B68C802B40;
        Fri, 23 Apr 2021 12:59:35 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95B5C60C5A;
        Fri, 23 Apr 2021 12:59:35 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8E0CB1806D06;
        Fri, 23 Apr 2021 12:59:35 +0000 (UTC)
Date:   Fri, 23 Apr 2021 08:59:35 -0400 (EDT)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Message-ID: <458989954.6613238.1619182775243.JavaMail.zimbra@redhat.com>
In-Reply-To: <20210417165458.GA3122235@magnolia>
References: <20210417164655.64065-1-xifeng@redhat.com> <20210417165458.GA3122235@magnolia>
Subject: Re: [PATCH v1] common/rc: not run swapfile test for DAX
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.72.12.23, 10.4.195.20]
Thread-Topic: common/rc: not run swapfile test for DAX
Thread-Index: AREI/VsjaMaZFi1hrIlaJVpk66iM4A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

----- Original Message -----
> From: "Darrick J. Wong" <djwong@kernel.org>
> To: xifeng@redhat.com
> Cc: fstests@vger.kernel.org
> Sent: Sunday, April 18, 2021 12:54:58 AM
> Subject: Re: [PATCH v1] common/rc: not run swapfile test for DAX
> 
> On Sat, Apr 17, 2021 at 12:46:55PM -0400, xifeng@redhat.com wrote:
> > From: root <root@hp-dl385pg8-01.rhts.eng.pek2.redhat.com>
> > 
> > DAX doesn't support swapfile. Without this patch,
> > _require_scratch_swapfile always returns fail for fsdax. Now
> > change to notrun.
> > 
> > Signed-off-by: root <root@hp-dl385pg8-01.rhts.eng.pek2.redhat.com>
> 
> Who?

Please ignore it. It's added automatically by my client.

> 
> > ---
> >  common/rc | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 23f86ce6..d02b9f72 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2384,7 +2384,11 @@ _require_scratch_swapfile()
> >  	ext2|ext3|ext4|xfs)
> >  		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> >  			_scratch_unmount
> > -			_fail "swapon failed for $FSTYP"
> > +			if _normalize_mount_options | egrep -q "dax(=always| |$)"; then
> 
> Doesn't the STATX_ATTR_DAX test above take care of this?

Yes, need to consider STATX_ATTR_DAX. I will update it.

Thanks.

> 
> --D
> 
> > +				_notrun "swapfiles are not supported"
> > +			else
> > +				_fail "swapon failed for $FSTYP"
> > +			fi
> >  		fi
> >  		;;
> >  	*)
> > --
> > 2.27.0
> > 
> 
> 

