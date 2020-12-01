Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5322CC64E7A
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Dec 2020 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47C42222A
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Dec 2020 16:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMSa62U6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391986AbgLAQGR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Dec 2020 11:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388498AbgLAQGR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Dec 2020 11:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606838690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxnZ5lhh8lFZ7pIwm+W8wTgupfO78lfU3+PUAveUGDQ=;
        b=GMSa62U6hCH8IZMG+cIUjJ/QOsaKGVDJbh5TpIBU23aAZrU62kMnmpoikIDvW0yH2Gf/de
        vuOzolMsDVlHTIhG+r7AHR/tXb6YuEVdaQDfgLVoeHL6hrNx/dYJQd79vn+JjKNREdcwXt
        zEyooKzCNz4dg1FS3fI3Q2YuRMf2g90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-yiXsBZMtMOeQDjZg0Pas8g-1; Tue, 01 Dec 2020 11:04:49 -0500
X-MC-Unique: yiXsBZMtMOeQDjZg0Pas8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1319100C663;
        Tue,  1 Dec 2020 16:04:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAC9D60C17;
        Tue,  1 Dec 2020 16:04:47 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CEFA74BB7B;
        Tue,  1 Dec 2020 16:04:47 +0000 (UTC)
Date:   Tue, 1 Dec 2020 11:04:46 -0500 (EST)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Message-ID: <1382422020.60382586.1606838686869.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201129081234.GP3853@desktop>
References: <20201123062526.18465-1-xifeng@redhat.com> <20201129081234.GP3853@desktop>
Subject: Re: [PATCH] common/rc: add _filter_scratch in _test_inode_flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.72.13.128, 10.4.195.30]
Thread-Topic: common/rc: add _filter_scratch in _test_inode_flag
Thread-Index: Klu7A4s53TIBr2UFxit0c4zEoVM5AQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

----- Original Message -----
> From: "Eryu Guan" <guan@eryu.me>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org
> Sent: Sunday, November 29, 2020 4:12:34 PM
> Subject: Re: [PATCH] common/rc: add _filter_scratch in _test_inode_flag
> 
> On Mon, Nov 23, 2020 at 02:25:26PM +0800, Xiaoli Feng wrote:
> > From: Xiaoli Feng <xifeng@redhat.com>
> > 
> > Avoid the invalid failure when the path of file include test flag.
> > 
> > Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> 
> Would you please elaborate this issue in more details? It seems your
> SCRATCH_MNT contains a string that matches $flag so _test_inode_flag
> returns a false positive. But that only fixes SCRATCH_MNT, what if
> TEST_DIR contains the string as well?

When test generic/608 for dax on xfs, "_check_xflag $t_file 0" is always 
failed if the $f_file has dax string. Yes, here should also include filter
for TEST_DIR.

> 
> Thanks,
> Eryu
> 
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index b5a504e0..04080331 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3069,7 +3069,7 @@ _test_inode_flag()
> >  	local flag=$1
> >  	local file=$2
> >  
> > -	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> > +	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_scratch | grep -q
> > "$flag" ; then
> >  		return 0
> >  	fi
> >  	return 1
> > --
> > 2.18.1
> 
> 

