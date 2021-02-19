Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12612C433E6
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Feb 2021 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C979864E60
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Feb 2021 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBSQii (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhBSQi1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Feb 2021 11:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613752620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zoTQ9s87vigkcf3zkxEkdb/WxehKXi0k0H8kb0iq968=;
        b=GP8LQHhpOcvOuw3EwnFppXC9vCEbTP5kMSHH89Bx6NaC2hQJ9nx4qV8r/CH6tEkGUEH7vk
        ZH+uy5inCx52nxFcTd0aUf3t3w+XTNQfwfaysoGMBl5e1cQjoBdODJX9jAlYNq0lhJTA9r
        JPn0HC83D2nlYbRBtGe6ZQI7ZuFn6dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-BGehocNyPIGB4H2359gkZQ-1; Fri, 19 Feb 2021 11:36:58 -0500
X-MC-Unique: BGehocNyPIGB4H2359gkZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08C6185B665
        for <fstests@vger.kernel.org>; Fri, 19 Feb 2021 16:36:58 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E48160BE5;
        Fri, 19 Feb 2021 16:36:57 +0000 (UTC)
Date:   Sat, 20 Feb 2021 00:54:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Xiaoli Feng <xifeng@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] common/rc: add filter in _test_inode_flag
Message-ID: <20210219165438.GN14354@localhost.localdomain>
Mail-Followup-To: Xiaoli Feng <xifeng@redhat.com>, fstests@vger.kernel.org
References: <20210218085752.24123-1-xifeng@redhat.com>
 <20210218134134.GM14354@localhost.localdomain>
 <1231198452.69045907.1613750418825.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1231198452.69045907.1613750418825.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 19, 2021 at 11:00:18AM -0500, Xiaoli Feng wrote:
> Hi,
> 
> ----- Original Message -----
> > From: "Zorro Lang" <zlang@redhat.com>
> > To: "XiaoLi Feng" <xifeng@redhat.com>
> > Cc: fstests@vger.kernel.org
> > Sent: Thursday, February 18, 2021 9:41:35 PM
> > Subject: Re: [PATCH v3] common/rc: add filter in _test_inode_flag
> > 
> > On Thu, Feb 18, 2021 at 04:57:52PM +0800, XiaoLi Feng wrote:
> > > From: Xiaoli Feng <xifeng@redhat.com>
> > > 
> > > Add _filter_testdir_and_scratch to avoid _test_inode_flag failed when
> > > mount point contains flag string.
> > > 
> > > Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> > > ---
> > >  common/rc | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 649b1cfd..473188c1 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3112,7 +3112,7 @@ _test_inode_flag()
> > >  	local flag=$1
> > >  	local file=$2
> > >  
> > > -	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> > > +	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_testdir_and_scratch |
> > > grep -q "$flag" ; then
> > 
> > I can't understand that. Could you give us an example about why we need this
> > filter before "quiet grep"? I think this line doesn't have any output
> > (except xfs_io fails), so why a filter is needed?
> 
> Yes. this line doesn't have any output. But the return value is different. I send
> this patch to fix the issue: If testdir or scratch_dir has "$flag". Then it will
> always return 0. Even if this file doesn't have this "$flag".
> 
> Example:
>  xfs_io -r -c 'lsattr -v' /daxmnt/fileB
> [] /daxmnt/fileB
> # xfs_io -r -c 'lsattr -v' /daxmnt/fileB | grep -q "dax"
> # echo $?
> 0
> 
> fileB doesn't have dax flag. But _test_inode_flag will always return 0(expect 1).

Oh, got it. So the 'grep -q "dax"' is a litte inaccurate. If the mountpoint or
file name, or any sub-string in the $file contains "dax", this function will
return 0.

If that's the issue you're fixing, I think only filter SCRATCH_MNT and TEST_MNT
isn't enough. If we only care about the "attr" part output, how about filter
out junk (path name), only keep the [attr]?

Due to looks like the output format of 'lsattr -v' is: "[$attr] $filename" (correct
me if I'm wrong). So if we only keep the attr part, that can avoid the 'grep' find
"dax" from $filename.

Thanks,
Zorro

> 
> Thanks.
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >  		return 0
> > >  	fi
> > >  	return 1
> > > --
> > > 2.18.1
> > > 
> > 
> > 

