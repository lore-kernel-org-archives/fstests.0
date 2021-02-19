Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEEAC4332B
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Feb 2021 16:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534B364EB7
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Feb 2021 16:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBSQBy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhBSQBu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Feb 2021 11:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613750422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=souXuc8m0pcVY/F97Df/ZfJkH8bfx48CfmoGARv0lSk=;
        b=Phykt4lx9fosy9KNBE6dDzXO3Dkp5lx0IZEY74rMgT6Y8Vz8OBbrrqwu9/glELtMk8o/Qb
        j82Jf1PTT9aEWnjEn3EAWgpCf2Jpl9IcH5psubJHsVUgSXSUd14XJ3Vzp6zLiRvYmoOpqx
        qwUSly1Ik8MO0gQnJ9ux7LGc++RAkd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-secHL-55MRS7dWni6GRaZw-1; Fri, 19 Feb 2021 11:00:20 -0500
X-MC-Unique: secHL-55MRS7dWni6GRaZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C936107ACE4
        for <fstests@vger.kernel.org>; Fri, 19 Feb 2021 16:00:19 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83D8D60873
        for <fstests@vger.kernel.org>; Fri, 19 Feb 2021 16:00:19 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7B8F057DF9;
        Fri, 19 Feb 2021 16:00:19 +0000 (UTC)
Date:   Fri, 19 Feb 2021 11:00:18 -0500 (EST)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Message-ID: <1231198452.69045907.1613750418825.JavaMail.zimbra@redhat.com>
In-Reply-To: <20210218134134.GM14354@localhost.localdomain>
References: <20210218085752.24123-1-xifeng@redhat.com> <20210218134134.GM14354@localhost.localdomain>
Subject: Re: [PATCH v3] common/rc: add filter in _test_inode_flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.72.13.144, 10.4.195.14]
Thread-Topic: common/rc: add filter in _test_inode_flag
Thread-Index: 3GkcS2+wnmtd2is94x2bnCDGUUIX/Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

----- Original Message -----
> From: "Zorro Lang" <zlang@redhat.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org
> Sent: Thursday, February 18, 2021 9:41:35 PM
> Subject: Re: [PATCH v3] common/rc: add filter in _test_inode_flag
> 
> On Thu, Feb 18, 2021 at 04:57:52PM +0800, XiaoLi Feng wrote:
> > From: Xiaoli Feng <xifeng@redhat.com>
> > 
> > Add _filter_testdir_and_scratch to avoid _test_inode_flag failed when
> > mount point contains flag string.
> > 
> > Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 649b1cfd..473188c1 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3112,7 +3112,7 @@ _test_inode_flag()
> >  	local flag=$1
> >  	local file=$2
> >  
> > -	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> > +	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_testdir_and_scratch |
> > grep -q "$flag" ; then
> 
> I can't understand that. Could you give us an example about why we need this
> filter before "quiet grep"? I think this line doesn't have any output
> (except xfs_io fails), so why a filter is needed?

Yes. this line doesn't have any output. But the return value is different. I send
this patch to fix the issue: If testdir or scratch_dir has "$flag". Then it will
always return 0. Even if this file doesn't have this "$flag".

Example:
 xfs_io -r -c 'lsattr -v' /daxmnt/fileB
[] /daxmnt/fileB
# xfs_io -r -c 'lsattr -v' /daxmnt/fileB | grep -q "dax"
# echo $?
0

fileB doesn't have dax flag. But _test_inode_flag will always return 0(expect 1).

Thanks.

> 
> Thanks,
> Zorro
> 
> >  		return 0
> >  	fi
> >  	return 1
> > --
> > 2.18.1
> > 
> 
> 

