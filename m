Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8AC433E9
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 03:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917F964DE7
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 03:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBJDh3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Feb 2021 22:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhBJDhZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Feb 2021 22:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612928159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bPAfUQl0bfR27AnV6qTE/G0PkGRxt8bRDc1miv+/nq8=;
        b=Kg9rjKA5bbMNGDtI60vOSpoPKU3ISxE3q3s5WY3Q/uxHXZQ8AwKb1A78kVsGZdImUyOBM/
        Jt6cYXxF5q0i9gm1dWZmSQkKYQFS9PUKrC2XwCRABvRNXMBxlGrfM+04fiSaCRR8Dds+NM
        E3trAvte5bc1JTYxEYQxmxNFK5T0LXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-sXGqki-INA6L2w2syaFIHQ-1; Tue, 09 Feb 2021 22:35:57 -0500
X-MC-Unique: sXGqki-INA6L2w2syaFIHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9469D192CC40;
        Wed, 10 Feb 2021 03:35:56 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87A105D745;
        Wed, 10 Feb 2021 03:35:56 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7AE6318095C7;
        Wed, 10 Feb 2021 03:35:56 +0000 (UTC)
Date:   Tue, 9 Feb 2021 22:35:55 -0500 (EST)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick wong <darrick.wong@oracle.com>
Message-ID: <1949261061.67988499.1612928155462.JavaMail.zimbra@redhat.com>
In-Reply-To: <60209375.8060802@cn.fujitsu.com>
References: <20210205141708.2558-1-xifeng@redhat.com> <60209375.8060802@cn.fujitsu.com>
Subject: Re: [PATCH v1] generic/608: verify S_DAX is active immediately for
 DONTCACHE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.72.12.16, 10.4.195.21]
Thread-Topic: generic/608: verify S_DAX is active immediately for DONTCACHE
Thread-Index: V3HJ+2EG30J6gGCYyfzrIluSW1uK1w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for reviewing. I will update it.

----- Original Message -----
> From: "Xiao Yang" <yangx.jy@cn.fujitsu.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org, "darrick wong" <darrick.wong@oracle.com>
> Sent: Monday, February 8, 2021 9:27:17 AM
> Subject: Re: [PATCH v1] generic/608: verify S_DAX is active immediately for DONTCACHE
> 
> Hi XiaoLi,
> 
> I prefer to update the existing tests because both writing drop_caches
> and remount are unnecessary since Li Hao's patches.
> test_drop_caches --> test_drop_cache
> test_cycle_mount --> test_nocache
> 
> The detail of test_drop_cache:
> -------------------------------
> test_caches()
> {
> local t_file=$SCRATCH_MNT/testfile
> 
> rm -f $t_file
> touch $t_file
> _check_xflag $t_file 0
> _check_s_dax $t_file 0
> 
> exec 3< $t_file
> 
> $XFS_IO_PROG -c 'chattr +x' $t_file
> _check_xflag $t_file 1
> _check_s_dax $t_file 0
> 
> # One application is using test file and check if S_DAX on
> # the file doesn't take effect immediately
> _check_s_dax $t_file 0
> 
> exec 3<&-
> 
> # No application is using test file and check if S_DAX on
> # the file takes effect immediately
> _check_s_dax $t_file 1
> }
> -------------------------------
> 
> Best Regards,
> Xiao Yang
> On 2021/2/5 22:17, XiaoLi Feng wrote:
> > From: Xiaoli Feng <xifeng@redhat.com>
> >
> > After upstream linux patches(77573fa310d, 88149082bb8), if
> > FS_XFLAG_DAX is set, DONTCACHE is also set. So S_DAX on the file
> > should be active immediately once FS_XFLAG_DAX is set.
> >
> > Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> > ---
> >  tests/generic/608 | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/tests/generic/608 b/tests/generic/608
> > index dd89d91c..278fb4d1 100755
> > --- a/tests/generic/608
> > +++ b/tests/generic/608
> > @@ -7,6 +7,7 @@
> >  # the file can take effect immediately by the following steps:
> >  # 1) Stop all applications which are using the file.
> >  # 2) Do drop_caches or umount & mount cycle.
> > +# 3) DONTCACHE is set.
> >  
> >  seq=`basename $0`
> >  seqres=$RESULT_DIR/$seq
> > @@ -91,6 +92,20 @@ test_cycle_mount()
> >  	_check_s_dax $t_file 0
> >  }
> >  
> > +test_nocache()
> > +{
> > +	local t_file=$SCRATCH_MNT/testnocache
> > +
> > +	rm -f $t_file
> > +	touch $t_file
> > +	_check_xflag $t_file 0
> > +	_check_s_dax $t_file 0
> > +
> > +	$XFS_IO_PROG -c 'chattr +x' $t_file
> > +	_check_xflag $t_file 1
> > +	_check_s_dax $t_file 1
> > +}
> > +
> >  do_tests()
> >  {
> >  	local mount_option=$1
> > @@ -100,6 +115,8 @@ do_tests()
> >  
> >  	test_drop_caches
> >  
> > +	test_nocache
> > +
> >  	test_cycle_mount "$cycle_mount_option"
> >  
> >  	_scratch_unmount
> 
> 
> 
> 

