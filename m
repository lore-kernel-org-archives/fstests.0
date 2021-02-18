Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B208C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 08:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C24264E85
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 08:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBRIxe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Feb 2021 03:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhBRIu4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Feb 2021 03:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613638169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyl6AxSKsN8H3tkG0+mVAXcsHAOcMIxm7Ip91x4J1CY=;
        b=Su8OTCow+PuxVttynm1gVVjZns+AIVCt2ZheputE31Nvy5/iCqH++pfNjpWn7VcZ+BNCyZ
        yZOUSa+efOl6Vbu8PRwrYmKvaqD8E7QiE4ZzC/orCnw7v9M2HEhVe/+BIoXESU0vNkxiK4
        tOb9E1/mb7AtMJ79LmwPY6KzewKQFOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-qzWLh9dJMyuJgjEBq8CrBA-1; Thu, 18 Feb 2021 03:49:27 -0500
X-MC-Unique: qzWLh9dJMyuJgjEBq8CrBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A18AC291;
        Thu, 18 Feb 2021 08:49:26 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 539AD61F59;
        Thu, 18 Feb 2021 08:49:26 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4BA994EE4D;
        Thu, 18 Feb 2021 08:49:26 +0000 (UTC)
Date:   Thu, 18 Feb 2021 03:49:25 -0500 (EST)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Message-ID: <1889950590.68873831.1613638165514.JavaMail.zimbra@redhat.com>
In-Reply-To: <602E098E.9010509@cn.fujitsu.com>
References: <20210210083407.19184-1-xifeng@redhat.com> <602E098E.9010509@cn.fujitsu.com>
Subject: Re: [PATCH v2] common/rc: add filter in _test_inode_flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.72.13.144, 10.4.195.21]
Thread-Topic: common/rc: add filter in _test_inode_flag
Thread-Index: NllG/bwrHVAgXYlqIz1isRA31giHSw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

----- Original Message -----
> From: "Xiao Yang" <yangx.jy@cn.fujitsu.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org
> Sent: Thursday, February 18, 2021 2:30:38 PM
> Subject: Re: [PATCH v2] common/rc: add filter in _test_inode_flag
> 
> On 2021/2/10 16:34, XiaoLi Feng wrote:
> > From: Xiaoli Feng <xifeng@redhat.com>
> >
> > Add _filter_scratch and _filter_test_dir to avoid _test_inode_flag failed
> > when
> > mount point contains flag string.
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/rc b/common/rc
> > index 649b1cfd..f3bb665e 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3112,7 +3112,7 @@ _test_inode_flag()
> >  	local flag=$1
> >  	local file=$2
> >  
> > -	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> > +	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_scratch |
> > _filter_test_dir | grep -q "$flag" ; then
> Hi XiaoLi,
> 
> Is it ok to use _filter_testdir_and_scratch directly?

Yes, it's. _filter_testdir_and_scratch is better. Thanks for your reviewing.

> 
> Best Regards,
> Xiao Yang
> >  		return 0
> >  	fi
> >  	return 1
> 
> 
> 
> 

